#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     checkOS.sh
#
# Purpose:  Check OS version and relay to jamf 
#
# Usage:    CLI | Jamf Pro
#
# Version 15-11-20 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

macOSVersion=$( sw_vers -productVersion )
plist_macOSVersion=$( defaults read /Library/Application\ Support/AnyOrg/AnyOrg.plist macOSVersion )

##################################### Run Script #######################################

if [[ ! -f /Library/Application\ Support/AnyOrg/AnyOrg.plist ]]
then
	/usr/local/jamf/bin/jamf policy -event updateAnyOrgPlist -randomDelaySeconds 300
fi

if [[ $plist_macOSVersion != $macOSVersion ]]
then 
	/usr/local/jamf/bin/jamf recon -randomDelaySeconds 300 
	if [[ $? = 0 ]] 
	then 
		/usr/local/jamf/bin/jamf policy -event updateAnyOrgPlist 
	fi
fi