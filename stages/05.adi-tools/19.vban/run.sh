#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_VBAN}" = y ]; then


chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src

	# Clone papr
	git clone https://github.com/quiniouben/vban
	cd /usr/local/src/vban
	./autogen.sh &&  ./configure --disable-jack --disable-pulseaudio && make && make install
	
EOF

else
	echo "Vban won't be installed because CONFIG_SOAPY_SDRPP is set to 'n'."
fi
