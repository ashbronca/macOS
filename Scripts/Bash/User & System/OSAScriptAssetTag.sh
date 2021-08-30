#!/bin/bash

osascript << EOF 
tell application "System Events" to text returned of (display dialog "Please type in your asset tag" default answer "" buttons {"OK"} default button 1) 
tell application "System Events" to text returned of (display dialog "Please type in your serial Number" default answer "" buttons {"OK"} default button 1) 
EOF > ~/Desktop/main.txt


