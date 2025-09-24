#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_SDRPP}" = y ]; then


chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src

	# Clone papr
	git clone ${GITHUB_F5OEO}/SDRPlusPlus
	cd /usr/local/src/SDRPlusPlus
	mkdir build && cd build && cmake .. -DOPT_BUILD_AIRSPYHF_SOURCE=OFF -DOPT_BUILD_HACKRF_SOURCE=OFF -DOPT_BUILD_HERMES_SOURCE=OFF \
	-DOPT_BUILD_RFSPACE_SOURCE=OFF -DOPT_BUILD_RTL_SDR_SOURCE=OFF -DOPT_BUILD_SPECTRAN_HTTP_SOURCE=OFF\
	 && make -j6 install
	
EOF

else
	echo "SDRPlusPlus won't be installed because CONFIG_SDRPP is set to 'n'."
fi
