#!/bin/bash

localuserAccounts=$(dscl /Local/Default -list /Users uid | awk '$2 >= 100 && $0 !~ /^_/ { print $1 }')

echo "<result>$localuserAccounts</result>"

