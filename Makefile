# SPDX-License-Identifier: GPL-2.0-or-later
#
# Makefile - AMD SFH HID drivers
# Copyright (c) 2019-2020, Advanced Micro Devices, Inc.
#
#
obj-$(CONFIG_AMD_SFH_HID) += amd_sfh_custom.o
amd_sfh_custom-objs := amd_sfh_hid.o
amd_sfh_custom-objs += amd_sfh_client.o
amd_sfh_custom-objs += amd_sfh_pcie.o
amd_sfh_custom-objs += hid_descriptor/amd_sfh_hid_desc.o
amd_sfh_custom-objs += sfh1_1/amd_sfh_init.o
amd_sfh_custom-objs += sfh1_1/amd_sfh_interface.o
amd_sfh_custom-objs += sfh1_1/amd_sfh_desc.o

# ccflags-y += -I $(srctree)/$(src)/
ccflags-y += -I $(src)/

KVER ?= $(shell uname -r)
KDIR ?= /lib/modules/$(KVER)/build
VERSION ?= 0.0.1

default:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules

clean:
	$(MAKE) -C $(KDIR) M=$(CURDIR) clean

install:
	$(MAKE) -C $(KDIR) M=$(CURDIR) modules_install

load:
	-/sbin/rmmod amd_sfh_custom
	/sbin/insmod amd_sfh_custom.ko

dkms-add: dkms.conf
	/usr/sbin/dkms add $(CURDIR)

dkms-build: dkms.conf
	/usr/sbin/dkms build amd_sfh_custom/$(VERSION)

dkms-install: dkms.conf
	/usr/sbin/dkms install amd_sfh_custom/$(VERSION)

dkms-remove: dkms.conf
	/usr/sbin/dkms remove amd_sfh_custom/$(VERSION) --all

modprobe-install:
	modprobe amd_sfh_custom

modprobe-remove:
	modprobe -r amd_sfh_custom

dev: modprobe-remove dkms-remove dkms-add dkms-build dkms-install modprobe-install