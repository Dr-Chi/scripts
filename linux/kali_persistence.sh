#!/bin/bash
#
# https://git.io/kalipersist
# https://github.com/Dr-Chi/scripts/master/linux/kali_persistence.sh
#
# Copyright (c) 2019 DrChi. Released under the MIT License.

# Detect users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo -e "\033[0;33mThis script needs to be run with bash, not sh"
	exit
fi

if [[ "$EUID" -ne 0 ]]; then
	echo -e "\033[0;33mSorry, you need to run this as root"
	exit
fi

echo -e "\033[0;36m******************************************************************"
echo -e "\033[0;31mWARNING: This will mess with partitions!  You could LOSE data!"
echo -e "\033[0;31mPlease read everything carefully and only proceed if you know"
echo -e "\033[0;31mwhat you're doing"
echo -e "\033[0;36m******************************************************************"
echo -e "\033[1;33m "

read -n 1 -s -r -p "Press any key to continue"


fdisk -l

# is the usb disk /dev/sdb ?
echo -e "\033[0;33mWhat is the path to your USB device? Remember: sda is usually the internal HD!"
read -p "USB path: " -e -i /dev/sdb USB
set -x #echo on
# The fdisk options are; n for new part, enter 4 times, w to write the changes
fdisk $USB <<EOI
n




Y
w
EOI

fdisk -l    #is it created?  Is is /dev/sdb3?
set +x #echo off
echo -e "\033[0;33mIs the new partition /dev/sdb3?"
read -p "new partition path: " -e -i /dev/sdb3 PAR
echo -e "\033[0;33mCreating an ext4 filesystem on the new partition"
set -x #echo on
mkfs.ext4 -L persistence $PAR
# wait
sleep 5
set +x #echo off
echo -e "\033[0;33mMaking sure the disk is labeled"
set -x #echo on
e2label $PAR persistence
set +x #echo off
echo -e "\033[0;33mCreating a persistence.conf file"
set -x #echo on
mkdir -p /mnt/storage
mount $PAR /mnt/storage
echo -e "\033[0;33m/ union" > /mnt/storage/persistence.conf
umount $PAR
set +x #echo off
echo \n
echo \n
echo \n
echo -e "\033[0;33mDONE!"
