if [ "${CONFIG_ACARSVDL}" = y ]; then


chroot "${BUILD_DIR}" << EOF
cd /usr/local/src
git clone https://github.com/szpajder/libacars.git
cd libacars
mkdir build && cd build
cmake ../
make install
ldconfig

cd /usr/local/src
git clone https://github.com/szpajder/dumpvdl2.git
cd dumpvdl2
mkdir build && cd build
cmake ../
make install

EOF

else
	echo "acarsvdl won't be installed because CONFIG_ACARSVDL is set to 'n'."
	
fi