#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

echo "[Context Attributes]" > /etc/libiio.ini

model=`cat /sys/firmware/devicetree/base/model | tr / -`
echo "hw_model=$model" >> /etc/libiio.ini

serial=$(ip link show eth0 | awk '/ether/ {print $2}')
echo -e "hw_serial=$serial\n" >> /etc/libiio.ini
hostnamectl set-hostname "zukaneoper-$serial"

echo -e "fw_version=tezuka-0.1.8-2-g6f80\n" >> /etc/libiio.ini