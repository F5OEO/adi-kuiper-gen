#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

chroot "${BUILD_DIR}" << EOF
	# Add user 'analog' with password 'analog'
	adduser --disabled-password --shell=/bin/bash --gecos "" analog
	echo "analog:analog" | chpasswd
	echo "root:analog" | chpasswd
	chsh -s /bin/bash

	# Create the following groups
	for GRP in input spi i2c gpio; do
		groupadd -f -r \$GRP
	done
	
	# Add user 'analog' to the following groups
	for GRP in adm dialout cdrom audio sudo video plugdev input gpio spi i2c netdev render; do
		adduser analog \$GRP
	done

	# Set the name of the machine to 'analog'
	echo "tezuka" > /etc/hostname
	echo "127.0.1.1 tezuka" >> /etc/hosts

	# Set root PATH to all users for the desktop environment
	echo 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin' > /etc/environment
	
	# Set root PATH system wide for login shells
	sed -i 's/PATH=.*\/games/PATH="\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin/g' /etc/profile
	sed -i 's/PATH=.*\/games/PATH=\/usr\/local\/sbin:\/usr\/local\/bin:\/usr\/sbin:\/usr\/bin:\/sbin:\/bin/g' /etc/login.defs
EOF
