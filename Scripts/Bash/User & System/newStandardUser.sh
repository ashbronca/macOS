#!/bin/bash

##########################################################################################
#
# DESCRIPTION: Create a new standard user in macOS using Jamf or running as normal script. You can pass the parameters through to Jamf using the variables, or hardcode the information into the script.
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
scriptTitle="newStandardUser"

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Username
USERNAME="default" 

# Full Name
FULLNAME="Default"

# Password
PASSWORD="default123"

# Find out the next available user ID
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))

# check the OS X Version
OSXVERSION=$(sw_vers -productVersion | awk -F '.' '{print $1 "." $2}')


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

createUser() 
{
	
	# check OSVersion and create standard user
	
	{
		
		# Create a UID that is not currently in use
		echo "Creating an unused UID for new user..."
		
		#if osx is greater than 10.15 then run
		if [[ "$OSXVERSION" > "10.15" ]]; then
			echo "OS is greater than 10.15"
			sysadminctl -addUser $USERNAME -fullName "$FULLNAME" -UID=$USERID -password $PASSWORD
			
			#if osx less than 10.15 then run
			
		elif [[ "$OSXVERSION" < "10.15" ]]; then
			
			# Create the user account by running dscl
			echo "Creating necessary files..."
			
			dscl . -create /Users/$USERNAME
			dscl . -create /Users/$USERNAME UserShell /bin/bash
			dscl . -create /Users/$USERNAME RealName "$FULLNAME"
			dscl . -create /Users/$USERNAME UniqueID "$USERID"
			dscl . -create /Users/$USERNAME PrimaryGroupID 20
			dscl . -create /Users/$USERNAME NFSHomeDirectory /Users/$USERNAME
			dscl . -passwd /Users/$USERNAME $PASSWORD
			
			# Create the home directory
			echo "Creating home directory..."
			createhomedir -c 2>&1 | grep -v "shell-init"
			
		fi
		
		echo "Created user #$USERID: $USERNAME ($FULLNAME)"
		
		if [ $USERNAME == "thdadmin" ]; then
			dscl . create /Users/thadmin IsHidden 1
			echo "account hidden"
		fi
		
	} | /usr/bin/tee -a "${debugFile}"
}

##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup 
start 
createUser
finish


