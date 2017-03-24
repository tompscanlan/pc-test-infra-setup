data "template_file" "script" {
  template = "${file("${path.module}/init.sh")}"
}

resource "openstack_compute_floatingip_v2" "jenkins_public_ip" {

  count = "${var.pairs_count}"
  pool = "${var.external_network}"
}


# Create a Jenkins Slave
resource "openstack_compute_instance_v2" "jenkins_instance" {
  count = "${var.pairs_count}"
  name = "jenkins-${count.index}"
  image_id = "728d255d-7d19-4c0b-a235-1c6eb3130057"
  flavor_name = "Dev-4vcpu-16mem-250Gb"
  key_pair = "${var.openstack_keypair_name}"
  user_data = "${data.template_file.script.rendered}"

  network {
    name = "public"
    floating_ip = "${element(openstack_compute_floatingip_v2.jenkins_public_ip.*.address, count.index)}"
  }
  network {
    name = "internal"
    fixed_ip_v4 = "10.1.${count.index}.2"
  }
}

# Create Worker for Jenkin's Slave
resource "openstack_compute_instance_v2" "esxi_instance" {
  count = "${var.pairs_count}"
  name = "esxi-${count.index}"
  image_id = "a6b5495f-046c-42d5-84be-3572d8c9f463"
  flavor_name = "ESXi-4vcpu-16-200G"

  network {
#    port = "${openstack_networking_port_v2.port_2.id}"
#    fixed_ip_v4 = "10.1.1.11"
    uuid = "${var.network_id}"
    #name = "subnet-${count.index}"
    name = "internal"

    fixed_ip_v4 = "10.1.${count.index}.3"
  }
}


output "FIP" {
  value = ["${openstack_compute_floatingip_v2.jenkins_public_ip.*.address}"]
}
output "SlaveIP" {
  value = ["${openstack_compute_instance_v2.jenkins_instance.*.access_ip_v4}"]
  }

output "WorkerIP" {
  value = ["${openstack_compute_instance_v2.esxi_instance.*.access_ip_v4}"]
  }
