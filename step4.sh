#!/bin/bash

#Set timezone
clear
ls /usr/share/zoneinfo
read -p "Choose your region" userregion
clear
ls /usr/share/zoneinfo/$userregion
read -p "Choose a city that shares your time zone" usercity
ln -sf /usr/share/zoneinfo/$userregion/$usercity /etc/localtime
hwclock --systohc

#localization
#TODO: locale choice
userlocale1="en_US.UTF-8"
userlocale2="en_US ISO-8859-1"

sed -i "/^#.* $userlocale1 /s/^#//" /etc/locale.gen
sed -i "/^#.* $userlocale2 /s/^#//" /etc/locale.gen
locale-gen
echo "LANG=$userlocale1" > /etc/locale.conf

#hostname
read -p "What will you name your computer?" hostname
echo $hostname > /etc/hostname

clear
echo "Select a root password."
passwd

#GRUB install
bootmode=`cat /ApertureInstall/bootmode`
installdrive=`cat /ApertureInstall/installdrive`
if [ $bootmode = uefi ] ; then
	pacman -S grub efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
	mkdir /boot/grub
	grub-mkconfig -o /boot/grub/grub.cfg
elif [ $bootmode = bios ]; then
	pacman -S grub
	grub-install --target=i386-pc $installdrive
	mkdir /boot/grub
	grub-mkconfig -o /boot/grub/grub.cfg
	grub-install --target=i386-pc --recheck $installdrive
fi

clear
echo "Aperture Linux is probably now installed on your system~!"
