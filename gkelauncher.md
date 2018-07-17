## DataStax Enterprise Kubernetes Application User Guide for the GCP Marketplace

This document provides instructions for deploying Datastax Enterprise (DSE) as a Kubernetes app in the GCP Marketplace

## IMPORTANT NOTE: 
There are minimum cluster requirements that MUST be met for the deployment to succeed. Please ensure you have a cluster meeting these minimums before deploying. The requirements are *** 5 nodes of instance type n1-standard-4 with at least 60GB of disk size ***

## Deployment
The Datastax Kubernetes offering can be found [here](https://console.cloud.google.com/marketplace/details/datastax-public/datastax-enterprise-gke)

From this landing page the user can see an overview of the DSE offering, read other Datastax tutorials and then configure the deployment of DSE. Selecting the "Configure" button takes you to the detail's page where Datastax Enterprise will use compute instances managed in a logical grouping called a "cluster". Verify you have met the minimum cluster requirements stated above before selecting the "Deploy" button

## Post Deployment

## Accessing Opscenter
Find the EXTERNAL-IP of svc/dse-dse-server-opsc-ext-lb using "kubectl get service"

Point your browser at http://<EXTERNAL-IP>:8888


## Checking DSE status / Accessing cqlsh
kubectl exec -it dse-dse-server-0 nodetool status

kubectl exec -it dse-dse-server-0 cqlsh

## Scaling
Scaling up and scaling down will be provided future release




