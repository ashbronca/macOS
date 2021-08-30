#!/bin/bash

jamfID=$(curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/computers/serialnumber/C07L6F0FDWYL" | xmllint --xpath "computer/general/id/text()" - )

userName=$(curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/computers/serialnumber/C07L6F0FDWYL" | xmllint --xpath "computer/location/username/text()" - )

siteName=$(curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/computers/serialnumber/C07L6F0FDWYL" | xmllint --xpath "computer/general/site/name/text()" - )

echo "The Jamf ID is $jamfID, the username is $userName, and the machine's site is $site."

