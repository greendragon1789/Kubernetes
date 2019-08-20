# Using Terraform for provisioning Kubernetes

Using Terraform to create **Private Cluster**
```
# terraform plan
# terraform apply
```
**Note**: .json file get from AWS or GCP, in GCP is Service Access with Full Permission.

## Create Kubernetes with CLI
```
gcloud beta container clusters create default \
  --no-enable-basic-auth \
  --no-issue-client-certificate \
  --metadata disable-legacy-endpoints=true \
  --enable-autoupgrade \
  --enable-cloud-logging \
  --enable-ip-alias \
  --machine-type=n1-standard-2 \
  --network=be \
  --subnetwork=be-app \
  --tags=k8s-node \
  --enable-autoscaling \
  --max-nodes=9 \
  --min-nodes=3 \
  --enable-private-nodes \
  --zone=asia-southeast1-a \
  --service-account=k8s@veep-production.iam.gserviceaccount.com \
```


## Create node pool with CLI
```
gcloud container node-pools create pool-2 \
--cluster=qa \
--machine-type=n1-standard-2 \
--num-nodes=3 \
--service-account=k8s-cluster-sa@veep-staging.iam.gserviceaccount.com \
--preemptible \
--enable-autoupgrade \
--enable-autoscaling \
--max-nodes=6 \
--min-nodes=1 \
--region=asia-southeast1-a
```
* Note: Add **service-account** params when create, it can not edit after


## Create Router and NAT
After create `Private Cluster`, All nodes cannot reach the Internet. So, must create the Cloud Router in same region as the instances that use Cloud NAT to reach the Internet. If do not reach the Internet, it cause of fail pull images from Internet.
Using Gloud CLI to create a Cloud Router:
```
gcloud compute routers create demo-router \
    --network demo-cluster \
    --region asia-southeast1
```
Using Gloud CLI to create a NAT:
```
gcloud compute routers nats create demo-nat \
    --router-region asia-southeast1 \
    --router demo-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips
```
Or follow the post on [The Medium](https://medium.com/google-cloud/using-cloud-nat-with-gke-cluster-c82364546d9e)

## Delete Router and NAT
```
gcloud compute routers nats delete demo-nat --router=demo-router --router-region asia-southeast1
gcloud compute routers delete demo-router --region asia-southeast1
```
#