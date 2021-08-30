#Variables
CSVFile = "C:\UserIPs_SharpeEngineering.csv"
Sender = "elizabeth@sharpeengineering.com.au"
Receiver = "ash@techhelpdirect.com.au"
SMTP = "sharpeengineering-com-au.mail.protection.outlook.com"
Subject “Sharpe Engineering IP Location Alert!”
Username = ""
Password = ""

#Import exhangeonline management module
Import-Module ExchangeOnlineManagement

#Remove the previous UserIP file
$fileToCheck = $CSVFile
if (Test-Path $fileToCheck -PathType leaf)
{
    Remove-Item $fileToCheck
}

#Function to connect to Exchange Online, query credentials 
Function Connect-EXOnline {
    $credentials = Get-Credential -Credential $credential
    Write-Output "Getting the Exchange Online cmdlets"
     
    #New exchange session with authentication
    $Session = New-PSSession -ConnectionUri https://outlook.office365.com/powershell-liveid/ `
        -ConfigurationName Microsoft.Exchange -Credential $credentials `
        -Authentication Basic -AllowRedirection
    Import-PSSession $Session -AllowClobber
}

#Connect to Exchange Online and grab credentials stored in $credential
$credential = Get-Credential
Connect-EXOnline
  
#Retrieve Logs
$startDate = (Get-Date).AddDays(-2)
    $endDate = (Get-Date)
    $Logs = @()
    Write-Host "Retrieving logs" -ForegroundColor Blue
    do {
        $logs += Search-unifiedAuditLog -SessionCommand ReturnLargeSet -SessionId "UALSearch" -ResultSize 5000 -StartDate $startDate -EndDate $endDate -Operations UserLoggedIn #-SessionId "$($customer.name)"
        Write-Host "Retrieved $($logs.count) logs" -ForegroundColor Yellow
    }while ($Logs.count % 5000 -eq 0 -and $logs.count -ne 0)
    Write-Host "Finished Retrieving logs" -ForegroundColor Green
 
#Store UserID logs into $userIds variable 
$userIds = $logs.userIds | Sort-Object -Unique
 
#Run for loop through the logs to get the information required in pipe
foreach ($userId in $userIds) {
 
    $ips = @()
    Write-Host "Getting logon IPs for $userId"
    $searchResult = ($logs | Where-Object {$_.userIds -contains $userId}).auditdata | ConvertFrom-Json -ErrorAction SilentlyContinue
    Write-Host "$userId has $($searchResult.count) logs" -ForegroundColor Green
 
    $ips = $searchResult.clientip | Sort-Object -Unique
    Write-Host "Found $($ips.count) unique IP addresses for $userId"
    foreach ($ip in $ips) {
        Write-Host "Checking $ip" -ForegroundColor Yellow
        $mergedObject = @{}
        $singleResult = $searchResult | Where-Object {$_.clientip -contains $ip} | Select-Object -First 1
        Start-sleep -s 4
        $ipresult = Invoke-restmethod -method get -uri http://ip-api.com/json/$ip
        $UserAgent = $singleResult.extendedproperties.value[0]
        Write-Host "Country: $($ipResult.country) UserAgent: $UserAgent"
        $singleResultProperties = $singleResult | Get-Member -MemberType NoteProperty
        foreach ($property in $singleResultProperties) {
            if ($property.Definition -match "object") {
                $string = $singleResult.($property.Name) | ConvertTo-Json -Depth 10
                $mergedObject | Add-Member -Name $property.Name -Value $string -MemberType NoteProperty    
            }
            else {$mergedObject | Add-Member -Name $property.Name -Value $singleResult.($property.Name) -MemberType NoteProperty}          
        }
        $property = $null
        $ipProperties = $ipresult | get-member -MemberType NoteProperty
 
        foreach ($property in $ipProperties) {
            $mergedObject | Add-Member -Name $property.Name -Value $ipresult.($property.Name) -MemberType NoteProperty
        }
        $mergedObject | Select-Object UserId, Operation, CreationTime, @{Name = "UserAgent"; Expression = {$UserAgent}}, Query, ISP, City, RegionName, Country  | export-csv $CSVFile -Append -NoTypeInformation
    }
}

#Store the exported csv data in the $UserIPs variable
$UserIPs = Import-Csv $CSVFile
 Write-Host "User IPs imported"

#Query the csv for Country "Australia"
foreach ($user in $UserIPs) {
    if ($user.country -notmatch "Australia") { 
        Write-Host "$($user.UserId) has an IP address coming from $($user.country)."
        Send-MailMessage –To $Receiver –From  $Sender –SmtpServer $SMTP –Subject $Subject –Body “$($user.UserId), has an IP address coming from $($user.country) on $($user.CreationTime).”  

    }
}

