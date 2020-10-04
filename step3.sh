#!/bin/bash

##This part of the script will install Aperture Linux on your newly formatted partitions!

#Remove Arch mirrors, add Aperture mirror to mirrorlist
echo "Server = http://mirror.aperturelinux.org/$repo/os/$arch" > /etc/pacman.d/mirrorlist

#TODO: if VM, don't install linux-firmware, else do
#TODO: add networking tools, 

pacstrap /mnt linux linux-firmware base base-devel zsh neovim man-db man-pages iwd

genfstab -U /mnt >> /mnt/etc/fstab

#Copy remaining scripts to the new system before chrooting in
mkdir /mnt/ApertureInstall
cp step4.sh /mnt/ApertureInstall/step4.sh
#etc

arch-chroot /mnt

#Set timezone
clear
ls /usr/share/zoneinfo
echo "Choose your region"
read $userregion
clear
ls /usr/share/zoneinfo/($userregion)
echo "Choose a city that shares your time zone"
read $usercity
ln -sf /usr/share/zoneinfo/($userregion)/($usercity) /etc/localtime
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
read $hostname
echo $hostname > /etc/hostname



