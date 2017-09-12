#include <assert.h>
#include <stdio.h>
#include <pthread.h>
#include <stdlib.h>
#include <unistd.h>

/* SPINLOCK_IMPL_HEADER is designed to be passed from the compiler command line */
#include SPINLOCK_IMPL_HEADER

enum {
	N = 10*1000*1000,
	MAX_THREADS = 1024,
};

struct algo_state {
	int lock;
	int x;
	int n_incremeants;
};
typedef struct algo_state algo_state;

void *thread_func(void *data)
{
	int i;
	algo_state *state = data;
	for (i=0; i<state->n_incremeants; i++) {
		spin_lock(&state->lock);
		state->x++;
		spin_unlock(&state->lock);
	}
	return NULL;
}

int main()
{
	int r, i, n_threads, total_incremeants;
	pthread_t thread[MAX_THREADS];
	algo_state state = { 0 };

	n_threads = sysconf(_SC_NPROCESSORS_ONLN);
	assert(n_threads != -1);

	state.n_incremeants = N / n_threads;
	total_incremeants = N - (N % n_threads);

	for (i=0; i<n_threads; i++) {
		r = pthread_create(&thread[i], NULL, thread_func, &state);
		assert(r == 0);
	}

	for (i=0; i<n_threads; i++) {
		r = pthread_join(thread[i], NULL);
		assert(r == 0);
	}

	if (state.x != total_incremeants) {
		fprintf(stderr, "ERROR: x: %d != %d\n", state.x, total_incremeants);
		exit(3);
	}
	return 0;
}
