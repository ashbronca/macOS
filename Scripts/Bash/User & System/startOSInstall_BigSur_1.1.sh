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

installOS=$('/Applications/Install macOS Big Sur.app/Contents/Resources/startosinstall' --eraseinstall --agreetolicense --forcequitapps --newvolumename 'Macintosh HD')
OSInstaller=$(sudo softwareupdate --fetch-full-installer --full-installer-version 11.5.2)

##################################### Run Script #######################################

# Check for OS and install

if [[ ! -e '/Applications/Install macOS Big Sur.app' ]];
	then 
		$OSInstaller
		
		while [[ ! -e '/Applications/Install macOS Big Sur.app' ]]
		do 
			echo "Installer does not exist"
			sleep 10
		done
		
		$installOS

elif [[ -e '/Applications/Install macOS Big Sur.app' ]]; 
	then
		$installOS
	else
		echo "Installer not found"
fi


