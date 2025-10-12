if [ "${CONFIG_OPENWEBRX}" = y ]; then


chroot "${BUILD_DIR}" << EOF
cd /usr/local/src
git clone https://github.com/luarvique/openwebrx.git
cd openwebrx
./buildall.sh
dpkg -i ./owrx-output/*.deb
EOF

else
	echo "openwebrx won't be installed because CONFIG_CONFIG_OPENWEBRX is set to 'n'."
	
fi