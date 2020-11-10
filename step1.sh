#!/bin/bash

#stop mirror update

systemctl stop reflector.service

#installation script part 1

clear

#verify bios or uefi

bootmode=uefi

if [ ! -d "/sys/firmware/efi/efivars" ] ; then
	bootmode=bios
fi

export bootmode

clear

#check for internet connection or connect to wifi

website=aperturelinux.org

echo "Testing Network Connection..."
ping -q -c5 $website > /dev/null
 
if [ $? -eq 0 ]
then
	. ./step2$bootmode.sh
else
	echo 'An active internet connection is required for Aperture Linux installation. Please connect a wired connection, or configure a wireless connection using the "iwd" command.'
fi
