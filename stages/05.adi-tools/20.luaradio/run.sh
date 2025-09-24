#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_LUARADIO}" = y ]; then


chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src

	# Clone papr
	git clone https://github.com/vsergeev/luaradio.git
	cd /usr/local/src/luaradio/embed
	make install-lmod
	
EOF

else
	echo "Luaradio won't be installed because CONFIG_SOAPY_SDRPP is set to 'n'."
fi
