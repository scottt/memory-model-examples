#include <assert.h>
#include <stdio.h>
#include <pthread.h>
#include <signal.h>
#include <stdlib.h>
#include <libgen.h>
#include <setjmp.h>
#include <stdbool.h>

enum {
	N = 60,
	N_THREADS = 2, /* must stay 2 */
};

struct algo_state {
	int x, y;
	bool t0_read_0, t1_read_0;
	pthread_barrier_t start_barrier, end_barrier;
	int condition_observed;
};
typedef struct algo_state algo_state;

char *program_name;
sigjmp_buf jmp_env;

void *thread0_func(void *data)
{
	int r, r0, t;
	algo_state *state = data;

	r = pthread_barrier_wait(&state->start_barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	t = 1;
	__atomic_store(&state->x, &t, __ATOMIC_RELAXED);
	__atomic_load(&state->y, &r0, __ATOMIC_RELAXED);
	if (r0 == 0)
		state->t0_read_0 = true;
	else
		state->t0_read_0 = false;

	r = pthread_barrier_wait(&state->end_barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	return NULL;
}

void *thread1_func(void *data)
{
	int r, r0, t;
	algo_state *state = data;

	r = pthread_barrier_wait(&state->start_barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	t = 1;
	__atomic_store(&state->y, &t, __ATOMIC_RELAXED);
	__atomic_load(&state->x, &r0, __ATOMIC_RELAXED);
	if (r0 == 0)
		state->t1_read_0 = true;
	else
		state->t1_read_0 = false;

	r = pthread_barrier_wait(&state->end_barrier);
	assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

	return NULL;
}

void sigint_handler(int sig, siginfo_t *siginfo, void *data)
{
	siglongjmp(jmp_env, 1);
}

int main(int argc, char **argv)
{
	pthread_t thread0, thread1;
	int r;
	int i;
	struct sigaction act = { {0} };
	algo_state state;

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

	state.condition_observed = 0;
	r = pthread_barrier_init(&state.start_barrier, NULL, N_THREADS + 1);
	assert(r == 0);

	r = pthread_barrier_init(&state.end_barrier, NULL, N_THREADS + 1);
	assert(r == 0);

	if (sigsetjmp(jmp_env, 1) != 0)
		goto loop_exit;
	r = pthread_sigmask(SIG_UNBLOCK, &sigset, NULL);
	assert(r == 0);

	{
		r = pthread_create(&thread0, NULL,  thread0_func, &state);
		assert(r == 0);

		r = pthread_create(&thread1, NULL,  thread1_func, &state);
		assert(r == 0);
		
	}

	for (i=0; i<N; i++) {
		state.x = 0;
		state.y = 0;

		r = pthread_barrier_wait(&state.start_barrier);
		assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);

		if (state.t0_read_0 && state.t1_read_0)
			state.condition_observed++;

		r = pthread_barrier_wait(&state.end_barrier);
		assert(r == 0 || r == PTHREAD_BARRIER_SERIAL_THREAD);
	}

	{
		r = pthread_join(thread0, NULL);
		assert(r == 0);

		r = pthread_join(thread1, NULL);
		assert(r == 0);
	}
loop_exit:
	printf("%s: condition_observed: %d\n", program_name, state.condition_observed);

	if (state.condition_observed)
		return 0;
	else
		return 1;

	return 0;
}
