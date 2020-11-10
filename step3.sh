#!/bin/bash

##This part of the script will install Aperture Linux on your newly formatted partitions!

#Remove Arch mirrors, add Aperture mirror to mirrorlist
echo 'Server = http://mirror.aperturelinux.org/$repo/os/$arch' > /etc/pacman.d/mirrorlist

pacman-key --keyserver pool.sks-keyservers.net --recv-keys 94EBB7A5965B9914 && \
pacman-key --lsign-key 94EBB7A5965B9914

#TODO: if VM, don't install linux-firmware, else do 

pacstrap /mnt linux linux-firmware base base-devel zsh neovim man-db man-pages iwd

genfstab -U /mnt >> /mnt/etc/fstab

#Copy remaining scripts to the new system before chrooting in
mkdir /mnt/ApertureInstall
cp step4.sh /mnt/ApertureInstall/step4.sh
chmod +x /mnt/ApertureInstall/step4.sh
echo $bootmode > /mnt/ApertureInstall/bootmode
echo $installdrive > /mnt/ApertureInstall/installdrive
#etc

arch-chroot /mnt ./ApertureInstall/step4.sh
