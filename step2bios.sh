#!/bin/bash

timedatectl set-ntp true

#PARTITIONING THE DISKS: boss fight #1

#ask which disk to install on, set disk to variable
clear
lsblk
read -p "Which disk would you like to install Aperture Linux to? [/dev/sdX or /dev/nvmeXn1]: " installdrive

#warn user that disk will be totally wiped
clear
read -p "$installdrive will be totally wiped, are you sure you want to continue? [Y/n]: " agreement
if [ $agreement != Y ];
then
	exit 00
fi

export installdrive

#clear signature from install drive
wipefs --all --force $installdrive

read -p "THIS WILL DELETE THE ENTIRE HARD DRIVE. NOTHING WILL REMAIN. EVERYTHING WILL BE COMPLETELY WIPED. ARE YOU SURE YOU WISH TO CONTINUE? [Y/n]: " agreement2
if [ $agreement2 != Y ];
then
	exit 00
fi

#fdisk process based on variables
sgdisk $installdrive -Z
sgdisk $installdrive -o
sgdisk $installdrive -n 1:0:5MiB
sgdisk $installdrive -n 2:6MiB:
sgdisk $installdrive -t 1:ef02
sgdisk $installdrive -u 1:21686148-6449-6E6F-744E-656564454649


if [[ $var == *"nvme"* ]]; then
	        mkfs.ext4 "$installdrive"p2
		mount "$installdrive"p2 /mnt 
		mkdir /mnt/boot
		mount "$installdrive"p1 /mnt/boot;
	else
		mkfs.ext4 "$installdrive"2 #root
		mount "$installdrive"2 /mnt #mount root
		mkdir /mnt/boot
		mount "$installdrive"1 /mnt/boot
fi

. ./step3.sh
