resource "google_compute_network" "demo-network" {
  name = "${var.demo-network}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "demo_network_subnetwork" {
  name          = "subnetwork-${var.demo-network}"
  region        = "${var.region}"
  network       = "${google_compute_network.demo-network.self_link}"
  ip_cidr_range = "${var.subnet-demo-node}"

  secondary_ip_range {
      range_name    = "demo-subnetwork-pods"
      ip_cidr_range = "${var.subnet-demo-pods}"
  }

  secondary_ip_range {
      range_name    = "demo-subnetwork-services"
      ip_cidr_range = "${var.subnet-demo-services}"
  }
}