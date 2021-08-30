#!/bin/bash

##########################################################################################
#
# DESCRIPTION
# Test for FileVault and Firmware Password 
#
# AUTHOR
# Ashley Bronca
#
##########################################################################################

##########################################################################################
################################### Global Variables #####################################
##########################################################################################


# Overall name of the script for logging
scriptTitle="fileVault_firmwarePasswordCheck"

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Check FileVault Status
fileVaultStatus=$(fdesetup status | awk '{print $3}' | tr -d .)

# Check Firmware password status
firmwarePasswordOn=$(sudo firmwarepasswd -check | awk '{print $3}')


##########################################################################################
#################################### Start functions #####################################
##########################################################################################


setup()
{
	
	# Make sure we're root & creating logging file
	
	if [ "$(id -u)" != "0" ]
	then
		/bin/echo "This script must be run as root" 1>&2
		exit 1
	fi
	
	if [ ! -f "${debugFile}" ]
	then
		/usr/bin/touch "${debugFile}"
	fi
	
}

start()
{
	
	# Logging start
	
	{
		
		/bin/echo
		/bin/echo "###################-START-##################"
		/bin/echo
		/bin/echo "Running ${scriptTitle}"
		/bin/echo
		/bin/echo "Started: $(/bin/date)"
		/bin/echo
		
	} | /usr/bin/tee "${debugFile}"
	
}

finish()
{
	
	# Logging finish
	
	{
		
		/bin/echo
		/bin/echo "Finished: $(/bin/date)"
		/bin/echo
		/bin/echo "###################-END-###################"
		
	} | /usr/bin/tee -a "${debugFile}"
	
}

check()
{
	
	# test for status
	
	{
		
		if [[ $fileVaultStatus && $firmwarePasswordOn = "On" ]] 
		then 
			echo "Firmware Password and FileVault are enabled"
			
		elif [[ $fileVaultStatus || $firmwarePasswordOn = "On" ]] 
		then 
			echo "Only one of these are on - "
			
			if [[ $fileVaultStatus = "On" ]] 
			then 
				echo "FileVault is On"
			elif [[ $firmwarePasswordOn = "On" ]]
			then 
				echo "Firmware Password is Enabled"
			fi
		else
			echo "Neither of these are on"
		fi

		
	} | /usr/bin/tee -a "${debugFile}"
	
}


##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup 
start 
check
finish





