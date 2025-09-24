#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


chroot "${BUILD_DIR}" << EOF
	#need for file explorer, new
	touch /home/analog/Templates/newfile.txt
	#needed by sigdigger for example to know how many proc in machine
	mount -t proc proc /proc
	#sed -i 's/^#\(kernel\.printk = 3 4 1 3\)/\1/' /etc/sysctl.conf
EOF
