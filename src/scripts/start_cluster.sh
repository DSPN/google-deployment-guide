#!/bin/bash

#This script creates $1 500GB GCE SSD drives and attaches those to $1 instances
#based on a boot image created from applying ./mod_wheezy-7.sh to a standard 
#GCE backports-debian-7-wheezy image.
#OpsCenter can deploy DSE to these nodes with no further optimization required.

#This will need to be updated to --service_version="v2" when it is available.

num_nodes=${1:-1}
prefix=${2:-dse}

for ((node=0; node < ${num_nodes}; node++)) 
do
			./gcutil --service_version="v2beta1" --project="datastax-perf" adddisk "${prefix}${node}ssd1" --zone="us-central1-b" --storage_type=SSD --size_gb="500"
				./gcutil --service_version="v2beta1" --project="datastax-perf" addinstance "${prefix}${node}" --zone="us-central1-b" --boot_disk_storage_type=SSD --image="dse-backports-debian-7-wheezy" --machine_type="n1-standard-8" --disk="${prefix}${node}ssd1",deviceName=ssd
		done

