#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>


if [ "${CONFIG_MAIA}" = y ]; then
mkdir -p /home/analog/maia
cp -r "${BASH_SOURCE%%/run.sh}"/files/	"${BUILD_DIR}/home/analog/maia/"
install -m 644 "${BASH_SOURCE%%/run.sh}"/maia-httpd.service	"${BUILD_DIR}/lib/systemd/system/"
systemctl enable maia-httpd.service
else
	echo "maia won't be installed because CONFIG_MAIA is set to 'n'."
fi



if [ "${CONFIG_MAIA_SRC}" = y ]; then
#copy iqengine AND maiasdr.ko
cp -r "${BASH_SOURCE%%/run.sh}"/files/	"${BUILD_DIR}/home/analog/maia/"
#install httpmaia service
install -m 644 "${BASH_SOURCE%%/run.sh}"/maia-httpd.service	"${BUILD_DIR}/lib/systemd/system/"

chroot "${BUILD_DIR}" << EOF
	curl https://sh.rustup.rs -sSf | sh -s -- -y
	. "$HOME/.cargo/env"

	cd /usr/local/src

	# Clone maia
	#maia-httpd
	git clone -b sweep ${GITHUB_F5OEO}/maia-sdr
	cd /usr/local/src/maia-sdr/maia-httpd
	OPENBLAS_TARGET=armv7 OPENBLAS_HOSTCC=gcc OPENBLAS_CC=gcc OPENBLAS_FC=gfortran cargo build --release -j6 --target armv7-unknown-linux-gnueabihf 
	mkdir -p /home/analog/maia
	cp target/armv7-unknown-linux-gnueabihf/release/maia-httpd /home/analog/maia/
	cp util/* /home/analog/maia/

	#maia-wasm
	cd /usr/local/src/maia-sdr/maia-wasm
	cargo install wasm-pack
	wasm-pack build --target web
	
	mkdir -p /home/analog/maia/pkg
    cp -r pkg /home/analog/maia/
    cp assets/* /home/analog/maia/
	
	#Fixme maia-kmod not build, get from tezuka , need to change when kernel change (6.1 at the time)

	systemctl enable maia-httpd.service

EOF

else
	echo "maia won't be installed because CONFIG_MAIA_SRC is set to 'n'."
fi

#https://deepwiki.com/maia-sdr/maia-sdr/3.1-rest-api