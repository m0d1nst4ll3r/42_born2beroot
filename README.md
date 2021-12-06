#42_born2beroot

- Set up a virtualbox
- Install latest Debian
- Figure out what tf I'm supposed to do

Steps to install :

- https://www.youtube.com/watch?v=gi8Qif4SaUc
- You can do a graphic automated install
- Make sure to activate root user and give it a password
- For the partitioning, choose encrypted and separate - I'm hoping there's a way to add the other LVM partitions later with some commands - if so I'll document them
- When choosing modules, only check ssh server and standard system utilities
- Install GRUB and then reboot, you debian is installed

After installing :

- my system doesn't have sudo for some reason, in that case: su root, apt install sudo
- sudo apt update
- sudo apt install aptitude
- you can run aptitude and look at all the packages you have or don't have

Commands :

- 'adduser <username>' as root to add a user
- swap partition swappiness found in '/proc/sys/vm/swappiness' (or use 'sysctl vm.swappiness=20')
- 'more /etc/passwd' to look at the userlist
- 'hostnamectl' and 'more /etc/hosts' to look at the hostname
- 'hostnamectl set-hostname newhostname' and then modify /etc/hosts (use vim, apt install vim)

Todo :

- SSH ? 4242 ?!
- strong password policy?
- install (ok) and configure (wot) sudo?
- monitoring script?
