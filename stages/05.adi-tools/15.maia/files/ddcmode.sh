#DDC out
sudo sh -c 'echo 0x800000BC 0x1 > /sys/kernel/debug/iio/iio:device3/direct_reg_access'
#Direct out
sudo sh -c 'echo 0x800000BC 0x1 > /sys/kernel/debug/iio/iio:device3/direct_reg_access'

#or via iio
sudo iio_reg cf-ad9361-lpc 0x800000BC 0x1
