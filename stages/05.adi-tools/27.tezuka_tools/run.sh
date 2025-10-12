#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


if [ "${CONFIG_TEZUKA_TOOLS}" = y ]; then

cp -r "${BASH_SOURCE%%/run.sh}"/files/	"${BUILD_DIR}/home/analog/tools/"
cp "${BASH_SOURCE%%/run.sh}"/default.pa "${BUILD_DIR}/home/analog/.config/pulse/"
else
	echo "tezuka_tools won't be installed because CONFIG_TEUKA_TOOLS is set to 'n'."
fi




