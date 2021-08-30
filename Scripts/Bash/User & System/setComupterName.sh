#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     setComputerName.sh
#
# Purpose:  Set computer name leveraging jamf recon
#
# Usage:    CLI | Jamf Pro
#
# Version 10-8-2019 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

serialnumber=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

##################################### Run Script #######################################

#Set serial number as computer name 
jamf setComputerName -useSerialNumber $serialnumber

#Check in to update the computer name in Jamf 
sudo jamf recon

