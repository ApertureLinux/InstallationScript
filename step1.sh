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

ping -q -c5 $website > /dev/null
 
if [ $? -eq 0 ]
then
	./step2$bootmode.sh
else
	./wificonnect.sh
fi
