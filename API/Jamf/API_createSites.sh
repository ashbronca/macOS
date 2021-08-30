#!/bin/bash

curl -sku API_user:password -X PUT -H "content-type: text/xml" "jamf_URL/JSSResource/computers/id/44" -d "<computer><general><site><name>Production</name></site></general></computer>"