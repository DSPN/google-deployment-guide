#!/bin/bash

#Use push_keys.sh after running ssh-keygen on one node to create a keypair
#that OpsCenter will use to deploy the software. Once this is done, paste
#the contents of the private key (~/.ssh/id_rsa by default) into the 
#private key text field of the OpsCenter "Create New Cluster" dialog.

gcutil --project="datastax-perf" --format csv listinstances | grep '^dse' | awk -F ',' '{print $4}' > /tmp/DSE_IP_addrs.txt
 
for node in `cat /tmp/DSE_IP_addrs.txt`
do
	ssh-copy-id -i ~/.ssh/id_rsa.pub $node
done
