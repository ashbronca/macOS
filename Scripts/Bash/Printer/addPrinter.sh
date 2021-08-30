#!/bin/bash

##########################################################################################
#
# DESCRIPTION
# Add printers via LDP
#
# AUTHOR  
# Ashley Bronca
#
##########################################################################################

##########################################################################################
################################### Global Variables #####################################
##########################################################################################


# Overall name of the script for logging
scriptTitle="addPrinter"

# Log directory
debugDir="/var/log"

# Log file
debugFile="${debugDir}/${scriptTitle}.log"

# Printer Name
printerName=""

# IP Address
IPAddress=""

# PPD location 
ppdLocation=""


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

addPrinter()
{
	
	# Adding printer
	
	{
		
		lpadmin -p ${printerName} -E -v lpd://${IPAddress} -P ${ppdLocation} -o printer-is-shared=false 
		
	} | /usr/bin/tee -a "${debugFile}"
	
}


##########################################################################################
#################################### End functions #######################################
##########################################################################################

setup
start 
addPrinter
finish 
