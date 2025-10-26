#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


if [ "${CONFIG_CLEAN_ROOTFS}" = y ]; then

rm -rf	"${BUILD_DIR}/usr/local/src/*"
rm -rf	"${BUILD_DIR}/usr/share/doc/*"

chroot "${BUILD_DIR}" << EOF

EOF
else
	echo "clean_rootfs won't be installed because CONFIG_CLEAN_ROOTFS is set to 'n'."
fi




