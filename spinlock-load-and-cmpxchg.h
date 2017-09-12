#ifndef SPINLOCK_H
#define SPINLOCK_H

static void spin_lock(int *lock)
{
	int expected, t;

	for (;;) {
		do {
			__atomic_load(lock, &expected, __ATOMIC_RELAXED);
		} while (expected);

		/* expected == 0 */
		t = 1;
		if (__atomic_compare_exchange(lock, &expected, &t, 1 /* weak */, __ATOMIC_ACQUIRE, __ATOMIC_ACQUIRE))
			break;
	}
}

static void spin_unlock(int *lock)
{
	int t = 0;
	__atomic_store(lock, &t, __ATOMIC_RELEASE);
}

#endif
