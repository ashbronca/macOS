#!/bin/bash

curl -sku API_user:password -X POST "jamf_URL/JSSResource/fileuploads/computers/id/100" -F "name=@/private/var/log/system.log"

