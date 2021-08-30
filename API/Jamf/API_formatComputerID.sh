#!/bin/bash

curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/computergroups/id/1" | xmllint --format -

