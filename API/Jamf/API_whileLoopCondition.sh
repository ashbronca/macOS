#!/bin/bash

IFS=,

while read room tag serial
do
	
curl -sku API_user:password -X PUT -H "content-type: text/xml" "jamf_URL/JSSResource/mobiledevices/serialnumber/$serial" -d "<mobile_device><location><room>$room</room></location></mobile_device>" 

curl -sku API_user:password -X PUT -H "content-type: text/xml" "jamf_URL/JSSResource/mobiledevices/serialnumber/$serial" -d "<mobile_device><general><asset_tag>$tag</asset_tag></general></mobile_device>" 

done < /Users/Shared/Resources/Docs/deviceAssignment.csv

