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
#	4. Setup SSH (to copy this file into your VM)
#		a. log as root
#		b. apt install openssh-server
#		c. 'vi /etc/ssh/sshd-config' uncomment the 'Port 22' line and change 22 to 4242
#		d. In Virtualbox, click on Network, Advanced, Port Forwarding
#		e. Add a port, SSH, TCP, 127.0.0.1, 42420, 10.0.2.15, 4242
#	5. Set up your Debian with the help of this script
#		a. Clone this repo if you haven't already (on the host)
#		b. Inside the repo, type 'scp -P 42420 * login@127.0.0.1:/tmp'
#		c. On your machine, as root, cd /tmp
#		d. Run this script 'sh setup.sh'
#	6. Make sure you understand everything that just happened
#	7. All done!

#######################################
# This script should be run as root   #
# (command: 'su', then type password) #
#######################################

# I gave up on bonuses, and they can't be automatically set up anyway
#read -p "Install bonus wordpress packages? (y/n) : " BWORDP
#read -p "Install bonus mail packages? (y/n) :" BMAIL

read -p "Enter your username: " USER

if [ "$(whoami)" != "root" ]
then
	echo "You are not root! Exiting..."
	exit
fi

#####################################################
# Install required packages + a few other nice ones #
#####################################################
echo "########Installing packages..."
apt update
apt install sudo
apt install apparmor
apt install ufw
apt install libpam-cracklib
apt install cron
apt install vim
# bonuses
if [ $BWORDP = "y" ]
then
	apt install wget
	apt install lighttpd
	apt install mariadb-server
	apt install php-cgi php-mysql
	wget http://wordpress.org/latest.tar.gz
	tar -xf latest.tar.gz
	cp -r wordpress /var/www/html
	rm -rf wordpress *.gz
	cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
fi
if [ $BMAIL = "y" ]
then
	apt install mailutils
	apt install postfix
fi

######################################
# Copy already modified config files #
######################################
echo "########Copying files..."
# make sure permissions are set correctly
chmod 440 sudoers
chmod 644 sshd_config
chmod 644 common-password
chmod 644 login.defs
chmod 644 crontab
chmod 644 monitoring.sh

# ssh config file (disable ssh root login, change port)
cp sshd_config /etc/ssh/sshd_config
# pam cracklib file (strong password policy)
cp common-password /etc/pam.d/
# sudo rules
cp sudoers /etc/
# password expiration
cp login.defs /etc/
# cron (monitoring.sh)
cp crontab /etc/
cp monitoring.sh /

echo "########Setting up groups, UFW, and sudo logging..."

# Adds user42 group and adds groups to your user
addgroup user42
adduser $USER user42
adduser $USER sudo

# Sets up UFW
ufw allow 4242
ufw enable

# Creates sudo log dir
mkdir /var/log/sudo
chmod 755 /var/log/sudo

# All done !
echo "\n\nEverything is set up as it should be,"
echo "BUT remember to update your user & root passwords"
echo "now that a strong password policy has been created."
echo "\nDuring the defense, you should know how to :"
echo "	- add a user (adduser)"
echo "	- add a group (addgroup)"
echo "	- add that user to a group (adduser <user> <group>)"
echo "	- change the hostname (hostnamectl set-hostname <hostname>)"
echo "	- ssh a session with that user (ssh user@127.0.0.1 -p 42420)"
echo "	- show the changes you've made"
echo "		- strong pwd policy : /etc/pam.d/common-password"
echo "		- sudo rules :	/etc/sudoers (visudo command)"
echo "		- cron task :	/etc/crontab"
echo "		- ssh config :	/etc/ssh/sshd_config"
echo "		- pwd expiration : /etc/login.defs"
echo "		- ufw rules (sudo ufw status)"
echo "	- show your monitoring script (/monitoring.sh)"
echo "	- explain how they work"
echo "	- more..."

if [ $BWORDP = 'y' || $BMAIL = 'y' ]
then
	echo "\n\nYou'll have to configure wordpress and postfix for your bonuses"
	echo "More instructions can be found over at :"
	echo "https://docs.google.com/document/d/15ruSLl_7WoxG2pIOJnkbgyCDQ6FQWaUbv2KpXrINY_E"
fi
