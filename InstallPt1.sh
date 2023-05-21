#!/bin/env bash
# File : InstallPt1.sh

echo "Internet "

sleep 2

echo ping to google.com

sleep 7

ping -c 4 google.com



echo "--------------------------------------------------------------------------"
echo ""
echo "				UPDATE THE SYSTEM CLOCK				"
echo ""
echo "---------------------------------------------------------------------------"

timedatectl set-ntp true 

echo "Service Status"

sleep 4

timedatectl status

echo "TO CHANGE SYSTEM CLOCK"

sleep 3

timedatectl set-timezone America/New_York
timedatectl status

echo "-----------------------------------------------------------------------"
echo ""
echo "				FORMAT THE PARTITION			     "
echo ""
echo "------------------------------------------------------------------------"



# # Deleting Keys from TPM and wiping LUKS Header

# systemd-cryptenroll /dev/sda2 --wipe-slot=tpm2
# cryptsetup luksErase /dev/sda2
# echo "Checking current slots"
# systemd-cryptenroll /dev/sda2
# echo " Checking luksDump" 
# cryptsetup luksDump /dev/sda2

# cfdisk

# echo -e "cryptsetup for /dev/sda2"

# # cryptsetup --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 2000 --key-size 512 --pbkdf argon2id --use-urandom --verify-passphrase luksFormat /dev/sda2
# systemd-cryptenroll /dev/sda2

# echo -e "Backing up LUKS header for emergency to kali pendrive"
# cryptsetup luksHeaderBackup /dev/sda2 --header-backup-file /mnt2/file.img
# echo -e "Encyrpting img using gpg"
# gpg -c /mnt2/file.img

# echo -e "Creating Recovery key and storing in kali mnt"
# systemd-cryptenroll /dev/sda2 --recovery-key > /mnt2/recoverykey.txt
# echo -e "Checking cryptenroll key slots"
# systemd-cryptenroll /dev/sda2

# echo -e "Setting up TPM with pin" 
# systemd-cryptenroll /dev/sda2 --wipe-slot=empty --tpm2-with-pin=yes --tpm2-device=auto
# echo -e "Checking cryptenroll key slots"

# systemd-cryptenroll /dev/sda2

# echo -e "Opening the drive"
# cryptsetup open /dev/sda2 cryptlvm 

# echo -e "Creating lvm called cryptlvm"

# pvcreate /dev/mapper/cryptlvm
# echo -e "Creating volume group called rhsgrp"
# vgcreate rhsgrp /dev/mapper/cryptlvm

# lvcreate -L 13G rhsgrp -n swap
# lvcreate -L 150G rhsgrp -n root
# lvcreate -L 788.9G rhsgrp -n home
/usr/lib/systemd/systemd-cryptsetup attach cryptlvm /dev/sda2 - tpm2-device=auto


mkfs.ext4 /dev/rhsgrp/root
mkfs.ext4 /dev/rhsgrp/home
mkswap /dev/rhsgrp/swap



mount /dev/rhsgrp/root /mnt
mount --mkdir /dev/rhsgrp/home /mnt/home
swapon /dev/rhsgrp/swap

mkfs.fat -F32 /dev/sda1 
mount --mkdir /dev/sda1 /mnt/boot

fdisk -l


# echo -e "\n\n"
# read -p "Enter Name Of Boot Partition [for example /dev/sda7 ] :  " boot_part
# echo -e "\n\n"
# read -p "Enter Name of Root Partition [for example /dev/sda8 ] : " root_part
# echo ""
# read -p "Enter Name of Home Partition [for exmple /dev/sda9 ] :  " home_part

# echo ""
# read -p  "Enter Name Of Swap Partition [for example /dev/sda10] : " swap_part


# mkfs.ext4   $root_part
# mkfs.ext4   $home_part
# mkswap   $swap_part
# swapon $swap_part
# mkfs.fat -F32 $boot_part





# echo "------------------------------------------------------------------------"
# echo ""
# echo "				MOUNT THE FILESYSTEM 				"
# echo ""
# echo "---------------------------------------------------------------------------"

# mount $root_part  /mnt
# # mkdir /mnt/home
# # mkdir /mnt/boot
# # mount $boot_part /mnt/boot
# # mount $home_part /mnt/home

# echo "------------------------------------------------------------------------------"
# echo""
# echo "					INSTALLATION 					"
# echo ""
# echo "------------------------------------------------------------------------------"

# echo "Edit Mirrorlist file /etc/pacman.d/mirrorlist"



# sleep 5

# vim /etc/pacman.d/mirrorlist



echo "------------------------------------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "									Downloading Essential Packages 								"
echo ""
echo "-------------------------------------------------------------------------------------------------------------------------------------------------------"
pacstrap /mnt base linux linux-firmware vim man-db man-pages networkmanager lvm2 

echo "---------------------------------------------------------------------------------"
echo ""
echo "				CONFIGURE THE SYSTEM 					"
echo ""
echo "------------------------------------------------------------------------------------"

echo " Generate an Fstab File "

genfstab -U /mnt >> /mnt/etc/fstab

sleep 3

echo To Check the result of the Fstab File 

sleep 3

cat /mnt/etc/fstab
sleep 2
echo ""
echo ""
sleep 2
echo "--------------------------------------------------------------------------------------------------------------------------"
echo ""
echo "							ARCH CHROOT 								"
echo ""
echo "---------------------------------------------------------------------------------------------------------------------------"


cp applications.sh  hostname  hosts  InstallPt1.sh InstallPt2.sh  locale.conf  recommend.sh  locale.gen  blacklistnouveau.conf  mkinitcpio.conf grub  /mnt/root  

echo "Now Check What Should be done "

arch-chroot /mnt
