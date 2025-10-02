#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>





if [ "${CONFIG_READDSB}" = y ]; then


chroot "${BUILD_DIR}" << EOF
git clone https://github.com/wiedehopf/readsb
cd readsb
make AIRCRAFT_HASH_BITS=11 BLADERF=no HACKRF=no SOAPYSDR=yes RTLSDR=no PLUTOSDR=yes 
#install
cp readsb /usr/local/bin/
cp viewadsb /usr/local/bin/

EOF

else
	echo "readdsb won't be installed because CONFIG_READDSB is set to 'n'."
	
fi


