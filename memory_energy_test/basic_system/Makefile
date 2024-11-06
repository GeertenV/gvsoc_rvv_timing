include ../utils/rt.mk

BUILDDIR = $(CURDIR)/build

clean:
	rm -f *.o $(BUILDDIR)/test
	make -C .. TARGETS=memory_energy_test_system MODULES=$(CURDIR) clean

all:
	mkdir -p $(BUILDDIR)
	riscv64-unknown-elf-gcc -o $(BUILDDIR)/test main.s $(RT_SRCS) $(RT_FLAGS)

gvsoc:
	make -C ../.. TARGETS=memory_energy_test_system MODULES=$(CURDIR) build

run:
	../../install/bin/gvsoc --target-dir=$(CURDIR) --target=memory_energy_test_system --work-dir=$(BUILDDIR) --binary=$(BUILDDIR)/test run $(runner_args)
