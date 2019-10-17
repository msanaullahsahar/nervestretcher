#!/bin/bash
# Check if this script is run as root
if ! [ $(id -u) = 0 ]; then
   echo "This script must be run as root."
   exit 1
fi

# Delete old firmware if any
test -f Firmware.bin && sudo rm -rf Firmware.bin

sudo apt install python3-pip
sudo pip3 install esptool

clear

# Downloading Updated Firmware.
echo Downloading Updated Firmware.
sudo wget https://raw.githubusercontent.com/msanaullahsahar/nervestretcher/master/Firmware.bin

read -p "Please enter your COM port number [0 to 9]: "  portNumber
#portNumber=$(ls /dev/ttyUSB* | grep -o -E '[0-9]+')

echo ###############################################
echo Flashing firmware started.
esptool.py --port /dev/ttyUSB$portNumber write_flash 0x00000000 Firmware.bin
# Display Ok Box
whiptail --title "Check Terminal" --msgbox "Please see terminal for SUCCESS/FAILURE message." 8 78
exitstatus=$?
if [ $exitstatus = 0 ]; then
exit 1 || return 1
fi
