#!/bin/bash

#Set timezone
clear
ls /usr/share/zoneinfo
echo "Choose your region"
read userregion
clear
ls /usr/share/zoneinfo/$userregion
echo "Choose a city that shares your time zone"
read usercity
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
echo "What will you name your computer?"
read hostname
echo $hostname > /etc/hostname

clear
echo "Select a root password."
passwd

#GRUB install
bootmode=`cat /ApertureInstall/bootmode`
installdrive=`cat /ApertureInstall/installdrive`
if $bootmode=uefi; then
	pacman -S grub efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
	grub-mkconfig -o /boot/grub/grub.cfg
else if $bootmode=bios; then
	pacman -S grub
	grub-install --target=i386-pc $installdrive
	grub-mkconfig -o /boot/grub/grub.cfg
fi

clear
echo "Aperture Linux is probably now installed on your system~!"
