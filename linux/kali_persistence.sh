#!/bin/bash
#
# https://github.com/Dr-Chi/scripts/master/linux/kali_persistence.sh
#
# Copyright (c) 2019 DrChi. Released under the MIT License.


# Detect users running the script with "sh" instead of bash
if readlink /proc/$$/exe | grep -q "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit
fi

if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit
fi


fdisk -l

# is the usb disk /dev/sdb ?
echo "What is the path to your USB device? Remember: sda is usually the internal HD!"
read -p "USB path: " -e -i /dev/sdb USB

# The fdisk options are; n for new part, enter 4 times, w to write the changes
fdisk $USB <<EOI
n
\n
\n
\n
\n
w
EOI

fdisk -l    #is it created?  Is is /dev/sdb3?
echo "Is the new partition /dev/sdb3?"
read -p "new partition path: " -e -i /dev/sdb3 PAR
echo "Creating an ext4 filesystem on the new partition"
mkfs.ext4 -L persistence $PAR
# wait
sleep 5
echo "Making sure the disk is labeled"
e2label $PAR persistence
echo "Creating a persistence.conf file"
mkdir -p /mnt/storage
mount $PAR /mnt/storage
echo "/ union" > /mnt/storage/persistence.conf
umount $PAR
echo \n
echo \n
echo \n
echo "DONE!"
