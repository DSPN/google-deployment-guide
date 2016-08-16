# Google Best Pracices

This section of the deployment guide covers recommendations for compute, storage, network and more.

## General

GCP includes both Google Compute Engine (GCE) and Google Container Engine (GKE).  DataStax Enterprise can be deployed to either environment.  This guide covers hardware recommendations as well as Google Deployment Manager templates for deploying on GCE.

We are currently working on Deployment Manager templates for GKE as well as a Google Cloud Launcher solution.

## Compute

DataStax Enterprise workloads perform best when given a balance of CPU, Memory and low-latency storage. The following GCE machine-types are recommended because they provide a good mix of system resources for a range of workloads. The specific machine type that is right for a given application will depend on the performance requirements of the application.
* n1-standard-2
* n1-standard-4
* n1-standard-8
* n1-standard-16
* n1-highmem-2
* n1-highmem-4
* n1-highmem-8
* n1-highmem-16

For more information on machine types, please visit: https://cloud.google.com/compute/docs/machine-types

The DataStax documentation provides detail on recommended machine types as well: http://docs.datastax.com/en/latest-dse/datastax_enterprise/install/installGUI.html

## Storage

Google offers a variety of storage options.  For the vast majority of cases we suggest SSD persistent disks.  The Deployment Manager templates DataStax developed in conjunction with Google are based on SSD persistent disks.  We find allocating approximately 2TB per node with 1TB reserved for compaction offers the best performance in most cases.

Google also offers HDD persistent disks.  These are both less expensive and less performant than their SSD counterparts.  Given their relatively poor performance we do not recommend HDD persistent disks.

Local SSDs are another interesting option.  These are dedicated disks that are local to the host VM.  As a result they are more expensive than the persistent SSD.  They are also ephemeral, meaning that data can be lost if the instance is shut off.  Surprisingly persistent SSD outperformed local SSD in recent tests.  This is due to the parallelism of the persistent SSD.  Given all these factors we do not recommend local SSD for DataStax workloads.

Storage buckets are completely unsuitable for DataStax storage, however, they are great for backups.

Google recently introduced RAM disks.  These are local ephemeral drives based on RAM.  As such, they are likely to be extremely performant.  They are limited in size.  RAM disks may be an interesting option for performance sensitive workloads.

For more information on GCE disks, please visit: https://cloud.google.com/compute/docs/disks

## Network

GCP regions and zones roughly correspond to the DSE data center and rack concepts respectively. Regions are geographically separated from one another and contain zones that are physically isolated to reduce the chance of an event in one zone affecting resources in another. Geographic scale events such as hurricanes will likely only have an impact on any single region at a time. Zones should be mapped to DSE racks.  Multi-data center deployments will typically use each region as a data center.

While DataStax provides a Google specific snitch, we typically recommend GossipingPropertyFileSnitch (GPFS) for most deployments.  GPFS is the most widely used snitch.  It also allows for hybrid deployments either across clouds or on-premises.

The templates currently provided do not make use of rack awareness.  Instead they use the GossipingPropertyFileSnitch and place replicas in a single rack. We would like to change this in future releases of the template.

For more information on GCP regions & zones, please visit: https://cloud.google.com/compute/docs/zones
