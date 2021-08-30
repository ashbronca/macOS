#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     startOSInstall.sh
#
# Purpose:  Leverage the startOS install executable inside the OS Application
#
# Usage:    CLI | Jamf Pro
#
# Version 10-10-2020 - AB - Initial Creation
#
#########################################################################################

##################################### Set variables #####################################

OSVersion=$(sw_vers | awk '/ProductVersion/{print $2}')
installOS=$('/Applications/Install macOS Catalina.app/Contents/Resources/startosinstall' --eraseinstall --agreetolicense --forcequitapps --newvolumename 'Macintosh HD')
OSInstaller=$(sudo softwareupdate --fetch-full-installer --full-installer-version 10.15.7)

##################################### Run Script #######################################

#Get version and install OS
if [[ $OSVersion -ge "10.15.6" ]]
then 
	$OSInstaller
fi

#While loop whilst downloading
while [[ ! -e '/Applications/Install macOS Catalina.app' ]]
do 
	echo "Installer does not exist"
	sleep 10
done

sleep 3

#Push startosinstall command if the installer is there
if [[ -e '/Applications/Install macOS Catalina.app' ]]
then 
	$installOS
else
	echo "Installer not found"
fi
