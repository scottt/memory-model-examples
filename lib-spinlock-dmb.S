	.section .text
	.global spin_lock
spin_lock:
	ldxr w5, [x0]     /* read lock */
	mov w1, #1
	cmp w5, #0        /* check if 0 */
	bne spin_lock
	stxr w5, w1, [x0] /* attempt to store new value */
	cmp w5, #0        /* test if store suceeded */
	bne spin_lock     /* retry if not */
	dmb ish           /* ensures that all susequent accesses are observed after the
	                     gaining of the lock is observed */
	/* loads and stores in the critical region can now be performed */
	ret

	.global spin_unlock
spin_unlock:
	dmb ish          /* ensure all previous accesses are observed before lock is
	                    cleard */
	str wzr, [x0]    /* clear the lock */
	ret
