#!/bin/bash

curl -sku API_user:password -X GET -H "accept: text/xml" "jamf_URL/JSSResource/activationcode" | xmllint --xpath "/activation_code/code/text()" - 
