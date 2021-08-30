#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     readPolicy.sh
#
# Purpose:  Basic command driven script to read the policy that the user would like to run locally 
#
# Usage:    CLI | Jamf Pro
#
# Version 19-5-2019 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################



##################################### Run Script #######################################

read -p "What policy would you like to run? " policy_id 

sudo jamf policy -id $policy_id > /Users/Shared/policy_id.txt