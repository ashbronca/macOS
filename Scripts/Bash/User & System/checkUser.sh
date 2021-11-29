#!/bin/bash

userCheck=$(dscl . list /Users | grep "test")

if [[ $userCheck == "test" ]]; then
	echo "test account exists, removing..."
	sudo dscl . delete /Users/test
	if [[ $userCheck == "test" ]]; then
		echo "test account removed"
	fi
else echo "test account does not exist"
fi
