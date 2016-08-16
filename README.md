#google-deployment-guide

About this Tutorial

This document describes how to use templates to deploy DataStax Enterprise (DSE) on the Google Compute Engine (GCE) service that is part of the Google Cloud Platform (GCP).


1 Best Practices for Google Cloud Platform

For detailed information about GCP, please visit: https://cloud.google.com/

GCP includes both Google Compute Engine (GCE) and Google Container Engine (GKE).  DataStax Enterprise can be deployed to either environment.  This guide covers hardware recommendations as well as Google Deployment Manager templates for deploying on GCE.

We are currently working on Deployment Manager templates for GKE as well as a Google Cloud Launcher solution.

1.1 Machine Types

DataStax Enterprise workloads perform best when given a balance of CPU, Memory and low-latency storage. The following GCE machine-types are recommended because they provide a good mix of system resources for a range of workloads. The specific machine type that is right for a given application will depend on the performance requirements of the application.

n1-standard-8
n1-standard-16
n1-highmem-8
n1-highmem-16
For more information on machine types, please visit: https://cloud.google.com/compute/docs/machine-types

The DataStax documentation provides detail on recommended machine types as well: http://docs.datastax.com/en/latest-dse/datastax_enterprise/install/installGUI.html

1.2 Storage

Google offers a variety of storage options.  For the vast majority of cases we suggest SSD persistent disks.  The Deployment Manager templates DataStax developed in conjunction with Google are based on SSD persistent disks.  We find allocating approximately 2TB per node with 1TB reserved for compaction offers the best performance in most cases.

Google also offers HDD persistent disks.  These are both less expensive and less performant than their SSD counterparts.  Given their relatively poor performance we do not recommend HDD persistent disks.

Local SSDs are another interesting option.  These are dedicated disks that are local to the host VM.  As a result they are more expensive than the persistent SSD.  They are also ephemeral, meaning that data can be lost if the instance is shut off.  Surprisingly persistent SSD outperformed local SSD in recent tests.  This is due to the parallelism of the persistent SSD.  Given all these factors we do not recommend local SSD for DataStax workloads.

Storage buckets are completely unsuitable for DataStax storage, however, they are great for backups.

Google recently introduced RAM disks.  These are local ephemeral drives based on RAM.  As such, they are likely to be extremely performant.  They are limited in size.  RAM disks may be an interesting option for performance sensitive workloads.

For more information on GCE disks, please visit: https://cloud.google.com/compute/docs/disks

1.3 Regions and Zones

GCP regions and zones roughly correspond to the DSE data center and rack concepts respectively. Regions are geographically separated from one another and contain zones that are physically isolated to reduce the chance of an event in one zone affecting resources in another. Geographic scale events such as hurricanes will likely only have an impact on any single region at a time. Zones should be mapped to DSE racks.  Multi-data center deployments will typically use each region as a data center.

While DataStax provides a Google specific snitch, we typically recommend GossipingPropertyFileSnitch (GPFS) for most deployments.  GPFS is the most widely used snitch.  It also allows for hybrid deployments either across clouds or on-premises.  

The templates currently provided do not make use of rack awareness.  Instead they use the GossipingPropertyFileSnitch and place replicas in a single rack. We would like to change this in future releases of the template.

For more information on GCP regions & zones, please visit: https://cloud.google.com/compute/docs/zones

2 Deploying DataStax Enterprise on GCE

2.1 Register for a GCP account

Follow Google’s instructions to get set up with an account and to activate cloud access.  Google offers a free trial for new users.

2.2 Install Google Cloud SDK

To install the Google Cloud SDK follow these instructions: https://cloud.google.com/sdk/

The SDK includes command line tools for interacting with GCP

2.3 Log in to the Console

In addition to the command line, GCP offers a web based console.  You can login to that here: https://console.developers.google.com

2.4 Create a Project

