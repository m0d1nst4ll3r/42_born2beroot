#42_born2beroot

- Set up a virtualbox
- Install latest Debian
- Figure out what tf I'm supposed to do

Steps :

- https://www.youtube.com/watch?v=gi8Qif4SaUc
- You can do a graphic automated install
- Make sure to activate root user and give it a password
- For the partitioning, choose encrypted and separate - I'm hoping there's a way to add the other LVM partitions later with some commands - if so I'll document them
- When choosing modules, only check ssh server and standard system utilities
- Install GRUB and then reboot, you debian is installed

After :

- sudo apt update
- ... TBD

Commands :

- 'adduser <username>' as root to add a user
- swap partition swappiness found in '/proc/sys/vm/swappiness' (or use 'sysctl vm.swappiness=20')
