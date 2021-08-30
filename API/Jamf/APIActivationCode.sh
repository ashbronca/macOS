#!/bin/bash

curl -sku API_user:password -X GET -H "accept: text/xml" "API_URL" | xmllint --xpath "/activation_code/code/text()" -