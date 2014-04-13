#!/bin/bash -x

 sudo apt-get -y update
 sudo apt-get -y upgrade

 sudo apt-get -y install git-core
 sudo apt-get -y install git
 sudo apt-get -y install cmake
 sudo apt-get -y install libusb-1.0-0-dev
 sudo apt-get -y install build-essential

 git clone git://git.osmocom.org/rtl-sdr.git
 cd rtl-sdr
 mkdir build
 cd build
 cmake ../ -DINSTALL_UDEV_RULES=ON
 make
 sudo make install
 sudo ldconfig
 cd ~
 sudo cp ./rtl-sdr/rtl-sdr.rules /etc/udev/rules.d/

 git clone git://github.com/MalcolmRobb/dump1090.git
 cd dump1090
 make
 cd ~
 sudo cp ./dump1090/dump1090.sh /etc/init.d/dump1090.sh
 sudo chmod +x /etc/init.d/dump1090.sh
 sudo update-rc.d dump1090.sh defaults

 printf 'blacklist dvb_usb_rtl28xxu\nblacklist rtl2832\nblacklist rtl2830\n' > nortl.conf
 
 sudo cp ./nortl.conf /etc/modprobe.d/notrl.conf

 sudo reboot
