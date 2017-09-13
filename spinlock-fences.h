#ifndef SPINLOCK_H
#define SPINLOCK_H

/* Lock Acquire implementation using SEQ_CST fence instead of acquire load.
 * Search for "Spinlock implementation" under ARMv7 in
 * https://www.cl.cam.ac.uk/~pes20/cpp/cpp0xmappings.html */
void spin_lock(int *lock)
{
	int expected, t;
	t = 1;
	do {
		expected = 0;
	} while (!__atomic_compare_exchange(lock, &expected, &t, 1 /* weak */, __ATOMIC_RELAXED, __ATOMIC_RELAXED));
	__atomic_thread_fence(__ATOMIC_SEQ_CST); /* ensures that all subsequent accesses are observed after the
	                                            gaining of the lock is observed */
}

void spin_unlock(int *lock)
{
	int t = 0;
	__atomic_thread_fence(__ATOMIC_SEQ_CST); /* ensure all previous accesses are observed
						    before lock is cleard */
	__atomic_store(lock, &t, __ATOMIC_RELAXED);
}

#endif
