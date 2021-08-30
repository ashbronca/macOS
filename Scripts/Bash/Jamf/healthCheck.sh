#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     healthCheck.sh
#
# Purpose:  Determine the health of the machine leveraging jamf helper 
#
# Usage:    CLI | Jamf Pro
#
# Version 10-11-2020 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

healthCheck=$(curl -m 10 -ks https://jamfURL/healthCheck.html)
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"
messageToDisplay="health check notify"

##################################### Run Script #######################################

if [[ $healthCheck = "[]" ]]
then 
	"$jamfHelper" -windowType utility -description "$healthCheck" -button1 "OK" -button2 "Cancel"
	echo $healthCheck > /Users/Shared/healthCheck.txt
fi

