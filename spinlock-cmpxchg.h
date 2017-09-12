#ifndef SPINLOCK_CMPXCHG_H
#define SPINLOCK_CMPXCHG_H

void spin_lock(int *lock)
{
	int expected, t;
	t = 1;
	do {
		expected = 0;
	} while (!__atomic_compare_exchange(lock, &expected, &t, 1 /* weak */, __ATOMIC_ACQUIRE, __ATOMIC_ACQUIRE));
}

void spin_unlock(int *lock)
{
	int t = 0;
	__atomic_store(lock, &t, __ATOMIC_RELEASE);
}

#endif
