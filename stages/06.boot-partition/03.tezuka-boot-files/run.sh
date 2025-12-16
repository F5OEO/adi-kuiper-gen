#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause
#
# kuiper2.0 - Embedded Linux for Analog Devices Products
#
# Copyright (c) 2024 Analog Devices, Inc.
# Author: Larisa Radu <larisa.radu@analog.com>

SERVER="https://github.com/F5OEO/tezuka_fw/releases/download"
VERSION="0.2.3"
TARGET_BOOT="${BUILD_DIR}"/usr/local/src/boot

if [ "${CONFIG_TEZUKA_BOOT_FILES}" = y ]; then
	

		mkdir -p $TARGET_BOOT
		cd $TARGET_BOOT
		wget --progress=bar:force:noscroll "$SERVER/$VERSION/antsdr_e200.zip"
		unzip antsdr_e200.zip -d antsdr_e200
		wget --progress=bar:force:noscroll "$SERVER/$VERSION/fishball.zip"
		unzip fishball.zip -d fishball
		wget --progress=bar:force:noscroll "$SERVER/$VERSION/fishball7020.zip"
		unzip fishball7020.zip -d fishball7020
		wget --progress=bar:force:noscroll "$SERVER/$VERSION/libresdr.zip"
		unzip libresdr.zip -d libresdr
		wget --progress=bar:force:noscroll "$SERVER/$VERSION/pluto.zip"
		unzip pluto.zip -d pluto
		wget --progress=bar:force:noscroll "$SERVER/$VERSION/plutoplus.zip"
		unzip plutoplus.zip -d plutoplus
		
		cd /

		#Common linux - Fixme : Linux build seems different
		#cp $TARGET_BOOT/fishball/sdimg/uImage "${BUILD_DIR}"/boot/
		#Common uEnv.txt
		cp $TARGET_BOOT/fishball/sdimg/uEnv.txt "${BUILD_DIR}"/boot/
		cp $TARGET_BOOT/fishball/sdimg/uramdisk.image.gz "${BUILD_DIR}"/boot/
		for dir in "$TARGET_BOOT"/* ; do
	        [ -d "$dir" ] || continue

    		dirname="${dir##*/}"
    	
			if [ -f "$dir/sdimg/BOOT.bin" ]; then
				# Crée le dossier cible dans /boot si nécessaire
				mkdir -p "${BUILD_DIR}"/boot/"$dirname"

				# Déplace le fichier
				cp "$dir/sdimg/BOOT.bin" "${BUILD_DIR}"/boot/"${dirname}"/
				cp "$dir/sdimg/devicetree.dtb" "${BUILD_DIR}"/boot/"${dirname}"/
				cp -r "$dir/sdimg/overclock" "${BUILD_DIR}"/boot/"${dirname}"/
				cp "$dir/sdimg/uImage" "${BUILD_DIR}"/boot/"${dirname}"/
				
				  
			fi
		done

		rm -r $TARGET_BOOT
	
else
	echo "Tezuka boot files won't be installed because CONFIG_TEZUKA_BOOT_FILES is set to 'n'."
fi