Use the console to create a project for the DataStax Enterprise deployment. Click the create project button and assign a useful name.  The project-id field has to be globally unique, so it is convenient to use the suggestion provided by the tool, but it is possible to specify it manually.



After creating the project, set it as the default project that gcloud will use for all commands with the command:

gcloud config set project myproject

2.5 Clone the Template Repo

Now that you have the gcloud tools installed, you’ll want to clone of copy of the template repo.  The GCE repo is here: https://github.com/DSPN/google-compute-engine-dse

To do that, use the command:

git clone https://github.com/DSPN/google-compute-engine-dse.git
If all went well, output should look something like this:



Now cd into the repo dir and list files there using the commands:

cd google-cloud-platform-dse
ls


Our main entry point is a file called deploy.sh. We can inspect that file using the commands:

clear
cat deploy.sh


This is an extremely simple shell script that invokes the Google Cloud SDK. It takes one argument, the name of the deployment. The deployment name needs to be unique within you project. The deploy.sh script also depends on the input file clusterParameters.yaml. This file defines our cluster topology. Let’s take a quick look with the following commands:

clear
cat clusterParameters.yaml


This config is going to create 3 nodes in each of 3 different regions, for a total of 9 nodes. Each node is a very small machine, an n1-standard-1. This isn’t a size we’d recommend for production use but is fine for testing out a deployment. Similarly, each node will be configured with a 10GB pd-ssd. This is an extremely small disk for a production environment but will be fine for our test deployment.

Two example config files are provided, clusterParameters.small.yaml and clusterParameters.large.yaml. The large one creates nodes in every Google zone currently available. You may need to request you core quotas be increased to run it.

We encourage you to look at the templates more and better understand what they’re doing. They are provided to get you started and we fully expect you to customize them in ways that suit your needs.

Now that we’ve had a look through the project, let’s try running it!

2.6 Create a Deployment

We’re going to start of by creating a new deployment. I’m going to call mine ben1. To create it, I’m going to enter the command:

./deploy.sh ben1
When I do that, I see the following output:



At this point, the physical resources on GCE have all provisioned. However, each machine has a script that runs and installs Java as well as provisioning DSE. That will take another few minutes to run.

2.7 Inspecting the Output

The easiest way to inspect output is in the web interface. You can access this at http://cloud.google.com.  Once logged in, click on "my console." If you click the three horizontal lines in the upper left and scroll down, you should see an option under "Tools" titled "Deployment Manager." Click that.



Now, click on your deployment and view the tree describing it:



The ben1-opscenter-vm is the machine running our instance of OpsCenter. I’m going to click select that and click "Manage Resource."



Scrolling down, I see the external ip for the OpsCenter machine. Enter that IP into your url bar and add ":8888" to access OpsCenter on port 8888. If you do this relatively quickly after deployment, all nodes might not yet be available.  It's also possible you will see an error stating agents can't connect as shown below.  Dismiss that.  To resolve it permanently, you may need to ssh into the opscenter box and run the command:

sudo service restart opscenterd


If the cluster build completes successfully, you should see the following if you used clusterParameters.small.yaml as input:

Clicking on the nodes button, we can now see a graphical view of the cluster topology:



At this point you have a running DSE cluster! You can ssh into any of the nodes using Google ssh console and begin working with DSE.  The OpsCenter node does not run DSE, only the OpsCenter administrator interface.  To do that click on any of the nodes in the Google Console and click ssh.  A window will open showing an SSH console.  Interesting commands to get your started include:

nodetool status
cqlsh


2.8 Deleting a Deployment

Deployments can be deleted via the command line or the web UI. To use the command line type the command:

gcloud deployment-manager deployments delete ben1

Running from the command line, I see the following output;



To delete the deployment in the web UI, click the trash can icon on the "Deployment Manager" page as show below:



3 Conclusion

This document covers the basics of getting up and running with DataStax Enterprise in GCP.  If you have questions or comments please direct those to ben.lackey@datastax.com or @benofben.