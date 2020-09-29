#!/bin/bash
# Santroll Re-ARM Installation Utility

tred=$(tput setaf 1)
tgreen=$(tput setaf 2)
tyellow=$(tput setaf 3)
tdef=$(tput sgr0)

backtitle="SanTroll Controller Re-ARMing Utility"
width=75
height=35

function main()
{
echo "Script Begin"
echo
echo "Cloning Repo"
echo
git clone https://github.com/NitroProp/Santroll_Re-ARM
echo

ask_cancel

if [ $CHOICEs = 0 ]
then
  inst_begin
else
  cancel
fi

}


function ask_cancel()
{
  local title="Lime Controller Re-ARMing"

  whiptail --backtitle "$backtitle" --yesno "`cat LICENSE`" --yes-button Continue --no-button Abort $height $width --fb
  CHOICEs=$?
}

function cancel()
{
   echo "Installation Aborted"
   exit 1

}

function inst_begin()
{
echo
echo "Changing Directory to ~"
echo
cd ~
echo
echo "Updating the System"
echo
apt-get update
echo
echo "Retrivig needed Softwares"
echo
PACKAGES="git autoconf libtool make pkg-config libusb-1.0-0 libusb-1.0-0-dev telnet"
apt-get install $PACKAGES -y
echo
echo "Cloning OpenOcd"
echo
git clone http://openocd.zylin.com/openocd
echo
echo "Changing Directory to openocd"
echo
cd openocd
echo
echo"Bootstrapping openocd"
echo
./bootstrap
echo
echo "Configuring openocd fot RPi GPIO"
echo
./configure --enable-sysfsgpio --enable-bcm2835gpio
echo
echo "Making openocd"
echo
make
echo
echo "Installing"
echo
sudo make install
echo
echo "Installation Completed"
}

main "$@"
