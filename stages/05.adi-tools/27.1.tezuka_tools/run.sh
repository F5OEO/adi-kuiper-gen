#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


if [ "${CONFIG_TEZUKA_TOOLS}" = y ]; then

cp -r "${BASH_SOURCE%%/run.sh}"/files/	"${BUILD_DIR}/home/analog/tools/"
mkdir -p "${BUILD_DIR}/home/analog/.config/Gpredict" 
cp "${BASH_SOURCE%%/run.sh}"/gpredict.cfg "${BUILD_DIR}/home/analog/.config/Gpredict/"
#install -d -m 666 "${BUILD_DIR}/home/analog/.config/Gpredict"
#install -m 666 "${BASH_SOURCE%%/run.sh}"/gpredict.cfg "${BUILD_DIR}/home/analog/.config/Gpredict/"
#set anonymous
cp "${BASH_SOURCE%%/run.sh}/system.pa" "${BUILD_DIR}/etc/pulse/"
cp "${BASH_SOURCE%%/run.sh}/pulseaudio.service" "${BUILD_DIR}/etc/systemd/system/"
cp "${BASH_SOURCE%%/run.sh}/mqtt_tezuka.service" "${BUILD_DIR}/etc/systemd/system/"
cp "${BASH_SOURCE%%/run.sh}/journald.conf" "${BUILD_DIR}/etc/systemd/"
cp "${BASH_SOURCE%%/run.sh}/50-ip" "${BUILD_DIR}/etc/update-motd/"

chroot "${BUILD_DIR}" << EOF
systemctl --user disable pulseaudio.socket pulseaudio.service
systemctl enable pulseaudio
systemctl enable mqtt_tezuka
#upower is not needed
apt purge upower

cd /home/analog/
git clone --single-branch --branch throttle https://gitlab.com/gnuradio_book/flowcharts.git
# To be sure that everything under analog is owned by analog

chown -R analog:analog /home/analog 
chown -R analog:analog /home/analog/.config/Gpredict
# REMOVE SSH KEYS
#rm -rf /etc/ssh/*

EOF
else
	echo "tezuka_tools won't be installed because CONFIG_TEZUKA_TOOLS is set to 'n'."
fi




