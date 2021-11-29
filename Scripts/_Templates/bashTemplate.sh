#!/bin/bash


# Overall name of the script for logging
scriptTitle="XcodeCurl"

# Log directory
debugDir="/Users/$loggedInUser/Downloads"

# Log file
debugFile="${debugDir}/${scriptTitle}.sh"


##########################################################################################
#################################### Start functions #####################################
##########################################################################################


setup()
{
	
	# creating logging file
	
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

runScript()
{
	
	# Run Script
	
	{
		
		cd /Users/$loggedInUser/Downloads/
		curl --progress-bar "https://artifactory.srv.westpac.com.au/artifactory/A005C5_MOB/Xcode/$xcodeLocation" --output $xcodeLocation
		sudo pkill -a Terminal
		sudo rm -rf "/Users/$loggedInUser/Library/Saved Application State/com.apple.Terminal.savedState"
		
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


##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup 
start 
runScript 
finish