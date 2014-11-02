#!/bin/bash

#This script creates $1 500GB GCE SSD drives and attaches those to $1 instances
#based on a boot image created from applying ./mod_wheezy-7.sh to a standard 
#GCE backports-debian-7-wheezy image.
#OpsCenter can deploy DSE to these nodes with no further optimization required.

num_nodes=${1:-1}
prefix=${2:-dse}
zone=${3:-us-central1-b}
#disk=${4:-pd-ssd}

for ((node=0; node < ${num_nodes}; node++)) 
do
	gcloud compute instances delete "${prefix}${node}" --zone ${zone}
	gcloud compute disks delete "${prefix}${node}ssd1" --zone ${zone}  
done
