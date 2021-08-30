#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     notifyUser.sh
#
# Purpose:  Notify the user leveraging Jamf Helper with a custom message on the screen
#
# Usage:    CLI | Jamf Pro
#
# Version 20-11-2019 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

messageToDisplay="$4"
policyID="$5"
policyAction="$6" 
jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" 
buttonClicked=$( "$jamfHelper" -windowType utility -description "$messageToDisplay" -button1 "OK" -button2 "Cancel" ) 

##################################### Run Script #######################################

if [[ "$buttonClicked" = "0" ]];then
	su "$3" -c "open 'jamfselfservice://content?entity=policy&id=$policyID&action=$policyAction'"
fi