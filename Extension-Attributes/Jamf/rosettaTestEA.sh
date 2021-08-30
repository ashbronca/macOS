#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     rosettaTestEA.sh
#
# Purpose:  Basic EA to test Rosetta 2
#
# Usage:    CLI | Jamf Pro
#
# Version 19-12-2020 
#
#########################################################################################

##################################### Set variables #####################################

# Check to see if the Mac needs Rosetta installed by testing the processor
processor=$(/usr/sbin/sysctl -n machdep.cpu.brand_string | grep -o "Intel")

##################################### Run Script #######################################


if [[ -n "$processor" && -f "/Library/Apple/System/Library/LaunchDaemons/com.apple.oahd.plist" ]] 
then
	echo "<result>Rosetta installed</result>"
else echo "<result>Rosetta not installed</result>"

fi
		
		
		