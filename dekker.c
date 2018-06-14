/* Demonstrate Store-Load reodering:
 *
 * int x = 0, y = 0;
 * {{ x = 1; r0 = y; || y = 1; r1 == x; }}
 * assert(r0 != 0 || r1 != 0);
 */

#include <assert.h>
#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <libgen.h>
#include <setjmp.h>

enum {
	N = 500*1000,
	N_THREADS = 2, /* must stay 2 */
};

char *program_name;
int condition_observed;
int x = 0, y = 0;
sigjmp_buf jmp_env;

void *thread0_func(void *barrier)
{
	int r, r0;

	r = pthread_barrier_wait(barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	x = 1;
	r0 = y;
	if (r0 == 0)
		return &x;
	else
		return NULL;
}

void *thread1_func(void *barrier)
{
	int r, r0;

	r = pthread_barrier_wait(barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	y = 1;
	r0 = x;
	if (r0 == 0)
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
	pthread_t thread0, thread1;
	int r, condition_observed;
	void *t0_ret, *t1_ret;
	int i;
	pthread_barrier_t init_barrier;
	struct sigaction act = { {0} };

	program_name = basename(argv[0]);

	sigset_t sigset;
	r = sigemptyset(&sigset);
	assert(r == 0);
	r = sigaddset(&sigset, SIGINT);
	assert(r == 0);
	r = pthread_sigmask(SIG_BLOCK, &sigset, NULL);
	assert(r == 0);

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
		y = 0;

		r = pthread_create(&thread0, NULL,  thread0_func, &init_barrier);
		assert(r == 0);

		r = pthread_create(&thread1, NULL,  thread1_func, &init_barrier);
		assert(r == 0);
		
		r = pthread_join(thread0, &t0_ret);
		assert(r == 0);

		r = pthread_join(thread1, &t1_ret);
		assert(r == 0);

		if (t0_ret && t1_ret)
			condition_observed++;
	}
loop_exit:
	printf("%s: condition_observed: %d\n", program_name, condition_observed);

	if (condition_observed)
		return 0;
	else
		return 1;

	return 0;
}
