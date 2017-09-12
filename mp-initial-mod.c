#include <assert.h>
#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <libgen.h>
#include <setjmp.h>

enum {
	N = 1*1000*1000,
	N_THREADS = 2, /* must stay 2 */
};

jmp_buf jmp_env;
char *program_name;
int condition_observed;
int x, x_ready;

void *send(void *barrier)
{
	int r, t;
	
	t = 0;
	__atomic_store(&x_ready, &t, __ATOMIC_SEQ_CST);
	r = pthread_barrier_wait(barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	t = 42;
	__atomic_store(&x, &t, __ATOMIC_RELAXED);
	t = 1;
	__atomic_store(&x_ready, &t, __ATOMIC_RELAXED);
	return NULL;
}

void *receive(void *barrier)
{
	int r, r0, r1, t;

	t = 0;
	__atomic_store(&x, &t, __ATOMIC_SEQ_CST);
	r = pthread_barrier_wait(barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	__atomic_load(&x_ready, &r0, __ATOMIC_RELAXED);
	__atomic_load(&x, &r1, __ATOMIC_RELAXED);
	if (r0 == 1 && r1 == 0)
		return &x;
	else
		return NULL;
}

void sigint_handler(int sig, siginfo_t *siginfo, void *data)
{
	siglongjmp(jmp_env, 1);
}

int main(int argc, char **argv)
{
	pthread_t t0, t1;
	int i, r;
	pthread_barrier_t init_barrier;
	void *t1_ret;
	struct sigaction act = { {0} };
	sigset_t sigset;

	program_name = basename(argv[0]);

	r = sigemptyset(&sigset);
	assert(r == 0);
	r = sigaddset(&sigset, SIGINT);
	assert(r == 0);
	r = pthread_sigmask(SIG_BLOCK, &sigset, NULL);

	act.sa_sigaction = sigint_handler;
	act.sa_flags =
	r = sigaction(SIGINT, &act, NULL);
	assert(r == 0);

	condition_observed = 0;
	r = pthread_barrier_init(&init_barrier, NULL, N_THREADS);
	assert(r == 0);

	if (sigsetjmp(jmp_env, 1) != 0)
		goto loop_exit;
	r = pthread_sigmask(SIG_UNBLOCK, &sigset, NULL);
	assert(r == 0);
	for (i=0; i<N; i++) {
		x = 0;
		x_ready = 0;

		r = pthread_create(&t0, NULL, send, &init_barrier);
		assert(r == 0);

		r = pthread_create(&t1, NULL, receive, &init_barrier);
		assert(r == 0);

		r = pthread_join(t0, NULL);
		assert(r == 0);

		r = pthread_join(t1, &t1_ret);
		assert(r == 0);

		if (t1_ret)
			condition_observed++;
	}
loop_exit:
	printf("%s: condition_observed: %d\n", program_name, condition_observed);

	if (condition_observed)
		return 0;
	else
		return 1;
}
