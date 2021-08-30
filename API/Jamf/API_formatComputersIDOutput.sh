#!/bin/bash

curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/computers/id/100" | xmllint --format - > ~/Desktop/InventoryRecord.xml 

