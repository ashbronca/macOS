#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     setDock.sh
#
# Purpose:  Set the dock to remove all apps and add required apps 
#
# Usage:    macOS
#
# Version Date - AB - 13.5.21
#
#########################################################################################

##################################### Set variables #####################################



##################################### Run Script #######################################


#Remove all apps from the dock 
defaults write com.apple.dock persistent-apps -array

#Add apps to the dock
dockutil --add /System/Applications/Launchpad.app/
dockutil --add /Applications/Microsoft\ Outlook.app/
dockutil --add /Applications/Google\ Chrome.app/
dockutil --add /System/Applications/System\ Preferences.app/

