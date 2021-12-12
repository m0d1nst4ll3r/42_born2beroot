#!/bin/bash

M_ARCH=$(uname -a)
M_CPU=$(cat /proc/cpuinfo | grep "physical id" | sort | uniq | wc -l)
M_VCPU=$(nproc)
M_RAM=$(free --mega | grep Mem | awk '{printf "%d/%dMB (%d%%)", $3, $2, $3/$2*100}')
M_DISK=$(df | tail -n+2 | awk '{tot+=$2} {cur+=$3} END {printf "%.1f/%.1fGB (%.1f%%)", cur/1000000, tot/1000000, cur/tot*100}')
M_LOAD=$(top -bn1 | grep Cpu | tr -d 'usydhwatni,' | awk '{printf "%.1f%%", 100 - $5 - $9}')
M_BOOT=$(who -b | awk '{print $3}')
M_LVM=$(
if [ $(lsblk | grep "lvm" | wc -l) -gt "0" ]
then echo "yes"
else echo "no"
fi)
M_TCP=$(ss -s | grep estab | awk '{print $4}' | tr -d ',\n' && echo ' ESTABLISHED')
M_USER=$(who | awk '{print $1}' | sort | uniq | wc -l)
M_IP=$(ip a | grep 'ether\|global' | awk '{print $2}' | sed 's/\/.*//' | tr '\n' ' ' | awk '{printf "IP %s (%s)", $2, $1}')
M_SUDO=$(cat /var/log/sudo/logs | grep -c "COMMAND" && echo " cmd")

echo "#Architecture	: ${M_ARCH}"
echo "#CPU Physical	: ${M_CPU}"
echo "#vCPU		: ${M_VCPU}"
echo "#Memory Usage	: ${M_RAM}"
echo "#Disk Usage	: ${M_DISK}"
echo "#CPU Load	: ${M_LOAD}"
echo "#Last Boot	: ${M_BOOT}"
echo "#LVM Use	: ${M_LVM}"
echo "#TCP Connections: ${M_TCP}"
echo "#User Log	: ${M_USER}"
echo "#Network	: ${M_IP}"
echo "#Sudo		: ${M_SUDO}"
