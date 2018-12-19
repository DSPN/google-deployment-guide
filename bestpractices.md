# Best Practices for DataStax Enterprise (DSE) Deployment in Google Cloud Platform (GCP)

This guide covers recommendations for compute, storage, network and more on Google Cloud Platform.

## Compute

DataStax Enterprise (DSE) workloads perform best when given a balance of CPU, Memory and low-latency storage. The following GCE machine-types are recommended because they provide a good mix of system resources for a range of workloads. The specific machine type that is right for a given application will depend on the performance requirements of the application in production.
* n1-standard-16 or above
* n1-highmem-16 or above (for DSE Search and DSE Analytics workloads)

For more information on machine types, please visit: https://cloud.google.com/compute/docs/machine-types

The DataStax documentation provides detail on recommended machine types as well: http://docs.datastax.com/en/latest-dse/datastax_enterprise/install/installGUI.html


## Storage

There are plenty of options in terms of persistent storage selection in GCP.  You can always choose one most suitable for your application performance and cost needs.

Local SSDs are physically attached to the server host that hosts your virtual machine instance. Local SSDs have higher throughput and lower latency than standard persistent disks or SSD persistent disks. The data that you store on a local SSD persists only until the instance is stopped or deleted. In addition, you cannot create snapshot from a local SSD. You will need a backup strategy to accommodate for this type of disk to ensure no data loss.

Each local SSD is 375 GB in size, but you can attach up to eight local SSD devices for 3 TB of total local SSD storage space per instance. One could combine multiple local SSD devices into a single logical volume to achieve the best local SSD performance per instance.

Persistent disks have many advantages.  Their performance is predictable and scale linearly with provisioned capacity until the limits for an instance's provisioned vCPUs are reached.  They have built-in redundancy to protect your data against equipment failure. Additionally, you can create snapshots of persistent disks regularly to protect against data loss. These are the recommended disks for running DataStax Enterprise.

For more information on GCE disks, please visit: https://cloud.google.com/compute/docs/disks


## Network

### VPC Network
DataStax Enterprise (DSE) can be deployed in single global VPC network which can span multiple regions without communicating across the public Internet. Single connection points between VPC and on-premises resources provides global VPC access, reducing cost and complexity. Shared VPC is another option to deploy DSE in a more delegated VPC manner. It allows an organization to connect resources from multiple projects to a common VPC network, so that they can communicate with each other securely and efficiently using internal IPs from that network. When you use Shared VPC, you designate a project as a host project and attach one or more other service projects to it. Please visit https://cloud.google.com/vpc/docs/shared-vpc for more details. We have seen many of our customers deploying their applications in this fashion.

For more information on VPC Network, please visit https://cloud.google.com/vpc/docs/vpc

### Regions and Zones
GCP regions and zones roughly correspond to the DSE data center and rack concepts respectively. Regions are geographically separated from one another and contain zones that are physically isolated to reduce the chance of an event in one zone affecting resources in another. Geographic scale events such as hurricanes will likely only have an impact on any single region at a time. Zones should be mapped to DSE racks.  Multi-data center deployments will typically use each region as a data center.

For more information on GCP regions & zones, please visit: https://cloud.google.com/compute/docs/zones

### DSE Endpoint Snitch (to locate nodes and route requests)
While DataStax provides a Google specific snitch, we typically recommend GossipingPropertyFileSnitch (GPFS) for most deployments.  GPFS is the most widely used snitch.  It also allows for hybrid deployments either across clouds or on-premises.


## Cloud Interconnect

**Dedicated Interconnect** offers enterprise-grade connections to GCP if you want to extend your data center network into your Google Cloud projects. This solution allows you to directly connect your on-premises network to your GCP VPC. **Dedicated Interconnect** is useful to connect to your VPC, and in hybrid environments, to extend your corporate data center’s IP space into the Google cloud, or for high-bandwidth traffic (greater than 2Gbps), for example when transferring large data sets. **Dedicated Interconnect** can be configured to offer a 99.9% or a 99.99% uptime SLA. Please see the **Dedicated Interconnect** documentation for details on how to achieve these SLAs.

**Partner Interconnect (ATT/Century/Verizon):** You can also extend your data center network into your Google Cloud projects through the service providers you know and love, **Partner Interconnect** offers enterprise-grade connections similar to Dedicated Interconnect. This solution allows you to add connectivity from your on-premises network to your GCP VPC through one of Google Cloud’s many service provider partners.

In summary, all these options will provide your multi-tier application architecture as well as DSE hybrid cloud deployment architecture with a more predictable network latency, application response time, and enhanced security.


## First Party Integration
Google StackDriver provides a default dashboards for cloud and open source application services. It allows you to define custom dashboards with powerful visualization tools to suit your needs.

At its core of DataStax Enterprise is DataStax's own distribution of Apache Cassandra. If the Cassandra plugin is not configured, Monitoring will discover Cassandra services running in your Cloud Platform project by either searching instance names for cassandra or checking for ports opened to 9160 via firewall rules. The services discovered are displayed on the Cassandra Services page in the Resources menu.

If a more advanced monitoring is preferred, you can install the monitoring stackdriver [agent](https://cloud.google.com/monitoring/agent/install-agent), follow the instructions on this [page](https://cloud.google.com/monitoring/agent/plugins/cassandra) to configure the Cassandra plugin on your instances. Once configured, you will see [advanced Cassandra and JVM metrics](https://cloud.google.com/monitoring/agent/plugins/cassandra#monitored-metrics).


## Security
* Review the [security checklist](https://docs.datastax.com/en/dse/6.0/dse-admin/datastax_enterprise/security/secChecklists.html#secChecklists) for deploying DSE
* Review [DataStax Enterprise OpsCenter Security](https://docs.datastax.com/en/opscenter/6.5/opsc/configure/opscSecurity.html) for general guidance to secure your OpsCenter deployment
* It is not uncommon to co-locate DSE deploymenet with other workloads within the same GCP VPC network. Review [Securing DataStax Enterprise ports](https://docs.datastax.com/en/dse/6.0/dse-admin/datastax_enterprise/security/secFirewallPorts.html) to configure the appropriate firewall rules and route rules in your GCP VPC network.
* Always use private ip addresses for DSE instances and OpsCenter instance.
* Always enable authentication and SSL access for your OpsCenter deployment. Configure GCP VPC network firewall rule to allow external access to the OpsCenter web console.  The default secure port is 8443.


