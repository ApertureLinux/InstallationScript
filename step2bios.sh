#!/bin/bash

timedatectl set-ntp true

#PARTITIONING THE DISKS: boss fight #1

#ask which disk to install on, set disk to variable
echo Which disk would you like to install Aperture Linux to?
read installdrive

#warn user that disk will be totally wiped
echo "The disk will be totally wiped, are you sure you want to continue? (Y/n)"
read agreement
if [ $agreement != Y ];
then
	exit 00
fi

#establish variables for RAM amount, calculate swap size
totalram="$(free -ht | grep -Eo '[0-9]{1,4}' | head -1)"
swapmultiplier=1.5
swapsize="$(awk "BEGIN {print $totalram*$swapmultiplier}")"


#ask user for root partition size
echo "How large do you want your root partition in gigabytes? (Recommended: 20)"
read rootsize

#clear signature from install drive
wipefs --all --force $installdrive

#fdisk process based on variables
fdisk $installdrive 
d
n



+200M
n



+"$swapsize"G
n


+"$rootsize"G
n



w


mkfs.ext4 "$installdrive"1
mkfs.ext4 "$installdrive"3
mkfs.ext4 "$installdrive"4
mkswap "$installdrive"2
swapon "$installdrive"2
mount "$installdrive"3 /mnt
mkdir /mnt/home
mkdir /mnt/boot
mount "$installdrive"1 /mnt/boot
mount "$installdrive"4 /mnt/home
./step3.sh
