CFLAGS := -O3 -Wall -g3 -I.
CXXFLAGS := $(CFLAGS)

LDFLAGS := -lpthread

NASM_FLAGS := -g -f elf
NASM_X64_FLAGS := -g -f elf64

HOST := $(shell $(CC) -dumpmachine)

PROGRAMS := $(basename $(wildcard *.asm *.c *.cc *.cpp *.s *.S *.f95))
PROGRAMS := $(filter-out lib%, $(PROGRAMS))
#PROGRAMS += $(addsuffix .so, $(basename $(wildcard lib*.S lib*.c)))

ifeq ($(findstring aarch64-,$(HOST)),)
PROGRAMS := $(filter-out spinlock-acq-rel,$(PROGRAMS))
PROGRAMS := $(filter-out spinlock-dmb,$(PROGRAMS))
endif

.PHONY: all clean
all: $(PROGRAMS)
%: %.c
	$(CC) $(CFLAGS) $< $(LDFLAGS) -o $@
%: %.s
	$(CC) -nostdlib $(CFLAGS) $(LDFLAGS) $< -o $@
%: %.S
	$(CC) -nostdlib $(CFLAGS) $(LDFLAGS) $< -o $@
%.o: %.S
	$(CC) $(ASFLAGS) $(CFLAGS) -c $< -o $@
%.so: %.S
	$(CC) -fPIC $(CFLAGS) -shared $(LDFLAGS) $< -o $@
%.so: %.c
	$(CC) -fPIC $(CFLAGS) -shared $(LDFLAGS) $< -o $@
%.o: %.asm
	nasm $(NASM_FLAGS) $< -o $@
%: %.f95
	f95 -g -Os -Wall $< -o $@
clean:
	rm -f $(PROGRAMS) *.o *.pyc core.*

.DELETE_ON_ERROR:

spinlock-cmpxchg: CFLAGS+=-DSPINLOCK_IMPL_HEADER='"spinlock-cmpxchg.h"'
spinlock-load-and-cmpxchg: CFLAGS+=-DSPINLOCK_IMPL_HEADER='"spinlock-load-and-cmpxchg.h"'
spinlock-fences: CFLAGS+=-DSPINLOCK_IMPL_HEADER='"spinlock-fences.h"'

ifeq ($(findstring aarch64-,$(HOST)),aarch64-)
spinlock-dmb: CFLAGS+=-DSPINLOCK_IMPL_HEADER='"spinlock-declaration-only.h"'
spinlock-dmb: spinlock-dmb.o lib-spinlock-dmb.o
	$(CC) $+ $(LDFLAGS) -o $@

spinlock-acq-rel: CFLAGS+=-DSPINLOCK_IMPL_HEADER='"spinlock-declaration-only.h"'
spinlock-acq-rel: spinlock-acq-rel.o lib-spinlock-acq-rel.o
	$(CC) $+ $(LDFLAGS) -o $@
endif
