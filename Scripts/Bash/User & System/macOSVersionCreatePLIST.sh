#!/bin/bash

macOSVersion=$( sw_vers -productVersion )

mkdir -p /Library/Application\ Support/AnyOrg

defaults write /Library/Application\ Support/AnyOrg/AnyOrg.plist macOSVersion -string $macOSVersion

chmod 644 /Library/Application\ Support/AnyOrg/AnyOrg.plist