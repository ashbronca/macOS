#!/bin/bash

IP_address="$5"
print_name="$6"
display_name="$7"


/System/Library/Printers/Libraries/ipp2ppd ipp://$IP_address/ipp/print "" > /private/tmp/printer_driver.ppd
lpadmin -p "$print_name" -D "$display_name" -v ipp://$IP_address/ipp/print -E -P /private/tmp/printer_driver.ppd -E -o printer-is-shared=false

