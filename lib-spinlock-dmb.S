	.section .text
	.global spin_lock
spin_lock:
	ldxr w5, [x0]      /* read lock */
	mov w1, #1
	cbnz w5, spin_lock /* check if 0 */
	stxr w5, w1, [x0]  /* attempt to store new value */
	cbnz w5, spin_lock /* test if store suceeded
	                      retry if not */
	dmb ish            /* ensures that all susequent accesses are observed after the
	                     gaining of the lock is observed */
	/* loads and stores in the critical region can now be performed */
	ret

	.global spin_unlock
spin_unlock:
	dmb ish            /* ensure all previous accesses are observed before lock is
	                      cleard */
	str wzr, [x0]      /* clear the lock */
	ret
