#!/bin/bash

logFile="$HOME/Desktop/logFile.log"

touch $logFile

askName() 
{
	{
		
	echo "hello, what is your name?"
	
	read name
	
	echo "great to meet you $name, have a nice day"
		
	} | tee ${logFile}
}  

askName


