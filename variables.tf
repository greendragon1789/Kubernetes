variable "zone" {
  default = "asia-southeast1-a"
}

variable "region" {
  default = "asia-southeast1"
}

variable "demo-network" {
  default = "demo-cluster"
}

variable "subnet-demo-node" {
  default = "10.6.0.0/22"
}

variable "subnet-demo-pods" {
  default = "10.8.0.0/16"
}

variable "subnet-demo-services" {
  default = "10.9.0.0/16"
}

variable "cluster-name" {
  default = "demo-k8s"
}
