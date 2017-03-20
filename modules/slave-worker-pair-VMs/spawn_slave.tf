## Create Port for Jenkins Slave
#resource "openstack_networking_port_v2" "port_1" {
#  name = "port_1"
#  network_id = "${openstack_networking_network_v2.Infra_Network.id}"
#  admin_state_up = "true"
##  fixed_ip {
##      "subnet_id" =  "${openstack_networking_subnet_v2.subnet_1.id}"
##      "ip_address" =  "192.168.199.10"
##  }
#}
#
## Create Port for Worker
#resource "openstack_networking_port_v2" "port_2" {
#  name = "port_2"
#  network_id = "${openstack_networking_network_v2.Infra_Network.id}"
#  admin_state_up = "true"
##  fixed_ip {
##      "subnet_id" =  "${openstack_networking_subnet_v2.subnet_1.id}"
##      "ip_address" =  "192.168.199.10"
##  }
#}

data "template_file" "script" {
    template = "${file("${path.module}/init.sh")}"
  }

resource "openstack_compute_floatingip_v2" "Slave1_ip" {
#    depends_on = ["openstack_networking_network_v2.Infra_Network", "openstack_networking_subnet_v2.Infra_Subnet", "openstack_networking_router_v2.Infra_Router", "openstack_networking_router_interface_v2.Infra_Router_Infra_Network"]
#    count = 2
    pool = "${var.external_network}"
}
# Create a Jenkins Slave
resource "openstack_compute_instance_v2" "Slave1" {
#  depends_on = ["openstack_compute_floatingip_v2.Slave1_ip","openstack_networking_network_v2.Infra_Network", "openstack_networking_subnet_v2.Infra_Subnet", "openstack_networking_router_v2.Infra_Router", "openstack_networking_router_interface_v2.Infra_Router_Infra_Network" , "openstack_compute_keypair_v2.keypair"]
#  count = 2
  name = "${var.slave_name}"
#  image_id = "adc1687e-18ce-46c1-85f8-8f6392846608"
  image_id = "728d255d-7d19-4c0b-a235-1c6eb3130057"
  flavor_name = "Dev-4vcpu-16mem-250Gb"
  key_pair = "${var.openstack_keypair_name}"
  user_data = "${data.template_file.script.rendered}"

  network {
#    port = "${openstack_networking_port_v2.port_1.id}"
#    uuid = "${openstack_networking_network_v2.Infra_Network.id}"
    uuid = "${var.network_id}"
#    name = "Infra_Network"
#    fixed_ip_v4 = "10.1.1.10"
    floating_ip = "${element(openstack_compute_floatingip_v2.Slave1_ip.*.address, count.index)}"
#    floating_ip = "${openstack_compute_floatingip_v2.Slave1_ip.address}"
  }
#  network {
#    access_network = true
#  }
}

output "FIP" {
  value = ["${openstack_compute_floatingip_v2.Slave1_ip.*.address}"]
}
output "SlaveIP" {
  value = ["${openstack_compute_instance_v2.Slave1.*.access_ip_v4}"]
  }

output "WorkerIP" {
  value = ["${openstack_compute_instance_v2.Worker1.*.access_ip_v4}"]
  }

# Create Worker for Jenkin's Slave
resource "openstack_compute_instance_v2" "Worker1" {
#  depends_on = ["openstack_networking_network_v2.Infra_Network", "openstack_networking_subnet_v2.Infra_Subnet", "openstack_networking_router_v2.Infra_Router", "openstack_networking_router_interface_v2.Infra_Router_Infra_Network", "openstack_compute_keypair_v2.keypair"]
#  count = 2
  name = "${var.worker_name}"
  image_id = "a6b5495f-046c-42d5-84be-3572d8c9f463"
  flavor_name = "ESXi-4vcpu-16-200G"

  network {
#    port = "${openstack_networking_port_v2.port_2.id}"
#    fixed_ip_v4 = "10.1.1.11"
#    uuid = "${openstack_networking_network_v2.Infra_Network.id}"
    uuid = "${var.network_id}"
    name = "Infra_Network"
  }
}
