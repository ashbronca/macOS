#!/bin/bash

##################################################################################################################
NOT TO BE RUN AS SCRIPT - run per line and confirm via SSH or via GUI
##################################################################################################################

#Create group:
sudo dscl . create /Groups/GROUP

#Add some details like real name etc.:
sudo dscl . create /Groups/GROUP RealName "REALNAME"

#Use an unused groupID number as gid! You get a sorted list of used gids by entering:
sudo dscl . list /Groups PrimaryGroupID | tr -s ' ' | sort -n -t ' ' -k2,2
sudo dscl . create /Groups/GROUP gid ID_NUMBER

#Add an admin user (here I assume the user name is ladmin):
sudo dscl . create /Groups/GROUP GroupMembership ladmin

#If you want to add a second user use the subcommand append:
sudo dscl . append /Groups/GROUP GroupMembership User1 User2

#List all members of a group - confirm the group is there and the users are correct
dscacheutil -q group -a name GROUP

##########
#Create Share
#Add folder sharing in System Preferences to the group that you created
##########

#Set ownership 
sudo chown root:GROUP /Path/To/File

#To list existing ACLs in a directory
ls -le

#To recursively add inheritance to a directory simply append  file_inherit & directory_inherit tasks to the end of the existing ACE:
#Recursively add the following ACE to all files and folders inside Directory Name, marking the ACE as inherited.
chmod -R +ai "group:GROUP allow list,add_file,search,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" "Directory Name"

#Use -a# to remove the first ACE (at index 0):
chmod -a# 0 "Directory Name"

##################################################################################################################
END OF SCRIPT - Hash all below content if running as script
##################################################################################################################


#####################
#Other Options
#####################

# Apply the same ACE directly to "Directory Name," without marking it as inherited (allowing it to be edited in the Server app).
chmod +a "group:marketing allow list,add_file,search,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" "Directory Name"

#Use +a# to insert an ACE at a specific index (at index 0):
chmod +a# 0 "group:marketing allow list,add_file,search,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" "Directory Name"

#Use =a# to edit an existing ACE (at index 2):
chmod =a# 2 "group:marketing allow list,add_file,search,add_subdirectory,delete_child,readattr,writeattr,readextattr,writeextattr,readsecurity,file_inherit,directory_inherit" "Directory Name"

#Use -a# to remove the first ACE (at index 0):
chmod -a# 0 "Directory Name"

#Use -N to alltogether remove an ACL from a file or directory:
chmod -N "Directory Name"
# Tip: chmod -RN will recursively remove ACLs

#Test whether the group SSH Service ACL exists:
dscl . list /Groups PrimaryGroupID  | grep com.apple.access_ssh*

#If the group doesn't exist create it similar as the GROUP:
sudo dscl . create /Groups/com.apple.access_ssh
sudo dscl . create /Groups/com.apple.access_ssh RealName "SSH Service ACL"
sudo dscl . create /Groups/com.apple.access_ssh passwd "*"
sudo dscl . create /Groups/com.apple.access_ssh gid 399

#Add the group GROUP as nested group to the SSH Service ACL group if the SSH ACL is already enabled:
sudo dseditgroup -o edit -a GROUP -t group com.apple.access_ssh

#or if SSH ACL are dsiabled:
sudo dseditgroup -o edit -a GROUP -t group com.apple.access_ssh-disabled

#Enable remote login:
sudo systemsetup -setremotelogin on

#Add user to a group
sudo dseditgroup -o edit -a $username_to_add -t user GROUP
sudo dscl . append /Groups/wheel GroupMembership $USER

#####################
#Permissions - 777
#####################
Owner - Read Write Execute 
Group - Read Write Execute
Others - Read Write Execute





















