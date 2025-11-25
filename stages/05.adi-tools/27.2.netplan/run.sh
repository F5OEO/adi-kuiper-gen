#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


if [ "${CONFIG_NETPLAN}" = y ]; then

install -m 666 "${BASH_SOURCE%%/run.sh}/files/01.net.yaml" "${BUILD_DIR}/etc/netplan/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/10-dhcp-fallback" "${BUILD_DIR}/usr/lib/networkd-dispatcher/routable.d/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/90-usb-dhcprestart" "${BUILD_DIR}/etc/NetworkManager/dispatcher.d/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/isc-dhcp-server" "${BUILD_DIR}/etc/default/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/dhcpd.conf" "${BUILD_DIR}/etc/dhcp/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/resolv.conf" "${BUILD_DIR}/etc/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/iio_acm_generic.scheme" "${BUILD_DIR}/usr/local/etc/gt/adi/"


chroot "${BUILD_DIR}" << EOF
chmod u+s $(which ping)

chmod +x /usr/lib/networkd-dispatcher/routable.d/10-dhcp-fallback
chmod +x /etc/NetworkManager/dispatcher.d/90-usb-dhcprestart
										  
systemctl enable systemd.networkd
systemctl enable networkd-dispatcher
systemctl enable isc-dhcp-server

# Allowing ping for user
dpkg-reconfigure iputils-ping
EOF
else
	echo "tezuka_netplan won't be installed because CONFIG_NETPLAN is set to 'n'."
fi




