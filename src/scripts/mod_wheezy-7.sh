#!/bin/bash

#This script can be applied to a running GCE instance 
#to prep it for running DSE on SSD based storage, assumed 
#to be mounted at /dev/sdb. After this script has been applied,
#a GCE image can be created accordin to the instructions at the
#Image creation guide: https://developers.google.com/compute/docs/images#creatingimage
#Base OS list: https://developers.google.com/compute/docs/operating-systems#backportsimages

apt-get update
apt-get install -y less htop patch libjna-java sysstat iftop binutils pssh pbzip2 zip unzip openssl curl liblzo2-dev ntp git python-pip tree unzip dstat ethtool

#Don't need to disable swap
#Disable Swap
#swapoff -a

#Need to mount SSD
mkdir -p /var/lib/cassandra
#https://developers.google.com/compute/docs/disks#formatting
#/usr/share/google/safe_format_and_mount -m "mkfs.ext4 -F" <disk-name> <mount-point>
patch --backup /usr/share/google/safe_format_and_mount <<SFAM
24c24,25
< MOUNT_OPTIONS="discard,defaults"
---
> #MOUNT_OPTIONS="discard,defaults"
> MOUNT_OPTIONS="defaults,discard,noauto,noatime,barrier=0"
SFAM

patch --backup /etc/rc.local <<END
13a14,18
> echo deadline > /sys/block/sdb/queue/scheduler
> echo 0 > /sys/block/sdb/queue/rotational
> blockdev --setra 0 /dev/sdb
> /usr/share/google/safe_format_and_mount -m "mkfs.ext4 -F" /dev/sdb /var/lib/cassandra
> 
END

cat >> /etc/sysctl.conf <<EndCtl
vm.max_map_count = 131072
EndCtl

sysctl -p


mkdir -p /usr/share/dse/cassandra/lib
ln -s /usr/share/java/jna.jar /usr/share/dse/cassandra/lib/jna.jar

#From http://www.webupd8.org/2012/06/how-to-install-oracle-java-7-in-debian.html
#Missing default response bit...
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
apt-get update
echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
apt-get -y install oracle-java7-installer

