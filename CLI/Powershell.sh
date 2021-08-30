

####################### Windows #######################	
 

# CMD


	# Elevate CMD prompt within CMD prompt


		powershell -Command "Start-Process cmd -Verb RunAs"


# POWERSHELL


	# Get Help


		Get-Help CMDLET

	
	# Get script repo


		# powershell gallery


	# Show all cmdlets


		Get-Command


	# What if? check output of command before running it 


		Get-Service | stop-service -whatif


	# confirm - bring up a confirmation before proceeding 


		Get-Service | stop-service -confirm	


	# Show all stopped services 
	

		Get-Service | Where-Object {$_.status -eq "Stopped"} 	


	# Show all cmdlets for a module  
	

		Get-Command
		Import-Module AzureAD -UseWindowsPowerShell
		Get-Command -module AzureAD	

	
	# Connect to MS Modules


		# Teams


			connect-MicrosoftTeams


		# Exchange Online


			connect-exchangeonline


		# Microsoft Online


			connect-MsolService


	# Log into Exchange Online PowerShell Module


		# Download the Exchange Online PowerShell Module from the exchange centre (make sure that you download it from Internet Explorer)


			Connect-EXOPSSession -UserPrincipalName admin@domain.com


		# Input credentials for the account you're trying to access (MS window will pop up)



	# Set Office 365/Exchange Calendar Permissions Using PowerShell


		Add-MailboxFolderPermission -Identity user1@domain.com:\calendar -user user2@domain.com -AccessRights Editor
		Set-MailboxFolderPermission -Identity user1@domain.com:\calendar -User Default -AccessRights Reviewer
		Get-MailboxFolderPermission -Identity user1@domain.com:\calendar


	# Remove Calendar Permissions via PowerShell


		Remove-MailboxFolderPermission -Identity user1@domain.com:\calendar –user user2@domain.com
		Get-MailboxFolderPermission brett.jackson:\Calendar
		Remove-PSSession $Session


	# Repair corrupt files | must be run as administrator 

 
		sfc/scannow


	# Connect to exchange online management 


		Install-Module ExchangeOnlineManagement
		Import-Module ExchangeOnlineManagement
		Connect-ExchangeOnline -UserPrincipalName navin@contoso.com


	# Install WSMan


		pwsh -Command 'Install-Module -Name PSWSMan'
		sudo pwsh -Command 'Install-WSMan'


	# Get Global Teams calling policy


		Get-CsTeamsCallingPolicy -Identity Global


	# Get Global Teams meeting policy


		Get-CsTeamsMeetingPolicy -Identity Global


	# Set teams calling policy for 1:1 recording 


		Set-CsTeamsCallingPolicy -AllowCloudRecordingForCalls $True


	# Set teams meeting policy for group recording 


		Set-CsTeamsMeetingPolicy -AllowCloudRecording $True -AllowRecordingStorageOutsideRegion $True


	# update module 


		Update-Module -Name ExchangeOnlineManagement


	# Getting a list of available Office 365 PowerShell cmdlets


		# To get a list of all available Office 365 PowerShell commands, we need to run the Get-Command cmdlet:


			Get-Command -module MSOnline


		# We can also get the list of cmdlets for Azure Active Directory:


			Get-Command -module AzureAD


	# Getting a list of all Office 365 users with PowerShell


		Get-MsolUser | Select DisplayName, City, Department, ObjectID


	# Creating a new user in Office 365 with PowerShell


		New-MsolUser -UserPrincipalName JSmith@enterprise.onmicrosoft.com -DisplayName "John Smith"  -FirstName “John” -LastName “Smith”


	# Removing a user from all sites with PowerShell


		Get-SPOSite | ForEach {Remove-SPOUser -Site $_.Url -LoginName " JSmith@enterprise.onmicrosoft.com"}


	# Changing a password in Office 365 with PowerShell


		Set-MsolUserPassword -UserPrincipalName JSmith@netwrixqcspa.onmicrosoft.com -NewPassword P@SSw0rd!


	# Managing group membership in Office 365 with PowerShell


		# To retrieve a list of all groups in Office 365, simply use the command Get-MsolGroup


			Get-MsolGroup


		# To add users to a group, use the Add-MsolGroupMember command:


			Add-MsolGroupMember -GroupObjectId 5b61d9e1-a13f-4a2d-b5ba-773cebc08eec -GroupMemberObjectId a56cae92-a8b9-4fd0-acfc-6773a5c1c767 -GroupMembertype user


	# Creating a SharePoint site collection with PowerShell


		New-SPOSite -Url "https://enterprise.sharepoint.com/sites/NewSite" -Owner "JSmith@enterprise.onmicrosoft.com" -StorageQuota "100" -Title "New Site"


	# Creating reports in Office 365 with PowerShell


		# Details about all mailboxes:


			Get-mailbox | get-MailboxStatistics


		# list of all mailboxes that haven’t been logged into during the last 30 days:


			Get-Mailbox –RecipientType 'UserMailbox' | Get-MailboxStatistics | Sort-Object LastLogonTime | Where {$_.LastLogonTime –lt ([DateTime]::Now).AddDays(-30) } | Format-Table DisplayName, LastLogonTime


		# A report on the highest volume senders and recipients:


			Get-MailTrafficTopReport


		# A report on all groups and their members:


			function Get-AllO365Members
			{
    			Try
    			{   
    			 $O365Groups=Get-UnifiedGroup
       				foreach ($O365Group in $O365Groups) 
        			{ 
           				Write-Host "Group Membership: " $O365Group.DisplayName -ForegroundColor Green
           				Get-UnifiedGroupLinks –Identity $O365Group.Identity –LinkType Members
            			Write-Host
       				 } 
    			}
    			catch [System.Exception]
   				{
       				Write-Host -ForegroundColor Red $_.Exception.ToString()   
    			} 
			}
			Get-AllO365Members



# SERVER


	# Find Server address on windows server

		cmd prompt > ipconfig > IP address

	# Remove .DS_STORES (common issue on windows servers)

		defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
