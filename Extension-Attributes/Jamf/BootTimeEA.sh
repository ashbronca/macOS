#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     bootTimeEA
#
# Purpose:  Extension Attribute to show bootime 
#
# Usage:    CLI | Jamf Pro
#
# Version 11-10-20 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

bootTime=$(sysctl kern.boottime | awk '{print $5}' | tr -d ,)
bootTimeFormatted=$(date -jf %s $bootTime +%F\ %T)

##################################### Run Script #######################################

echo "<result>$bootTimeFormatted</result>"


