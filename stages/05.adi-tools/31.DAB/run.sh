#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>





if [ "${CONFIG_DAB}" = y ]; then


chroot "${BUILD_DIR}" << EOF
cd /usr/local/src
git clone https://github.com/opendigitalradio/dab-scripts.git
bash dab-scripts/install/mmbtools-get --branch master install --odr-user analog

EOF

else
	echo "DAB won't be installed because CONFIG_DAB is set to 'n'."
	
fi


