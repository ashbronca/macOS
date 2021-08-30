#!/bin/bash

for Department in Art Music Math Science History
do
	curl -sku API_user:password -X POST -H "content-type: text/xml" "jamf_URL/JSSResource/departments/id/0" -d "<department><name>$Department</name></department>"
done
	