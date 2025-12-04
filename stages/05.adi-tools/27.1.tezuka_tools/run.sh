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

cp "${BASH_SOURCE%%/run.sh}/pulseaudio.service" "${BUILD_DIR}/etc/systemd/system/"
cp "${BASH_SOURCE%%/run.sh}/mqtt_tezuka.service" "${BUILD_DIR}/etc/systemd/system/"
cp "${BASH_SOURCE%%/run.sh}/watch_ptt.service" "${BUILD_DIR}/etc/systemd/system/"
cp "${BASH_SOURCE%%/run.sh}/journald.conf" "${BUILD_DIR}/etc/systemd/"
cp "${BASH_SOURCE%%/run.sh}/50-ip" "${BUILD_DIR}/etc/update-motd/"
cp "${BASH_SOURCE%%/run.sh}/ntp.conf" "${BUILD_DIR}/etc/ntpsec/"
cp "${BASH_SOURCE%%/run.sh}/pipewire-pulse.conf" "${BUILD_DIR}/usr/share/pipewire/"
cp "${BASH_SOURCE%%/run.sh}/90set_pulseaudio_server" "${BUILD_DIR}/etc/X11/"

chroot "${BUILD_DIR}" << EOF
systemctl enable mqtt_tezuka
systemctl enable watch_ptt
#upower is not needed
apt purge upower

cd /home/analog/
git clone --single-branch --branch throttle https://gitlab.com/gnuradio_book/flowcharts.git
# REMOVE SSH KEYS
#rm -rf /etc/ssh/*

EOF
else
	echo "tezuka_tools won't be installed because CONFIG_TEZUKA_TOOLS is set to 'n'."
fi




