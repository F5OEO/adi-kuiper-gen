#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>





if [ "${CONFIG_MOSQUITTO}" = y ]; then


chroot "${BUILD_DIR}" << EOF

echo "allow_anonymous true" >> etc/mosquitto/mosquitto.conf
echo "listener 1883 0.0.0.0" >> etc/mosquitto/mosquitto.conf
echo "listener 9001" >> etc/mosquitto/mosquitto.conf
echo "protocol websockets" >> etc/mosquitto/mosquitto.conf


EOF

else
	echo "Mosquitto won't be installed because CONFIG_MOSQUITTO is set to 'n'."
	
fi


