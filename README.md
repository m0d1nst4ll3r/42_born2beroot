#42_born2beroot

(estimated time: 30 minutes)

All of the mandatory tasks have been automated in setup.sh

Read and execute all the install instructions in setup.sh

Set up SSH to copy the files over to your VM using scp

Log as root and run setup.sh

Your VM is fully set up, except for wordpress and the extra service

List of tasks :

- Partition correctly (including bonus) (DO THIS AT INSTALL)
- Correct hostname
- Root user + login user
- login user belonging to user42 and sudo groups
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
    - no more than 3 identical characters in a row
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
