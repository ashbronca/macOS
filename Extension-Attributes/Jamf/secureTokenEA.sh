#!/bin/bash

lastUser=$( stat -f %Su /dev/console )

dscl . -read /Users/$lastUser AuthenticationAuthority | grep -i -o -q 'SecureToken'

if [ $? == 0 ]; then
	echo "<result>ENABLED</result>"
else echo "<result>DISABLED</result>"
fi

