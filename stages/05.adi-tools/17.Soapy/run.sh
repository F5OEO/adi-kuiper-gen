#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_SOAPY_TEZUKA}" = y ]; then


chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src

	# Clone papr
	git clone ${GITHUB_F5OEO}/SoapyPlutoPAPR
	cd /usr/local/src/SoapyPlutoPAPR
	mkdir build && cd build && cmake .. && make install
	
EOF

else
	echo "maia won't be installed because CONFIG_SOAPY_TEZUKA is set to 'n'."
fi
