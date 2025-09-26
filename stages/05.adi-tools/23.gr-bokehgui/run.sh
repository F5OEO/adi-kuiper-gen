#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>





if [ "${CONFIG_GRBOKEH}" = y ]; then

chroot "${BUILD_DIR}" << EOF

	cd /usr/local/src
	pip install --no-deps --break-system-packages bokeh
	
 	git clone https://github.com/gnuradio/gr-bokehgui
	cd gr-bokehgui
	mkdir build && cd build
	cmake ../
	make -j7
	make install
		
EOF

else
	echo "Bokehgui won't be installed because CONFIG_GRBOKEH is set to 'n'."
	
fi


