#!/bin/bash

##########################################################################################
#
# DESCRIPTION
# Print the network segment 
#
# AUTHOR  
# Ashley Bronca
#
##########################################################################################

##########################################################################################
################################### Global Variables #####################################
##########################################################################################


# Overall name of the script for logging
scriptTitle="printNetworkSegment"

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Find starting IP Address
startingAddress=$( route -n get default | awk '/gateway/{print$2}' )

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


printSegment()
{
	
	# Print Network Segment 
	
	{
		
	
		loIP1=$( echo $startingAddress | awk -F '.' '{print$1}' )
		loIP2=$( echo $startingAddress | awk -F '.' '{print$2}' )
		loIP3=$( echo $startingAddress | awk -F '.' '{print$3}' )
		endingAddress=$loIP1.$loIP2.$loIP3.254
		printf "* Your Current Network Segment *\nStarting IP Address: $startingAddress\nEnding IP Address: $endingAddress\n"

	
	} | /usr/bin/tee -a "${debugFile}"
	
}


##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup 
start 
printSegment 
finish

