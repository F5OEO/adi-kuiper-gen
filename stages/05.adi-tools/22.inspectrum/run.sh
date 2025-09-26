#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>





if [ "${CONFIG_INSPECTRUM}" = install_from_source ]; then

chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src
	git clone https://github.com/miek/inspectrum.git
	cd inspectrum
	mkdir build
	cd build
	cmake ..
	make -j7
	make install
		
EOF

else
	echo "Inspectrum won't be installed because CONFIG_INSPECTRUM is set to 'n'."
	
fi
