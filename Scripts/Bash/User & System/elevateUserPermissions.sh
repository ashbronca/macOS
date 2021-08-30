#!/bin/bash

##########################################################################################
#
# DESCRIPTION: This script is used for root elevation for a standard user to an admin user in macOS. Please change "username" to the short username of the user you're wanting to change.
# 
#
# AUTHOR
# Ashley Bronca
#
##########################################################################################

##########################################################################################
################################### Global Variables #####################################
##########################################################################################


# Overall name of the script for logging
scriptTitle="ElevateUserPermissions"

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Username
username=""


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

elevateUser()
{
	
	# Elevate User Permissions
	
	{
		
		# Add the user in the admin group
		dscl . -append /groups/admin GroupMembership $username
		
	} | /usr/bin/tee -a "${debugFile}"
	
}


##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup 
start 
elevateUser
finish


