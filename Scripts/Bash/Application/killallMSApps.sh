#!/bin/bash

##########################################################################################
#
# DESCRIPTION
# Kill all MS apps defined.
#
# AUTHOR  
# Ashley Bronca
#
##########################################################################################

##########################################################################################
################################### Global Variables #####################################
##########################################################################################


# Overall name of the script for logging
scriptTitle="killallMSApps"

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Apps to kill
processArray=(Excel OneNote Outlook PowerPoint Word)


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

killProcesses()
{
		
	# Kill the apps in the processArray, if running 

	{
	
	for runningProcess in "${processArray[@]}"
	do 
		if pgrep "Microsoft ${runningProcess}" > /dev/null; then
			Killall "Microsoft ${runningProcess}" && /bin/echo "Microsoft ${runningProcess} closed.";
		fi
	done
	
	} | /usr/bin/tee -a "${debugFile}"

}

##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup
start
killProcesses
finish


