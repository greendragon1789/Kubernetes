provider "google" {
  credentials   = "${file("credentials.json")}"
  project       = "veep-devops-practice"
  region        = "${var.zone}"
}

provider "google-beta" {
  credentials   = "${file("credentials.json")}"
  project       = "veep-devops-practice"
  region        = "${var.zone}"
}