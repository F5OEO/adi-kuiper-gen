#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

# Set the default timezone to America, New York
chroot "${BUILD_DIR}" << EOF
	echo "Etc/UTC" > /etc/timezone
	rm /etc/localtime
	dpkg-reconfigure -f noninteractive tzdata
EOF
