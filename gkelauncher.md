## DataStax Enterprise Kubernetes Application User Guide for the GCP Marketplace

This document provides instructions for deploying Datastax Enterprise (DSE) as a Kubernetes app in the GCP Marketplace

## IMPORTANT NOTE 
There are minimum cluster requirements that MUST be met for the deployment to succeed. Please ensure you have a cluster meeting these minimums before deploying. The requirements are *** 5 nodes of instance type n1-standard-4 with at least 60GB of disk size ***

## Installation
### Quick install with Google Cloud Marketplace
Get up and running with a few clicks! Install this DataStax Enterprise app to a Google Kubernetes Engine cluster using Google Cloud Marketplace. Follow the [on-screen instructions](https://console.cloud.google.com/marketplace/details/datastax-public/datastax-enterprise-gke).

### Veirfy the status of the DataStax Enterprise deployment
If your deployment is successful, you can check the status of your DataStax Enterprise cluster using the *nodetool status* command as follows:
```
kubectl exec -it "${APP_INSTANCE_NAME}-dse-server-0" --namespace "${NAMESPACE}" nodetool status
```
Sample output should look like the following:
```
Datacenter: Cassandra
=====================
Status=Up/Down
|/ State=Normal/Leaving/Joining/Moving
--  Address     Load       Tokens       Owns    Host ID                               Rack
UN  10.16.2.16  924.34 KiB  256          ?       29a8e88d-4dc4-4981-bee6-186c399a2a9d  rack1
UN  10.16.1.35  896.32 KiB  256          ?       f7ac0e87-7cd5-475b-a0a9-e9a0e73e2174  rack1
UN  10.16.0.37  935.8 KiB  256          ?       1c818e6c-c8fd-4f4e-a412-7aff5da18978  rack1
```

### Accessing DataStax Enterprise cloud database via cqlsh
You can run the following commands to access your DataStax Enterprise server via cqlsh as follows:
```
$ kubectl exec -it "${APP_INSTANCE_NAME}-dse-server-0" --namespace "${NAMESPACE}" /bin/bash
$ more /etc/hosts (to find out the IP address of the container)
$ cqlsh <IP-address-of-the-container>
```

### Accessing Opscenter
Find the EXTERNAL-IP of ${APP_INSTANCE_NAME}-dse-server-opsc-ext-lb using "kubectl get service" and point your browser at the URL as follows:
```
SERVICE_IP=$(kubectl get \
  --namespace "${NAMESPACE}" \
  svc "${APP_INSTANCE_NAME}-dse-server-opsc-ext-lb" \
  -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

echo "http://${SERVICE_IP}:8888"
```
You should see the console of DataStax Enterprise OpsCenter like below:
![](./img/opsc.png)


## Scaling the DataStax Enterprise cluster
Coming soon...


## Backup and restore
Will be provided in future releases


## Uninstall the DataStax Enterprise Kubernetes Application
Coming soon...


