#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

if [ "${CONFIG_SIGDIGGER}" = y ]; then

#cp stages/05.adi-tools/21.sigdigger/blsd.sh "${BUILD_DIR}/usr/local/src/"

chroot "${BUILD_DIR}" << EOF
	cd /usr/local/src
	cp /stages/05.adi-tools/21.sigdigger/blsd.sh ./

	mount -t proc proc /proc
	bash ./blsd.sh 
	cp -r ./blsd-dir/SigDigger /usr/local/bin
	umount /proc	
EOF

else
	echo "SigDigger won't be installed because CONFIG_SIGDIGGER is set to 'n'."
fi
