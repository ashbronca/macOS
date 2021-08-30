


####################### BASH #######################	



#FILEVAULT


	#Issuing new recovery key - FileVault

		sudo fdesetup changerecovery -personal

	#Check FileVault Status

		sudo fdesetup status


#DOCK


	#Reboot Dock

		sudo killall dock

	#Create recent folders on Dock

		defaults write com.apple.dock persistent-others -array-add '{"tile-data" = {"list-type" = 1;}; "tile-type" = "recents-tile";}'; killall Dock

	#Scroll through dock app windows

		defaults write com.apple.dock scroll-to-open -bool TRUE; killall Dock


#USERS & GROUPS


	#Delete user through terminal

		sudo dscl . delete /Users/User Name

	#Hide a user account in login window

		sudo dscl . create /Users/hiddenuser IsHidden 1

	#Show a user account in login window

		sudo dscl . create /Users/hiddenuser IsHidden 0

	#Show hidden user accounts

		dscl . -list /Users

	#List users without '_'

		dscl . list /Users | grep -v _

	#Sign user out from other account

		sudo launchctl bootout user/$(id -u <username>)

	#Check Admin accounts on macOS

		dscacheutil -q group -a name admin

	#Remove admin privileges on macOS

		sudo dseditgroup -o edit -d UserName -t user admin

	#Create new user from Terminal

		sudo dscl . -create /Users/*username*
		sudo dscl . -create /Users/username UserShell /bin/bash
		sudo dscl . -create /Users/username RealName “John Smith”
		sudo dscl . -create /Users/username UniqueID 1001
		sudo dscl . -create /Users/username PrimaryGroupID 1000
		sudo dscl . -create /Users/username NFSHomeDirectory /Local/Users/username
		sudo dscl . -passwd /Users/username password
		sudo dscl . -append /Groups/admin GroupMembership username

	#Delete User from Terminal

		sudo dscl . delete /Users/username

	#Log into anther user in terminal

		su
		login

	#Create an Admin User Account Using CMD Prompt

		net user /add [*username] [password]
		net localgroup administrators [username] /add


#POWER


	#Check Battery Level - Mac

		pmset -g batt

	#Check Battery Capacity 

		ioreg -l -w0 |grep Capacity

	#Check Battery Condition

		system_profiler SPPowerDataType | grep "Condition"
		#or
		system_profiler SPPowerDataType | grep -A3 -B7 "Condition"


#FIRMWARE 


	#Check firmware password status

		sudo firmwarepasswd -check


#WATCHMAN


	#Force sync Watchman

		sudo /Library/MonitoringClient/RunClient -F


#VNC


	#Connect via WAN IP over VNC Port

		vnc://***.***.**.**:5900

	#Connect to computer

		vnc://***.***.*.*

	#Connect to computer from terminal

		open vnc://***.***.*.*


#SCREEN SAVER


	#Set the screen saver time

		defaults -currentHost write com.apple.screensaver idleTime 1800


#TIME MACHINE


	#Time Machine Enable/disable

		sudo tmutil enable
		sudo tmutil disable

	#Run/Stop Time Machine backup right away (same as choosing BackUp Now in the menu bar)

		tmutil startbackup
		tmutil stopbackup

	#Save disk space on your mac with removing local snapshots - enable/disable

		sudo tmutil disablelocal
		sudo tmutil enablelocal

	#Exclude files and folders in Time Machine Backup

		sudo tmutil addexclusion
		#(for example)
		sudo tmutil addexclusion ~/Downloads

	#Get Time Machine stats

		tmutil listbackups
	

#SOFTWARE UPDATE


	#Mac OS X Software Update via Terminal

		#To get a list of available software updates, type the following command:

			softwareupdate -l

		#You will see a list of available updates. You can then install all available software updates with the following command:

			sudo softwareupdate -iva

		#The use of sudo is required to get superuser privileges to actually install the updates. You can also install only the recommended updates with:

			sudo softwareupdate -irv

		#Or you can just install specific software updates by specifying the shorthand package name from the previous list, like so:

			sudo softwareupdate -i iPhoneConfigurationUtility-3.2

		#If there are any updates you want to ignore, you can do so with the -–ignore flag, for example:

			sudo softwareupdate --ignore iWeb3.0.2-3.0.2

		#If you want to see all the available command line shortcuts for Software Update, just type:

			softwareupdate -h



#BASH TEST OPERATORS


	#Integer Comparison

		-eq | #is equal to 

				if [ "$a" -eq "$b" ]

		-ne | #is not equal to 

				if [ "$a" -ne "$b" ]

		-gt | #is greater than

				if [ "$a" -gt "$b" ]

		-ge | #is greater than or equal to

				if [ "$a" -ge "$b" ]

		-lt | #is less than

				if [ "$a" -lt "$b" ]

		-le | #is less than or equal to

				if [ "$a" -le "$b" ]

		<   | #is less than | (within double parentheses)

				(("$a" < "$b"))

		<=	| #is less than or equal to | (within double parentheses)

				(("$a" <= "$b"))

		>	| #is greater than | (within double parentheses)

				(("$a" > "$b"))

		>=	| #is greater than or equal to | (within double parentheses)

				(("$a" >= "$b"))

	#String Comparison

		==	| #is equal to | (The == comparison operator behaves differently within a double-brackets test than within single brackets.)

			[[ $a == z* ]]   # True if $a starts with an "z" (pattern matching).
			[[ $a == "z*" ]] # True if $a is equal to z* (literal matching).

			[ $a == z* ]     # File globbing and word splitting take place.
			[ "$a" == "z*" ] # True if $a is equal to z* (literal matching).
		
		!=	| #is not equal to | (This operator uses pattern matching within a [[ ... ]] construct.)

			if [ "$a" != "$b" ]

		< 	| #is less than | in ASCII alphabetical order - Note that the < needs to be escaped within a [ ] construct.

			if [[ "$a" < "$b" ]]
			if [ "$a" \< "$b" ]

		>	| #is greater than | in ASCII alphabetical order - Note that the > needs to be escaped within a [ ] construct.

			if [[ "$a" > "$b" ]]
			if [ "$a" \> "$b" ]

		-z 	| #string is null | (that is, has zero length)

			if [ -z "$s" ]

		-n 	| #string is not null.

			if [ -n "$s" ]

	#File Test Operators

		-e 	| #file exists


		-f 	| #file is a regular file (not a directory or device file)

		-d 	| #file is a directory

		-h 	| #file is a symbolic link

		-L 	| #file is a symbolic link

		-b 	| #file is a block device

		-c 	| #file is a character device

		-p 	| #file is a pipe

		-S 	| #file is a socket
		
		-s 	| #file is not zero size

		-t 	| #file (descriptor) is associated with a terminal device | This test option may be used to check whether the stdin [ -t 0 ] or stdout [ -t 1 ] in a given script is a terminal.

		-r 	| #file has read permission (for the user running the test)

		-w 	| #file has write permission (for the user running the test)

		-x 	| #file has execute permission (for the user running the test)

		-g  | #set-group-id (sgid) flag set on file or directory
	
		-u 	| #set-user-id (suid) flag set on file

		-k 	| #sticky bit set

		-O 	| #you are owner of file

		-G 	| #group-id of file same as yours

		-N 	| #file modified since it was last read

		-nt | #file f1 is newer than f2

			if [ "$f1" -nt "$f2" ]

		-ot | #file f1 is older than f2

			if [ "$f1" -ot "$f2" ]

		-ef | #files f1 and f2 are hard links to the same file

			if [ "$f1" -ef "$f2" ]

		! 	| #"not" -- reverses the sense of the tests above (returns true if condition absent).


#SINGLE USER MODE


	#Creating an admin account in Single User Mode

		Boot into Single User Mode ⌘ + S.
		Mount the drive by typing /sbin/mount -uw / then ↩ enter.
		Remove the Apple Setup Done file by typing rm /var/db/.AppleSetupDone then ↩ enter.
 		Reboot by typing reboot then ↩ enter.
 		Complete the setup process, creating a new admin account.


#SYSTEM


	#Add message to the login window

		sudo defaults write /Library/Preferences/com.apple.loginwindow/LoginwindowText "Your message here"

	#Rebuild Spotlight (reindex)

		sudo mdutil -E/Volumes/DriveName

	#Create a bootable installer

		#https://support.apple.com/en-gb/HT201372

			sudo /Applications/Install\ macOS\ Catalina.app/Contents/Resources/createinstallmedia --volume /Volumes/MyVolume

	#Install OS from terminal

		softwareupdate --fetch-full-installer --full-installer-version **.**.*

	#Check Wake Reason - Lid Open

		log show --style syslog | fgrep "Wake reason: EC.LidOpen"

	#Check Wake Reason - General

		log show --style syslog | fgrep "Wake reason"

	#List All Drives

		diskutil list

	#Verify and Repair Disk Permissions via Terminal (Mac OS X)

		#Verify Disk Permissions

			diskutil verifyPermissions /

		#Repair Disk Permissions

			diskutil repairPermissions /

	#Verify and Repair Volume via Terminal (Mac OS X)

			diskutil verifyVolume [drive name]

		#For your main hard drive, you could type or paste:

			diskutil verifyVolume /

		#Or, if you have an external drive attached, you can type or paste in the following:

			diskutil verifyvolume /Volumes/[drive name]/

		#So for an external drive named “BackupStuff” you would enter:

			diskutil verifyvolume /Volumes/BackupStuff/

		#To repair the drive:

			diskutil repairvolume /

		#Or, for that external drive as above:

			diskutil repairvolume /Volumes/BackupStuff/

	#If unable to unmount drive on Mac

		diskutil list
		sudo diskutil unmountDisk /dev/(enter here disk identifier name)
		#enter admin password

	#Print the operating system version

		sw_vers -productVersion


#SCREENSHOTS


	#Remove shadows on screenshots

		defaults write com.apple.screencapture disable-shadow -bool TRUE


#GENERAL TERMINAL


	#Copy files from user to user in terminal

		(Get in admin) su ladmin
		(Log in as root) sudo -s
		(copy files) cp -R /Users… /Users…
		(Add permissions to these files) Chown -R /user/:staff /location

	#Show and hide hidden folders

		COMMAND + SHIFT + .(dot)

	#Hide a folder in finder

		chflags hidden [Path of file/folder]

	#Permanently show hidden folders

		chflags nohidden [Path of file/folder]

	#Download file without browser

		cd ~/Downloads/ (change to location that you want the file downloaded to)
		curl -O [the URL of the file

	#Hide the home directory and Sharepoint

 		#This command moves the home directory of “hiddenuser” to var/, a hidden directory

			sudo mv /Users/hiddenuser /var/hiddenuser

 		#This command updates the user record of “hiddenuser” with the new home directory in var/

			sudo dscl . create /Users/hiddenuser NFSHomeDirectory /var/hiddenuser

 		#This command removes the public folder share point for the user with the long name “Hidden User”

			sudo dscl . delete "/SharePoints/Hidden User's Public Folder"

	#Create mobile AD account

		sudo /System/Library/CoreServices/ManagedClient.app/Contents/Resources/createmobileaccount -n [AD_username] -v

		#then add the local admin password, skip through the secure token, and su into that user to pre-cache account

	#Recreate Shared Folder

		sudo -s and type in the ladmin password
		mkdir /Users/Shared
		chown root:wheel /Users/Shared
		chmod 777 /Users/Shared
		chmod +t /Users/Shared

	#qlmanage: Quick-look a file from the command line

		qlmanage -p path_to_file

	#Securely copy a file between two computers

 		#To copy from a local current directory to the remote system:
			scp filename userID@remotesystem:/path/to/filename

 		#To copy from the remote system to the local current directory:
			scp userID@remotesystem:/path/to/filename ./

 		#To copy an entire directory (the -r option indicates recursion):
			scp -r directoryname userID@remotesystem:/path/to/directory

	#Set the computer/host/local name

		sudo scutil --set ComputerName "newname"
		sudo scutil --set LocalHostName "newname"
		sudo scutil --set HostName "newname"

	#Package installer via terminal

		pkgbuild --install-location /Applications --component "/path/to/macOSInstallerApp" "/path/to/xxxxx.pkg"

	#Where to find email signature folder

		/Users/ashbronca/Library/Mail/V7/MailData/Signatures/signature_name

	#List top level directory of list folder

		ls -ld

	#D.U.N.S Number lookup

		dnb.com			

	#Set ownership and permission for a system agent or daemon

		chown root:wheel /PATH/TO/FILE
		chmod 644 /PATH/TO/FILE

	#Print the date to a file

		date +%F\ %T >> /PATH/TO/FILE

	#Bootout the Dock agent for user with unique ID 502

		launchctl bootout gui/502 /System/Library/LaunchAgents/com.apple.Dock.plist

	#Bootstrap the Dock agent for user with unique ID 502

		launchctl bootstrap gui/502 /System/Library/LaunchAgents/com.apple.Dock.plist

	#Bootout a system agent or daemon with Label

		launchctl bootout system/CUSTOM_LABEL_HERE

	#Compose a property list file with an array

		defaults write /PATH/TO/FILE menuExtras -array-add "/System/Library/CoreServices/Menu Extras/Bluetooth.menu"

	#Restart SystemUIServer

		killall SystemUIServer

	#Enforce Safari homepage and window behavior

		defaults write ~/Desktop/com.apple.Safari.plist NewWindowBehavior -integer 0
		defaults write ~/Desktop/com.apple.Safari.plist HomePage https://jamf.it/courseresources

	#Set Safari homepage

		defaults write ~/Desktop/com.apple.Safari.SandboxBroker.plist Homepage https://jamf.it/courseresources

	#Print Apple Beta Software Program enrollment status

		/System/Library/PrivateFrameworks/Seeding.framework/Resources/seedutil current | awk '/enrolled/{print $NF}'

	#Print the FileVault status

		fdesetup status | awk '/FileVault is/{print $3}' | tr -d .

	#Create a folder on the desktop

		osascript -e 'tell application "Finder" to make new folder at desktop'

	#Sleep the computer

		osascript -e 'tell application "System Events" to sleep'

	#Print an app's bundle ID

		osascript -e 'id of app "Name of App"'

	#Reset all decisions for a specified service

		tccutil reset AddressBook

	#Convert a date from UNIX epoch time to YYYY-MM-DD hh:mm:ss

		date -jf %s 1683340403 +%F\ %T

	#Translate uppercase characters to lowercase from the output of a command

		system_profiler SPHardwareDataType | awk '/Serial Number/{print $4}' | tr [:upper:] [:lower:]

	#Remove characters from the output of a command

		sysctl kern.boottime | awk '{print $5}' | tr -d ,

	#Last kernel boot time

		bootTime=$(sysctl kern.boottime | awk '{print $5}' | tr -d ,)
		echo "$bootTime"
		bootTimeFormatted=$(date -jf %s $bootTime +%F\ %T)
		echo "$bootTimeFormatted"

	#Print the operating system version

		sw_vers -productVersion

	#Quickly hide the desktop icons


		defaults write com.apple.finder CreateDesktop -bool FALSE; killall Finder

		#show

		defaults write com.apple.finder CreateDesktop TRUE; killall Finder


	#Delete the hiding Dock Delay in OS

	
		defaults write com.apple.dock autohide-delay -float 0;killall Dock

		#Revert to the default setting:

		defaults delete com.apple.dock autohide-delay;killall Dock

			https://www.defaults-write.com/


	#Get Private IP Address

		ipconfig getifaddr en0

	#Get Public IP Address

		curl ipecho.net/plain; echo









