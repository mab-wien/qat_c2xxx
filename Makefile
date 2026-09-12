export ICP_ROOT ?= $(PWD)
export ICP_ENV_DIR ?= $(ICP_ROOT)/quickassist/build_system/build_files/env_files
export ICP_BUILDSYSTEM_PATH ?= $(ICP_ROOT)/quickassist/build_system
JOBS := $(shell nproc 2>/dev/null || echo 1)


all:
	$(MAKE) -C quickassist all -j$(JOBS)

kmod:
	$(MAKE) -C quickassist lac -j$(JOBS)

clean:
	$(MAKE) -C quickassist clean

install_utils: all
	$(MAKE) -C quickassist install_utils

install_kmod:
	@dkms add $(ICP_ROOT)
	@dkms autoinstall

install: clean install_kmod install_utils
	@echo 'Installation complete.'


