#!/bin/bash
# Find COM port
bold=$(tput bold)
normal=$(tput sgr0)
portNumber=$(ls /dev/ttyUSB* | grep -o -E '[0-9]+')
#echo Your nerve stretcher is connected to your PC/laptop via port ${bold} $portNumber ${normal}. 
echo -e Your nerve stretcher is connected to your PC/laptop via port "\033[5m$portNumber\033[0m"