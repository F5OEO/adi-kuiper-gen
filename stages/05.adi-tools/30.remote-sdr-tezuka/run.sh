if [ "${CONFIG_REMOTESDR}" = y ]; then


chroot "${BUILD_DIR}" << EOF
npm install -g express cors ejs xmlrpc socket.io
cd /usr/local/src
git clone https://github.com/F5OEO/Remote-SDR-Tezuka 
mv Remote-SDR-Tezuka/remsdr /remsdr
EOF

else
	echo "remotesdr won't be installed because REMOTESDR is set to 'n'."
	
fi