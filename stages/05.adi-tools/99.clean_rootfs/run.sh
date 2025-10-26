#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


if [ "${CONFIG_CLEAN_ROOTFS}" = y ]; then

chroot "${BUILD_DIR}" << EOF
echo cleaning...

rm -r /usr/local/src/*
rm -r /usr/share/doc/*

EOF
else
	echo "clean_rootfs won't be installed because CONFIG_CLEAN_ROOTFS is set to 'n'."
fi




