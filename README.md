# Google Deployment Guide

Best practices for deploying DataStax Enterprise (DSE) on Google Cloud Platform (GCP) are covered [here](./bestpractices.md).

Instructions on deploying DSE via the Google Cloud Launcher are [here](./cloudlauncher.md).

Google includes both an IaaS service called Google Compute Engine (GCE) and a container service based on Kubernetes called Google Container Enginer (GKE).  DSPN hosts Google Deployment Manager (DM) templates that target both platforms:
* [Google Compute Engine (GCE)](https://github.com/DSPN/google-compute-engine-dse)
* [Google Container Enginer (GKE)](https://github.com/DSPN/google-container-engine-dse)
