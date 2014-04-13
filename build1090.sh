#!/bin/bash -x

 if [ "$(id -u)" = "0"] then
 echo "You must be a Superuser to run this script. e.g run using sudo"
 exit 1
 fi

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
 sudo cp ./dump1090/dump1090.sh /etc/init.d/dump1090.sh
 sudo chmod +x /etc/init.d/dump1090.sh
 sudo update-rc.d dump1090.sh defaults

 /bin/cat << _EOF_ > /etc/modprobe.d/nortl.conf
 blacklist dvb_usb_rtl28xxu
 blacklist rtl2832
 blacklist rtl2830
 _EOF_

 sudo reboot
