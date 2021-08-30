#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     fileVaultEA
#
# Purpose:  Extension Attribute for FileVault to test result
#
# Usage:    CLI | Jamf Pro
#
# Version 19-7-18 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

filevault=$(fdesetup status | awk '/FileVault is/{print $3}' | tr -d .)

##################################### Run Script #######################################

echo "<result>$filevault</result>"