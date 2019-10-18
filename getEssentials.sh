#!/bin/bash
#if ! [ $(id -u) = 0 ]; then
#   echo "This script must be run as root."
#   exit 1
#fi
START=$(date +%s)

echo "This script will download dashboard and device's information."
# Remove the files if there were already downloaded.
sudo rm -rf dashboard.json nerve_stretcher.json myDevices.csv
echo -ne '\007'

# Fetch dashboard from GitHub
sudo wget "https://raw.githubusercontent.com/msanaullahsahar/nestv2/master/nerve_stretcher.json"

myName=$(whoami)
sudo chown -R $myName nerve_stretcher.json

# Modify dashboard file with new IP address for accessing camera in dashboard
read -p "What is your Raspberry-Pi's IP address? : "  rPiAddress
sudo sed -i -e "s/localhost/$rPiAddress/g" nerve_stretcher.json
sudo mv nerve_stretcher.json dashboard.json
sudo chown -R $myName dashboard.json

# Remove original dashboard file
sudo rm -rf nerve_stretcher.json
echo -ne '\007'

# Fetch Devices from GitHub
sudo wget "https://raw.githubusercontent.com/msanaullahsahar/nestv2/master/myDevices.csv"
sudo chown -R $myName myDevices.csv
# New line for spacing
echo You said your Raspberry-Pi\'s IP address is : $rPiAddress. If this is wrong, run this script again.
echo All Done! Press Ok to exit.

END=$(date +%s)
DIFF=$(( $END - $START ))
echo "It took $DIFF seconds to complete this installaion process."

echo -ne '\007'
# Display Ok Box
whiptail --title "Downloading Completed" --msgbox "Please check your folder for dashboard.json and myDevices.csv files." 8 78
exitstatus=$?
if [ $exitstatus = 0 ]; then
exit 1 || return 1
fi