


####################### JAMF #######################




#CURL


	#Flag						Explanation

	--max-time or -m 			#Maximum time–in second–for the operation to complete.
	--insecure or -k			#Perform insecure SSL connections and transfers.
	--silent or -s 				#Do not show a progress meter or error messages.
	--user or -u 				#Specify the user name and password to use for server authentication.
	--header or -H 				#Extra header to include in the request when sending a request.
	--request or -X 			#Specify a custom request method to use when communicating with an HTTP server.
	--data or -d 				#Send data in a POST or PUT request to an HTTP server.
	--form or -F 				#Enable uploading of binary files to an HTTP server.


#API 


	#Get all computers

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/computers

	#Get all sites and output to a file

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/sites -o /PATH/TO/FILE

	#Get a mobile device and pretty-print the output

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/mobiledevices/id/3000 | xmllint --format -

	#Get a mobile device and find the building

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/mobiledevices/id/3000 | xmllint --xpath '/mobile_device/location/building/text()' -

	#Find the buildling of a mobile device

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/mobiledevices/id/3000 | xmllint --xpath '//building/text()' -

	#Get all categories

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/categories

	#Update the site for a mobile device with an ID of 3000

		curl -sku USERNAME:PASSWORD -H "content-type: text/xml" https://JAMF_PRO_URL/JSSResource/mobiledevices/id/3000 -X PUT -d "<mobile_device><general><site><name>Production</name></site></general></mobile_device>"

	#Create a new category with a priority of one (1)

		curl -sku USERNAME:PASSWORD -H "content-type: text/xml" https://JAMF_PRO_URL/JSSResource/categories/id/0 -X POST -d "<category><name>Updates</name><priority>1</priority></category>"

	#Upload a file to the computer with an ID of 3000

		curl -sku USERNAME:PASSWORD https://JAMF_PRO_URL/JSSResource/fileuploads/computers/id/3000 -X POST -F name=@/PATH/TO/FILE

	#Delete the Staging site

		curl -sku USERNAME:PASSWORD -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/sites/name/Staging -X DELETE


#VARIABLES


	#Assign a variable

		var=4

	#Expand a variable

		echo "$var"


#COMMAND SUBSTITUTION 


	#Print the serial number for your computer

		system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}'

	#Define a variable from the output of a command

		macSerial=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')


#PARAMTERS


	#Recall parameters

		echo "The first parameter for the script $0, is $1"

	#Redefine a parameter to a named variable

		mountPoint="$1"
		computerName="$2"
		userName="$3"

	#Check for a file and display a message

		#!/bin/bash
		fileToCheck="$4"
		messageToDisplay="$5"
		jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper" 
		if [[ -e "$fileToCheck" ]];then
		  "$jamfHelper" -windowType utility -description "$messageToDisplay" -button1 "OK"
		fi

	#Run local script as if running in JSS - it runs the script as if it ran from the JSS with passed paramaters to $4 and $5

		sudo jamf runScript -script myscript.sh -path ~/Desktop -p1 "parameter1" -p2 "parameter2"


#CREATE FILES


	#Redirects

		#Print a string to a file without a trailing newline

			echo -n "jamfadmin:jamf1234" > /PATH/TO/FILE

		#Redirect the output of a command to a file

			date > /PATH/TO/FILE

		#Append the output of a command to a file

			date >> /PATH/TO/FILE



#READ


	#Text Input

		#Read text input to a named variable

			read -p "What's your name? " CUSTOM_VARIABLE_HERE

	#File Redirect

		#Read from a file to a named variable

			read id < /PATH/TO/FILE

		#Change the internal field separator and expand fields to named variables

			IFS=,
			read id name site < /PATH/TO/FILE
			echo "Computer $id in $site belongs to $name"


#CAT


	#Pipe the output from a command to another command

		cat /PATH/TO/FILE | base64


#DISPLAY DATE AND TIME


	#Syntax 	Use

	-j 			#Don't set the system time
	-f 			#Specify input format
	%s 			#UNIX epoch time
	+ 			#Output format
	%F 			#Full date (YYYY-MM-DD)
	%T 			#Time (hh:mm:ss)

	#Print the date in UNIX epoch time

		date +%s

	#Print the date in YYYY-MM-DD hh:mm:ss

		date +%F\ %T


#JAMFHELPER


	#View the help documentation for jamfHelper

		./jamfHelper -help

	#Path to jamfHelper as a variable

		jamfHelper="/Library/Application Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper"

	#Display a simple message with two buttons

		./jamfHelper -windowType utility -description "Click OK to begin installation" -button1 "OK" -button2 "Cancel"

	#Display a message with icon

		./jamfHelper -windowType utility -description "Click Next to continue..." -icon /PATH/TO/FILE -button1 "Next"


