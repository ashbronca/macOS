#!/bin/bash

#########################################################################################
# Author:   Ashley Bronca - Tech Help Direct
# Name:     startosinstall_M1
#
# Purpose:  Erase the volume that you boot from while preserving the others. Script modifed for M1 Machines
#
# Usage:    macOS
#
# Version Date - AB - 13.5.21
#
#########################################################################################

##################################### Set variables #####################################

#* * * * Edit the echo password - match it to your current admin password on your Mac.
#* * * * Edit the --newvolumename option to match the name of the volume you are currently using on your Mac.


##################################### Run Script #######################################

echo 'Apple321!!!' | /Volumes/Data/Install\ macOS*/Contents/Resources/startosinstall --eraseinstall --agreetolicense --newvolumename MacintoshHD --preservecontainer --user $USER --stdinpass
