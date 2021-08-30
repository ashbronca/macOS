#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     supressBigSurNotifications.sh
#
# Purpose:  This script aims to supress the notifications from big sur upgrade. The plist will re-write itself when sys prefs has been re-opened as the cprefsd file will update.
#
# Usage:    CLI | MacOS
#
# Version 11-10-2020 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################



##################################### Run Script #######################################

#kill system preferences 
killall “System Preferences”

#supress Big Sur OS upgrade
softwareupdate --ignore "macOS Big Sur" 

#supress Catalina OS upgrade
softwareupdate --ignore 'macOS Catalina'

sleep 3

#delete notification badge and banner
defaults delete com.apple.systempreferences AttentionPrefBundleIDs
defaults delete com.apple.systempreferences DidShowPrefBundleIDs

#Remove softwareupdate plist
rm ~/Library/Preferences/com.apple.preferences.softwareupdate.plist

#Path to the installer
installerPath="/Applications/Install macOS Catalina"

#if statement to remove installer 
if [[ -e $installerPath ]]
then 
	rm -rf $installerPath
else
	echo "Installer not found"
fi 

killall Dock