#TEST EXPRESSIONS


	#True If Values Equal 						

		if [[ "$someVariable" = "Some Value" ]] \

	#True If Values Not Equal 					

		if [[ "$someVariable" != "Some Value" ]] 

	#True If File or Directory Exists			

		if [[ -e /PATH/TO/FILE ]]
		if [[ -e /PATH/TO/DIRECTORY ]]

	#True If File Exists 						

		if [[ -f /PATH/TO/FILE ]]

	#True If File or Directory Does Not Exist 	

		if [[ ! -e /PATH/TO/FILE ]]
		if [[ ! -e /PATH/TO/DIRECTORY ]]

	#True If File Does Not Exist 				

		if [[ ! -f /PATH/TO/FILE ]]

	#True If Directory Exists 					

		if [[ -d /PATH/TO/DIRECTORY ]]

	#True If Directory Does Not Exist 			

		if [[ ! -d /PATH/TO/DIRECTORY ]]


#LOOPS


	#FOR

		#For-loop syntax

			for someMadeUpVariable in listOfItems
			do
				commandsToApply
			done

		#Basic for-loop

			for i in red green blue
			do
  				echo "the color is $i"
			done

		#Move every .jpg from the Desktop to the Pictures folder

			for jpg in ~/Desktop/*.jpg;do
  				echo "Moving $(basename "$jpg") to Pictures"
  				mv "$jpg" ~/Pictures
			done

	#WHILE

		#Loop while a file does not exist

			while [[ ! -f /PATH/TO/FILE ]];do
  				echo "The file is not there." 
  				sleep 3
			done

		#Loop through lines of a comma-separated-value file

			IFS=,
			while read id name site;do
  				echo "Computer $id in site $site belongs to $name."
			done < /PATH/TO/FILE

	#USER INPUT

		#Display an AppleScript dialog

			osascript -e 'tell application "System Events" to display dialog "Please type in your asset tag" default answer "JS#####" buttons {"OK"} default button 1'

		#Return text from AppleScript

			"osascript << EOF tell application "System Events" to text returned of (display dialog "Please type in your asset tag" default answer "JS#####" buttons {"OK"} default button 1) EOF"


HEALTH


	#Display the Jamf Pro health status

		curl -m 10 -ks https://JAMF_PRO_URL/healthCheck.html


DEFAULTS


	#Print a property list

		defaults read /PATH/TO/FILE

	#Print a specific property

		defaults read /PATH/TO/FILE someKey

	#Set or modify a property

		defaults write /PATH/TO/FILE someKey -boolean someBoolean
		defaults write /PATH/TO/FILE someKey -integer someInteger
		defaults write /PATH/TO/FILE someKey -string someValue

	#Remove a property

		defaults delete /PATH/TO/FILE someKey


#ID


	#List the current user's unique ID

		id -u

	#List the unique ID for a user
		
		id -u someUser


#LAUNCHCTL


	#Bootout a user agent from memory
		
		launchctl bootout gui/<user uid> /PATH/TO/FILE

	#Bootstrap a user agent into memory

		launchctl bootstrap gui/<user uid> /PATH/TO/FILE

	#Bootout a system agent or daemon from memory

		launchctl bootout system /PATH/TO/FILE

	#Bootstrap a system agent or daemon into memory	

		launchctl bootstrap system /PATH/TO/FILE

	#Start an agent or daemon

		launchctl start CUSTOM_LABEL_HERE


#PLUTIL


	#Convert a binary encoded file to XML

		plutil -convert xml1 /PATH/TO/FILE


#SEEDUTIL


	#seedutil will return one of the following:

		CustomerSeed
		DeveloperSeed
		PublicSeed
		(null)


#CUSTOMIZATION


	#Add Logo to Enrol page for Jamf using Markdown

		![optional ALT text](URL_to_image)


#KERNEL EXTENSTIONS (KEXT's)


	#SQLite

		#Open a database in SQLite interactive mode

			sqlite3 /var/db/SystemPolicyConfiguration/KextPolicy

	#Headers

		#Turn on headers

			.headers on

	#Column mode

		#Turn on column mode

			.mode column

	#Tables

		#List tables

			.tables

		#Locate TeamID and BundleID from the Kext Policy table

			SELECT * FROM kext_policy;

		#Print the Kext Policy MDM table

			SELECT * FROM kext_policy_mdm;

	#Exit SQLite

		.exit


#SYSTEM EXTENSIONS 


	#List installed system extensions

		systemextensionsctl list

	#Print the system extensions MDM property list

		defaults read /Library/SystemExtensions/db.plist


#CODESIGN


	#Obtain the code signature requirement and bundle identifier

		codesign --display --requirements - /Applications/Application.app
		codesign --display --requirements - /path/to/binary

	#Print entitlements

		codesign --display --entitlements - /Applications/Application.app
		codesign --display --entitlements - /path/to/binary


#TCCUTIL


	#Reset the privacy database

		tccutil reset All


#HTTP REQUESTS


	#Request 		Action

	GET				Read
	POST			Create
	PUT 			Update
	DELETE 			Delete


#EXAMPLES  


	#Agent to open course resources

		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>Label</key>
			<string>CUSTOM_LABEL_HERE</string>
			<key>ProgramArguments</key>
			<array>
				<string>/usr/bin/open</string>
				<string>https://jamf.it/courseresources</string>
			</array>
			<key>RunAtLoad</key>
			<true/>
		</dict>
		</plist>

	#Daemon to call a script on a timer

		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>Label</key>
			<string>CUSTOM_LABEL_HERE</string>
			<key>ProgramArguments</key>
			<array>
				<string>/usr/local/jamf/bin/jamf</string>
				<string>runScript</string>
				<string>-script</string>
				<string>FILE</string>
				<string>-path</string>
				<string>/PATH/TO/DIRECTORY</string>
			</array>
			<key>RunAtLoad</key>
			<true/>
			<key>StartInterval</key>
			<integer>NUMBER_OF_SECONDS</integer>
		</dict>
		</plist>


	#Compose a daemon using the jamf binary

		jamf scheduledTask -command "/usr/local/jamf/bin/jamf runScript -script FILE -path "'"/PATH/TO/DIRECTORY"'"" -name CUSTOM_NAME_HERE -runAtLoad true -minute '*/NUMBER_OF_MINUTES/'

	#Update Jamf management framework

		/usr/local/jamf/bin/jamf manage

	#Set the URL for Jamf Admin and Recon

		defaults write ~/Library/Preferences/com.jamfsoftware.jss.plist url https://JAMF_PRO_URL



	#Redirect the output from the API to a file

		serialNumber=$(system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}')
		curl -sku username:password -H "accept: text/xml" https://JAMF_PRO_URL/JSSResource/computers/serialnumber/$serialNumber > /PATH/TO/FILE1
		id=$(xmllint --xpath '/computer/general/id/text()' /PATH/TO/FILE1)
		username=$(xmllint --xpath '/computer/location/username/text()' /PATH/TO/FILE1)
		site=$(xmllint --xpath '/computer/general/site/name/text()' /PATH/TO/FILE1)
		echo "$id,$username,$site" > /PATH/TO/FILE2

	#Daemon to call a script on a timer

		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>Label</key>
			<string>CUSTOM_LABEL_HERE</string>
			<key>ProgramArguments</key>
			<array>
				<string>/usr/local/jamf/bin/jamf</string>
				<string>runScript</string>
				<string>-script</string>
				<string>FILE</string>
				<string>-path</string>
				<string>/PATH/TO/DIRECTORY</string>
			</array>
			<key>RunAtLoad</key>
			<true/>
			<key>StartInterval</key>
			<integer>NUMBER_OF_SECONDS</integer>
		</dict>
		</plist>

	#Automatically re-run policy on failure check

		#!/bin/bash
		counterFile="/private/tmp/jamftraining-counter"
		if [[ ! -f "$counterFile" ]]
		then
			count=0
		else
			count=$( cat "$counterFile" )
		fi
		(( count++ ))
		echo "$count" > "$counterFile"
		if [[ "$count" -lt 3 ]]
		then
			echo "Policy retry attempt $count will be unsuccessful."
			exit 1
		else
			echo "Policy retry attempt $count was successful."
			rm "$counterFile"
			exit 0
		fi


	#Daemon to call a script

		<?xml version="1.0" encoding="UTF-8"?>
		<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
		<plist version="1.0">
		<dict>
			<key>Label</key>
			<string>CUSTOM_LABEL_HERE</string>
			<key>LaunchOnlyOnce</key>
			<true/>
			<key>ProgramArguments</key>
			<array>
				<string>/usr/local/jamf/bin/jamf</string>
				<string>runScript</string>
				<string>-script</string>
				<string>FILE</string>
				<string>-path</string>
				<string>/PATH/TO/DIRECTORY</string>
			</array>
			<key>StartInterval</key>
			<integer>NUMBER_OF_SECONDS</integer>
		</dict>
		</plist>


			sudo rm -rf ~/.Trash/*
			sudo rm -r firefox.app
			sudo dseditgroup -o edit -d UserName -t user admin

#Find Apps installed via VPP App Store

	mdfind -onlyin /Applications/ -name "kMDItemAppStoreHasReceipt = 1 && kMDItemKind = Application"


