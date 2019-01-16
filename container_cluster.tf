resource "google_container_cluster" "demo-k8s" {
  name                = "${var.cluster-name}"
  zone                = "${var.zone}"

  network             = "${google_compute_network.demo-network.self_link}"
  subnetwork          = "${google_compute_subnetwork.demo_network_subnetwork.self_link}"

  ip_allocation_policy {
    cluster_secondary_range_name  = "${google_compute_subnetwork.demo_network_subnetwork.secondary_ip_range.0.range_name}"
    services_secondary_range_name = "${google_compute_subnetwork.demo_network_subnetwork.secondary_ip_range.1.range_name}"
  }

  master_authorized_networks_config {
    cidr_blocks = [
      { cidr_block = "0.0.0.0/0", display_name = "ALL"},
    ]
  }

  master_ipv4_cidr_block = "172.16.0.16/28"
  private_cluster = true

  node_pool {
    name        = "${var.cluster-name}-pool"
    node_count  = 2

    autoscaling {
      min_node_count = 2
      max_node_count = 6
    }

    node_config {
      disk_type = "pd-ssd"
      tags = ["${var.cluster-name}"]

      labels {
      group = "${var.cluster-name}"
      }
    }

    management {
      auto_upgrade = true
      auto_repair = true
    }
  }
}

# The following outputs allow authentication and connectivity to the GKE Cluster.
output "client_certificate" {
  value = "${google_container_cluster.demo-k8s.master_auth.0.client_certificate}"
}

output "client_key" {
  value = "${google_container_cluster.demo-k8s.master_auth.0.client_key}"
}

output "cluster_ca_certificate" {
  value = "${google_container_cluster.demo-k8s.master_auth.0.cluster_ca_certificate}"
}
