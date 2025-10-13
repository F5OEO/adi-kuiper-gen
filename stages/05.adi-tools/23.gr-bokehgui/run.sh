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
	pip install --no-deps --break-system-packages narwhals
	pip install --no-deps --break-system-packages bokeh
	
 	git clone https://github.com/gnuradio/gr-bokehgui
	cd gr-bokehgui
	mkdir -p build && cd build
	cmake ../ -DCMAKE_INSTALL_PREFIX=/usr
	make -j7
	make install
	mv /usr/lib/python3.11/site-packages/bokehgui /usr/lib/python3.11/dist-packages/bokehgui 
EOF

else
	echo "Bokehgui won't be installed because CONFIG_GRBOKEH is set to 'n'."
	
fi


