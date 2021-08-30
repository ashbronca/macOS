#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     fileTest.sh
#
# Purpose:  Run a file test passing the first 3 parameters through to Jamf - leveraging Jamf Helper
#
# Usage:    CLI | Jamf Pro
#
# Version 15-11-2020 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

file_exists="$4"
jamf_message="$5"
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

##################################### Run Script #######################################

if [[ -f $file_exists ]]
then 
	"$jamfHelper" -windowType utility -description "$jamf_message" -button1 "OK"
fi 