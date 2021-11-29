#!/bin/bash

##########################################################################################
#
# DESCRIPTION: Create a new admin user in macOS using Jamf or running as normal script. You can pass the parameters through to Jamf using the variables, or hardcode the information into the script.
# 
#
# AUTHOR
# Ashley Bronca
#
# VERSION
# 22.9.21
# 21.9.21
# 09.9.21
# 27.6.21
#
##########################################################################################

##########################################################################################
################################### Global Variables #####################################
##########################################################################################


# Overall name of the script for logging
scriptTitle="newAdminUser"

# SecureToken check

TokenValue=$(sysadminctl -secureTokenStatus testaccount 2>&1 | awk '{print$7}')

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Find out the next available user ID
MAXID=$(dscl . -list /Users UniqueID | awk '{print $2}' | sort -ug | tail -1)
USERID=$((MAXID+1))

# Check the OS X Version
OSXVERSION=$(sw_vers -productVersion | awk -F '.' '{print $1 "." $2}')

##########################################################################################
#################################### Start functions #####################################
##########################################################################################


readVariables() 
{
	
	# Read variables
	
		# New user account variables

		echo "Enter the new Full Name: "
		read FULLNAME
		echo "Enter the new username: "
		read USERNAME
		echo "Enter the new Password: "
		read PASSWORD

		# Secure Token variables

		echo "Enter the current secure token username for authentication"
		read adminUser
		echo "Enter the current secure token password for authentication"
		read adminPassword


	
}

setup()
{
	
	# Make sure we're root & creating logging file
	
	
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

createUser()
{
	
	# Test OSVersion and create user 
	
	{
		
		# Create a UID that is not currently in use
		echo "Creating an unused UID for new user..."

		#if osx is 10.15 then run
		if [[ "$OSXVERSION" == "10.15" ]] 
		then
			echo "OS is 10.15"
			sysadminctl -addUser $USERNAME -fullName "$FULLNAME" -UID=$USERID -password $PASSWORD
				
		#if osx is greater than 10.15 then run
		elif [[ "$OSXVERSION" > "10.15" ]]
		then
			echo "OS is greater than 10.15"
			sysadminctl -addUser $USERNAME -fullName "$FULLNAME" -UID=$USERID -password $PASSWORD
			
		#if osx less than 10.15 then run	
		elif [[ "$OSXVERSION" < "10.15" ]]
		then
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
		
		# Add user to any specified groups
		echo "Adding user to specified groups..."
		
		dscl . -append /Groups/admin GroupMembership $USERNAME
		
		echo "Created user #$USERID: $USERNAME ($FULLNAME)"
		
		if [ $USERNAME == "thdadmin" ]; then
			dscl . create /Users/thadmin IsHidden 1
			echo "account hidden"
			
		elif [ $USERNAME == "ladmin" ]; then
			dscl . create /Users/ladmin IsHidden 1
			echo "account hidden"
		fi
		
	} | /usr/bin/tee -a "${debugFile}"
	
}

addSecureToken()
{
	
	# Enable secureToken
	
	{
		
		echo "Enabling Secure Token"

		sysadminctl -secureTokenOn $USERNAME -password $PASSWORD -adminUser $adminUser -adminPassword $adminPassword

		echo "Secure Token Assigned!"

		
	} | /usr/bin/tee -a "${debugFile}"
	
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


##########################################################################################
#################################### End functions #######################################
##########################################################################################

readVariables
setup 
start 
createUser
addSecureToken
finish
