#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>





if [ "${CONFIG_RTL433}" = y ]; then


chroot "${BUILD_DIR}" << EOF
git clone https://github.com/merbanan/rtl_433.git
cd rtl_433
mkdir build
cd build
cmake -DENABLE_SOAPYSDR=ON -DENABLE_RTLSDR=OFF ..
make
make install

EOF

else
	echo "rtl433 won't be installed because CONFIG_RTL433 is set to 'n'."
	
fi


