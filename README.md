#42_born2beroot

List of tasks :

+ +Install Debian <-- DONE (might need to reinstall with other settings)
+ +Partition correctly (non-bonus) <-- DONE
+ +Correct hostname <-- DONE
+ +Root user + login user <-- DONE 
+ +login user belonging to user42 and sudo groups (belongs to other groups too?)
- Partition correctly (bonus)
- SSH service on port 4242
- UFW Firewall
- Configure sudo with strict rules
  - max 3 attempts to get sudo pwd right
  - custom message when wrong pwd (remaining attempts?)
  - each action using sudo is archived (input and output) in '/var/log/sudo'
  - requiretty (https://stackoverflow.com/questions/67985925/why-would-i-want-to-require-a-tty-for-sudo-whats-the-security-benefit-of-requi)
  - restrict paths that can be used by sudo
- Strong password policy (+ change existing pwds)
  - expire every 30 days
  - warning 7 days before
  - min of 2 days before new pwd
  - pwd rules
    - at least 10 characters long
    - one uppercase letter, one number
    - no more than 3 identical characters
    - not include the name of the user
    - at least 7 characters not part of old pwd (except for root)
- monitoring.sh bash script
  - runs every 10 minutes
  - The architecture of your operating system and its kernel version.
  - The number of physical processors.
  - The number of virtual processors.
  - The current available RAM on your server and its utilization rate as a percentage.
  - The current available memory on your server and its utilization rate as a percentage.
  - The current utilization rate of your processors as a percentage.
  - The date and time of the last reboot.
  - Whether LVM is active or not.
  - The number of active connections.
  - The number of users using the server.
  - The IPv4 address of your server and its MAC (Media Access Control) address.
  - The number of commands executed with the sudo program.
- WordPress bonus
- Set up service

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

- 'sudo adduser <username>' as root to add a user
- 'sudo adduser <username> <group>' to add a user to a group
- 'gpasswd -d <username> <group>' to remove a user from a group
- swap partition swappiness found in '/proc/sys/vm/swappiness' (or use 'sysctl vm.swappiness=20')
- 'more /etc/passwd' to look at the userlist
- 'hostnamectl' and 'more /etc/hosts' to look at the hostname
- 'hostnamectl set-hostname newhostname' and then modify /etc/hosts (use vim, apt install vim)
- 'sudo apt install ufw' and 'sudo ufw status verbose' to install ufw and check if it's active
- 'sudo ufw enable' to enable and 'sudo ufw allow 4242/tcp' to add 4242
- apparently no need to do 'sudo ufw allow OpenSSH' but why?
- for ssh : 'sudo systemctl status ssh' to check ssh status
- 'sudo service ssh stop' to stop or start openssh
- ssh automatically opens on boot, to disable permanently use 'sudo systemctl disable ssh'
