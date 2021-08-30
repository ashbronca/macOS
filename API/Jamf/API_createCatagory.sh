#!/bin/bash

curl -sku API_user:password -X POST -H "content-type: text/xml" "jamf_URL/JSSResource/categories/id/0" -d "<category><name>Updates2</name><priority>9</priority></category>"