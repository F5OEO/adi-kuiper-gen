if [ "${CONFIG_OPENWEBRX}" = y ]; then


chroot "${BUILD_DIR}" << EOF

curl -s https://luarvique.github.io/ppa/openwebrx-plus.gpg | gpg --yes --dearmor -o /etc/apt/trusted.gpg.d/openwebrx-plus.gpg
bash -c 'echo "deb [signed-by=/etc/apt/trusted.gpg.d/openwebrx-plus.gpg] https://luarvique.github.io/ppa/bookworm ./" | tee /etc/apt/sources.list.d/openwebrx-plus.list'
apt update
apt install openwebrx
EOF

else
	echo "openwebrx won't be installed because CONFIG_CONFIG_OPENWEBRX is set to 'n'."
	
fi