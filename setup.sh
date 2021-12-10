#!/bin/bash

#######################################
# Instructions for setting up your VM #
#######################################

#	1. Create your VM
#		a. Install Virtualbox
#		b. Make a new VM, 1 GB ram, create a disk, VDI, dynamic, 8 GB
#	2. Install Debian
#		a. Download Debian iso https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-11.1.0-amd64-netinst.iso
#		b. Run your VM
#		c. Choose Debian iso
#		d. Install Debian with graphical install
#		e. Select English, US, whatever
#		f. Create your hostname (login42), skip domain
#		g. Create your root pwd
#		h. Create your username (login) and its pwd, skip full name
#		i. Select whatever time zone
#	3 Create partitions (during install)
#		a. Choose Manual partitioning
#		b. Select SCSI 3, choose yes
#		c. Select pri/log, create new, 500 mb, primary, beginning, ext4, /boot, done
#		d. Select pri/log, create new, max, logical, beginning, ext4, do not mount it, done
#		e. Configure encrypted volumes, yes, create, sda5, done, finish, yes (cancel the erasing process)
#		f. Enter your encryption passphrase
#		g. Configure the LVM, yes
#		h. Create Volume Group, LVMGroup, sda5
#		i. Create Logical Volume, do this for /, swap, /home, etc...
#			1) root		2gb		ext4	/
#			2) swap		1024mb	swap
#			3) home		1gb		ext4	/home
#			4) var		1gb		ext4	/var
#			5) srv		1gb		ext4	/srv
#			6) tmp		1gb		ext4	/tmp
#			7) var-log	1056mb	ext4	/var/log (enter manually)
#		j. Finish, go over each LVM you've created to mount them, finish, yes
#		k. Wait for the install, no, enter enter enter (defaults), no
#		l. Uncheck SSH and Standard system utilities, yes to GRUB, reboot
#	4. Connect via SSH (to copy this file into your VM)
#		a. log as root
#		b. apt install openssh-server
#		c. 'vi /etc/ssh/sshd-config' uncomment the 'Port 22' line and change 22 to 4242
#		d. In Virtualbox, click on Network, Advanced, Port Forwarding
#		e. Add a port, SSH, TCP, 127.0.0.1, 42420, 10.0.2.15, 4242
#		f. On a host terminal, type ssh login@127.0.0.1 -p 42420
#		g. Input your password
#	5. Set up your Debian with the help of this script
#		a. Copy the following files:
#			- monitoring.sh
#			- setup.sh
#			- common-password
#			- more...
#		b. Run this script 'bash setup.sh'
#		c. All done!

#######################################
# This script should be run as root   #
# (command: 'su', then type password) #
#######################################

# Change this to your username
USER="rpohlen"

#####################################################
# Install required packages + a few other nice ones #
#####################################################
apt update
apt install sudo
apt install apparmor
apt install ufw
apt install libpam-cracklib
apt install cron
apt install vim
# more?
#apt install lighttpd
#apt install mariadb-server

######################################
# Copy already modified config files #
######################################

# make sure permissions are set correctly
chmod 440 sudoers
chmod 644 sshd_config
chmod 644 common-password
chmod 644 crontab
chmod 644 monitoring.sh

# ssh config file (disable ssh root login, change port)
cp sshd_config /etc/ssh/sshd_config
# pam cracklib file (strong password policy)
cp common-password /etc/pam.d/
# sudo rules
cp sudoers /etc/
# cron (monitoring.sh)
cp crontab /etc/
cp monitoring.sh /

# Adds user42 group and adds groups to your user
addgroup user42
adduser $(USER) user42 sudo

# Sets up UFW
ufw allow 4242
ufw enable
