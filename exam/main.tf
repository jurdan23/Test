provider "google" {
	credentials = "${file("${var.credentials}")}"
	project = "${var.project}"
	region = "${var.region}"
	zone = "${var.zone}"
}

resource "google_compute_instance" "vm_instance1" {
	name = "terraform-instance1"
	machine_type = "f1-micro"
	
	boot_disk {
		initialize_params {
			image = "debian-cloud/debian-10"
		}
	}

	metadata_startup_script = "sudo apt-get update && sudo apt-get install -y nginx && sudo service nginx start"


	network_interface {
    network = "default"
    access_config {
    }
  }
}

resource "google_compute_instance" "vm_instance2" {
	name = "terraform-instance2"
	machine_type = "f1-micro"
	
	boot_disk {
		initialize_params {
			image = "debian-cloud/debian-10"
		}
	}

	metadata_startup_script = "sudo apt-get update && sudo apt-get install -y python3-pip"


	network_interface {
    network = "default"
    access_config {
    }
  }
}

resource "google_sql_database_instance" "instance" {
  name   = "fufik"
  region = "europe-north1"
  settings {
    tier = "db-f1-micro"
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = "default"
  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }

  source_tags = ["terraform-instance1"]
}
resource "google_compute_network" "default" {
  name = "test-network"
}