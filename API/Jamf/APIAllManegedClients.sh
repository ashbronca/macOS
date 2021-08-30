#!/bin/bash

curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/computergroups/name/All Managed Clients" | xmllint --format -