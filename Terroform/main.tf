provider "google" {
	credentials = "${file("${var.credentials}")}"
	project = "${var.project}"
	region = "${var.region}"
	zone = "${var.zone}"
}

resource "google_compute_instance" "vm_instance" {
	name = "terraform-instance"
	machine_type = "f1-micro"
	
	boot_disk {
		initialize_params {
			image = "ubuntu-os-cloud/ubuntu-1910"
		}
	}

	network_interface {
    network = "default"
    access_config {
    }
  }
}
