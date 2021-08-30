#Script to run commands individually within the Office Exchange Module 

#Connect using exopssession to the 365 tenant 
Connect-EXOPSSession -UserPrincipalName admin_emailAddress

#Get the list of groups within the tenant 
Get-UnifiedGroup -ResultSize Unlimited

#Export the list of members for every group within the tenant and export it to the desired location
$Groups = Get-UnifiedGroup -ResultSize Unlimited
$Groups | ForEach-Object {
	$group = $_
	Get-UnifiedGroupLinks -Identity $group.Name -LinkType Members -ResultSize Unlimited | ForEach-Object {
		New-Object -TypeName PSObject -Property @{
			Group = $group.DisplayName
			Member = $_.Name
			EmailAddress = $_.PrimarySMTPAddress
			RecipientType= $_.RecipientType
		}}} | Export-CSV "C:\\Office365GroupMembers.csv" -NoTypeInformation -Encoding UTF8