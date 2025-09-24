#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_SATDUMP}" = y ]; then


#git clone -b verywip https://github.com/SatDump/SatDump.git "${BUILD_DIR}/usr/src/SatDump"
#cp stages/05.adi-tools/16.SatDump/CMakeLists.txt /usr/local/src/SatDump/src-core/

chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src

	# Clone papr
	git clone -b verywip https://github.com/SatDump/SatDump.git
	#cp /stages/05.adi-tools/16.SatDump/CMakeLists.txt /usr/local/src/SatDump/src-core/
	cd /usr/local/src/SatDump
	mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release -DBUILD_SHARED_LIBS=ON  ..
	#dirty trick to add necessary flags
	sed -i '/^ASM_FLAGS =/ s/$/ -Wa,-mimplicit-it=always/' src-core/CMakeFiles/satdump_core.dir/flags.make
	make -j6
	make install
EOF

else
	echo "SatDump won't be installed because CONFIG_SATDUMP is set to 'n'."
fi
