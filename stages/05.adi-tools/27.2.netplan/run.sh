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
install -m 666 "${BASH_SOURCE%%/run.sh}/files/isc-dhcp-server" "${BUILD_DIR}/etc/default/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/dhcpd.conf" "${BUILD_DIR}/etc/dhcp/"
install -m 666 "${BASH_SOURCE%%/run.sh}/files/resolv.conf" "${BUILD_DIR}/etc/"

chroot "${BUILD_DIR}" << EOF
chmod u+s $(which ping)

chmod +x /usr/lib/networkd-dispatcher/routable.d/10-dhcp-fallback

systemctl enable systemd.networkd
systemctl enable networkd-dispatcher
systemctl enable isc-dhcp-server

EOF
else
	echo "tezuka_netplan won't be installed because CONFIG_NETPLAN is set to 'n'."
fi




