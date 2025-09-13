#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_SATDUMP}" = y ]; then


chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src

	# Clone papr
	git clone -b verywip https://github.com/SatDump/SatDump.git
	cd /usr/local/src/SatDump
	mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON  .. & make
	make install
EOF

else
	echo "maia won't be installed because CONFIG_SATDUMP is set to 'n'."
fi
