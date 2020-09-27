#!/bin/bash

timedatectl set-ntp true

#PARTITIONING THE DISKS: boss fight #1

#ask which disk to install on, set disk to variable

#warn user that disk will be totally wiped

#establish variables for RAM amount and disk size
totalram="$(free -ht | grep -Eo '[0-9]{1,4}' | head -1)"
swapmultiplier=1.5
swapsize="$(awk "BEGIN {print $totalram*$swapmultiplier}")"

#set swap variable to 1.5x RAM amount

#fdisk process based on variables


###sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk $installdrive
###o #clear partition table
###n #new partition
####etc etc

###q #quit

