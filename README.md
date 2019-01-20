# Create cluster in Kubernetes
Using Terraform to create **Private Cluster**
```
# terraform plan
# terraform apply
```
**Note**: .json file get from AWS or GCP, in GCP is Service Access with Full Permission.


# Create Router and NAT
After create `Private Cluster`, All nodes cannot reach the Internet. So, must create the Cloud Router in same region as the instances that use Cloud NAT to reach the Internet. If do not reach the Internet, it cause of fail pull images from Internet.
Using Gloud CLI to create a Cloud Router:
```
gcloud compute routers create demo-router \
    --network demo-cluster \
    --region  asia-southeast1
```
Using Gloud CLI to create a NAT:
```
gcloud compute routers nats create nat-config \
    --router-region asia-southeast1 \
    --router demo-router \
    --nat-all-subnet-ip-ranges \
    --auto-allocate-nat-external-ips
```
Or follow the post on [The Medium](https://medium.com/google-cloud/using-cloud-nat-with-gke-cluster-c82364546d9e)
