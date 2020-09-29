#!/bin/bash

#installation script part 1

clear

#verify bios or uefi

bootmode=uefi

if ls /sys/firmware/efi/efivars | grep ERROR; then
	set bootmode=bios
else
	set bootmode=uefi
fi

clear

#check for internet connection or connect to wifi

website=https://aperturelinux.org

ping -c1 $website 1>/dev/null 2>/dev/null
pingsuccess=$?

if [ $pingsuccess -eq 0 ]; then
	./step2.sh
else 
	./wificonnect.sh
fi
