#!/bin/bash

#Get Serial Number
serialnumber=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')

#Get OS Version on machine
OSVersion=$(sw_vers | awk '/ProductVersion/{print $2}')

#Get OS Version from API using a serial number variable 
jamfOSVersion=$(curl -sku API_user:password -X GET -H "accept: text/xml" "jamfURL/JSSResource/computers/serialnumber/$serialnumber" | xmllint --xpath "computer/hardware/os_version/text()" - )

#Test for OS version
if [[ $jamfOSVersion != $OSVersion ]]
then 
	sudo jamf recon
fi

