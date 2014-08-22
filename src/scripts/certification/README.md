#GCE Setup for Certification benchmark

##  Setting up Gcloud

    #Downloaded gcloud util
    curl https://sdk.cloud.google.com | bash
    ./google-cloud-sdk/install.sh
    gcloud auth login
    gcloud config set project datastax-perf


##Instance setup
Choose Debian 7 image

1.333tb space, everything on one volume two partitions

[Disk Limits](https://developers.google.com/compute/docs/disks)

[Disk Write Limits](https://developers.google.com/compute/docs/disks#network_egress_caps)

To get maximum write IO I choose 1333gb for max write IO, although I may have been able to get
better read performance with a bigger drive. I also decided I would use a single volume per instance
as GCE doesn't perform better with multiple volumes. (see above links)

### Create Statement for (1 Ops, 1 Stress, 1 C*)
    gcloud compute instances create \
        gce-tier1-ops gce-tier1-stress gce-tier1-cluster\
        --zone us-central1-a\
        --boot-disk-size 1333GB\
        --description Tier1GCECertification\
        --image debian-7\
        --machine-type n1-highmem-8
        
        
### Create Statement for (1 Ops, 3 Stress, 6 C*)
    gcloud compute instances create \
        gce-tier2-ops \
    gce-tier2-stress1 gce-tier2-stress2 \
    gce-tier2-cluster1 gce-tier2-cluster2 gce-tier2-cluster3 gce-tier2-cluster4 \
    gce-tier2-cluster5 gce-tier2-cluster6 gce-tier2-cluster1 gce-tier2-cluster2 gce-tier2-cluster3 gce-tier2-cluster4 \
    gce-tier2-cluster5 gce-tier2-cluster6\gce-tier2-cluster1 gce-tier2-cluster2 gce-tier2-cluster3 gce-tier2-cluster4 \
    gce-tier2-cluster5 gce-tier2-cluster6\ 
        --zone us-central1-a\
        --boot-disk-size 1333GB\
        --description Tier1GCECertification\
        --image debian-7\
        --machine-type n1-highmem-8
### Create Statement for (1 Ops, 10 stress, 30 C*)
    gcloud compute instances create \
    gce-tier3-ops \
    gce-tier3-stress1 \
    gce-tier3-stress2 \
    gce-tier3-stress3 \
    gce-tier3-stress4 \
    gce-tier3-stress5 \
    gce-tier3-stress6 \
    gce-tier3-stress7 \
    gce-tier3-stress8 \
    gce-tier3-stress9 \
    gce-tier3-stress10 \
    gce-tier3-cluster1 \
    gce-tier3-cluster2 \
    gce-tier3-cluster3 \
    gce-tier3-cluster4 \
    gce-tier3-cluster5 \
    gce-tier3-cluster6 \
    gce-tier3-cluster7 \
    gce-tier3-cluster8 \
    gce-tier3-cluster9 \
    gce-tier3-cluster10 \
    gce-tier3-cluster11 \
    gce-tier3-cluster12 \
    gce-tier3-cluster13 \
    gce-tier3-cluster14 \
    gce-tier3-cluster15 \
    gce-tier3-cluster16 \
    gce-tier3-cluster17 \
    gce-tier3-cluster18 \
    gce-tier3-cluster19 \
    gce-tier3-cluster20 \
    gce-tier3-cluster21 \
    gce-tier3-cluster22 \
    gce-tier3-cluster23 \
    gce-tier3-cluster24 \
    gce-tier3-cluster25 \
    gce-tier3-cluster26 \
    gce-tier3-cluster27 \
    gce-tier3-cluster28 \
    gce-tier3-cluster29 \
    gce-tier3-cluster30 \
        --zone us-central1-a\
        --boot-disk-size 1333GB\
        --description Tier1GCECertification\
        --image debian-7\
        --machine-type n1-highmem-8

### Create Statement for (1 Ops, 20 Stress, 60 C*)
    gcloud compute instances create \
    gce-tier4-ops \
    gce-tier4-stress1 \
    gce-tier4-stress2 \
    gce-tier4-stress3 \
    gce-tier4-stress4 \
    gce-tier4-stress5 \
    gce-tier4-stress6 \
    gce-tier4-stress7 \
    gce-tier4-stress8 \
    gce-tier4-stress9 \
    gce-tier4-stress10 \
    gce-tier4-stress11 \
    gce-tier4-stress12 \
    gce-tier4-stress13 \
    gce-tier4-stress14 \
    gce-tier4-stress15 \
    gce-tier4-stress16 \
    gce-tier4-stress17 \
    gce-tier4-stress18 \
    gce-tier4-stress19 \
    gce-tier4-stress20 \
    gce-tier4-cluster1 \
    gce-tier4-cluster2 \
    gce-tier4-cluster3 \
    gce-tier4-cluster4 \
    gce-tier4-cluster5 \
    gce-tier4-cluster6 \
    gce-tier4-cluster7 \
    gce-tier4-cluster8 \
    gce-tier4-cluster9 \
    gce-tier4-cluster10 \
    gce-tier4-cluster11 \
    gce-tier4-cluster12 \
    gce-tier4-cluster13 \
    gce-tier4-cluster14 \
    gce-tier4-cluster15 \
    gce-tier4-cluster16 \
    gce-tier4-cluster17 \
    gce-tier4-cluster18 \
    gce-tier4-cluster19 \
    gce-tier4-cluster20 \
    gce-tier4-cluster21 \
    gce-tier4-cluster22 \
    gce-tier4-cluster23 \
    gce-tier4-cluster24 \
    gce-tier4-cluster25 \
    gce-tier4-cluster26 \
    gce-tier4-cluster27 \
    gce-tier4-cluster28 \
    gce-tier4-cluster29 \
    gce-tier4-cluster30 \
    gce-tier4-cluster31 \
    gce-tier4-cluster32 \
    gce-tier4-cluster33 \
    gce-tier4-cluster34 \
    gce-tier4-cluster35 \
    gce-tier4-cluster36 \
    gce-tier4-cluster37 \
    gce-tier4-cluster38 \
    gce-tier4-cluster39 \
    gce-tier4-cluster40 \
    gce-tier4-cluster41 \
    gce-tier4-cluster42 \
    gce-tier4-cluster43 \
    gce-tier4-cluster44 \
    gce-tier4-cluster45 \
    gce-tier4-cluster46 \
    gce-tier4-cluster47 \
    gce-tier4-cluster48 \
    gce-tier4-cluster49 \
    gce-tier4-cluster50 \
    gce-tier4-cluster51 \
    gce-tier4-cluster52 \
    gce-tier4-cluster53 \
    gce-tier4-cluster54 \
    gce-tier4-cluster55 \
    gce-tier4-cluster56 \
    gce-tier4-cluster57 \
    gce-tier4-cluster58 \
    gce-tier4-cluster59 \
    gce-tier4-cluster60 \
        --zone us-central1-a\
        --boot-disk-size 1333GB\
         --description Tier1GCECertification\
        --image debian-7\
         --machine-type n1-highmem-8


##Prepare nodes for C* and DSE Installation
I took the output of the above creation statements and put into a file called ClusterInfo,
I then seperate out the name and Remote IP info so I can work with those.

    awk '{print $1}' ClusterInfo  > ClusterNames
    awk '{print $4}' ClusterInfo  > ClusterIps
    
Next i copied around my private key just so I could jump between nodes easier, probably better to make a brand new key for this
but I didn't. Note the following code uses gnu parallel `brew install parallel`. 

    cat ClusterNames | parallel gcloud compute copy-files ~/.ssh/google_compute_engine {}:~/.ssh/id_rsa --zone us-central1-a
    
    
Next I move up a file to help install java and a new script for recognizing the additional drive space and creating a new partition on it. The 
base image only as 
    
    cat ClusterNames | parallel gcloud compute copy-files ../JavaInstall.sh {}:~ --zone us-central1-a
    
    cat ClusterNames | parallel gcloud compute copy-files ../makenewpartitions.sh {}:~ --zone us-central1-a

Next lets run those files in parallel (uses pssh `brew install pssh`)

    pssh -h ClusterIps -i  -x "-i /Users/russellspitzer/.ssh/google_compute_engine -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no"  "sudo chmod +x makenewpartitions.sh; sudo ./makenewpartitions.sh"
    
    pssh -h ClusterIps -i  -x "-i /Users/russellspitzer/.ssh/google_compute_engine -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no"  "sudo chmod +x JavaInstall.sh; sudo ./JavaInstall.sh"
    
    pssh -h ClusterIps -i  -x "-i /Users/russellspitzer/.ssh/google_compute_engine -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no"  "sudo adduser --disabled-password --gecos '' cassandra; sudo chown -R cassandra:cassandra data"
    
For reasons i'm not quite sure of the java install fails sometimes on some machines, This command will attempt to reinstall 
on all machines which failed to install java so don't feel bad about running it multiple times. Keep running it until all machines
respond with success. This means Java has installed and is usable
    
    pssh -h ClusterIps  -x "-i /Users/russellspitzer/.ssh/google_compute_engine -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no"  "java -version && exit 0; sudo dpkg --configure -a; sudo apt-get remove oracle-java7-installer -y; sudo apt-get install oracle-java7-installer -y"


## Install opscenter
First open up 8888 on the network in the GCE gui, so that you can hit opscenter from outside the cluster

Log in to the ops node
    
    gcloud compute ssh gce-tier1-ops --zone us-central1-a

Install Opsceneter
    
    echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/datastax.community.list
    curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
    sudo apt-get update -y
    sudo apt-get install opscenter -y
    sudo service opscenterd start

Setup DSE Cluster from OpsCenter Interface.

1. Make sure native transport is on
2. Make sure you only pass in local ip addresses
3. The key you give for auth should be your google compute key

If install fails you can wipe the node by doing a `sudo apt-get uninstall` and then listing all the packages this will 
let you run the install command again. This will NOT wipe the packages from your local caches so it will be fast for all nodes
which successfully installed in the past.

## Setup eval kit
Install and setup the eval kit

    sudo apt-get install git -y
    sudo apt-get install ant -y
    git clone https://github.com/DSPN/eval-kit.git

## Run Certification Benchmarks


# Get it all back
When I was done I retrieved all my files with statements like
    
    gcloud compute copy-files gce-tier4-ops:eval-kit/distributed-stress/*results* .  

Graphing:

Move results into two folders for graphing

    one/ 
           1_write_heavy/
           1_write_only/
           1_read_heavy/
    
    multi/
           n_write_heavy/
           n_write_only/
           n_read_heavy/
           …

run `logMerger.py` to make mergedOutput.csv which is easier to use with R

Start R make some graphs
   
    library("ggplot2") # Install with install.packages("ggplot2")
    library("doBy") # Install with install.packages("doBy")
   
    onenode <- read.csv("mergedOutput.csv")
    multi <- read.csv("../multi/mergedOutput.csv")
    
    #Take a look at the per node rates 
    summaryBy( (T_pk.s/Cluster_Size) ~ Test, multi )
    
    #Generate some quick tables
    with (multi, tapply(T_pk.s, list(Cluster_Size,Test), mean ))
    with (single, tapply(T_pk.s, list(Cluster_Size,Test), mean ))
    with (single, tapply(M_.95, list(Cluster_Size,Test), median ))
     with (multi, tapply(M_.95, list(Cluster_Size,Test), median ))
    
    ggplot(single, aes( x=Time, y=M_.95)) + geom_point(alpha = 1/10,size=1) +facet_grid ( Test ~ . ) + ggtitle("Single Node Max 95th Percentile Latency") 
    
    ggplot(single ) + geom_density(aes(x=T_Ops.s)) +facet_grid ( Test ~ . ) + ggtitle("Single Node Transactions Per Second") 
    ggplot(single ) + geom_density(aes(x=T_Ops.s)) +facet_grid ( Test ~ . ) + ggtitle("Single Node Transactions Per Second")
    ggplot(multi, aes( x=Time, y=T_Ops.s)) + geom_point(alpha = 1/10,size=1) +facet_grid ( Test ~ Cluster_Size ) + ggtitle("Multiple Node Transactions Per Second") 
    png("gce_onenode_perf.png")
    ggplot(onenode) + geom_boxplot(aes(x=Test,y=T_Ops.s)) + ggtitle("GCE: 1 Node Performance\n 100M Ops\nCL=ONE")
    dev.off()

    ggplot(multi, aes(group = round(Cluster_Size,1), x=Cluster_Size, y=T_Ops.s)) + geom_boxplot(outlier.size=0) + geom_smooth(method = "lm",  aes(group=1)) +  facet_grid(. ~ Test)

    ggplot(multi, aes(group = round(Cluster_Size,1), x=Cluster_Size, y=M_.95)) + geom_boxplot(outlier.size=0) + scale_y_continuous(limits=c(0,1000)) + facet_grid(. ~ Test)

    ggplot(multi, aes(group = round(Cluster_Size,1), x=Cluster_Size, y=M_.95)) + geom_boxplot(outlier.size=0) + scale_y_continuous(limits=c(0,2500)) + facet_grid(. ~ Test)