#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     autoReRunPolicyFailure.sh
#
# Purpose:  Automatically re run the policy if failed
#
# Usage:    CLI | Jamf Pro
#
# Version 09-10-19 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

counterFile="/private/tmp/jamftraining-counter"

##################################### Run Script #######################################


if [[ ! -f "$counterFile" ]]
then
	count=0
else
	count=$( cat "$counterFile" )
fi
(( count++ ))
echo "$count" > "$counterFile"
if [[ "$count" -lt 3 ]]
then
	echo "Policy retry attempt $count will be unsuccessful."
	exit 1
else
	echo "Policy retry attempt $count was successful."
	rm "$counterFile"
	exit 0
fi
