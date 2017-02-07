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
resource "openstack_compute_floatingip_v2" "Slave1_ip" {
#    count = 2
    pool = "ext-net"
}
# Create a Jenkins Slave
resource "openstack_compute_instance_v2" "Slave1" {
  depends_on = ["openstack_compute_floatingip_v2.Slave1_ip","openstack_networking_network_v2.Infra_Network", "openstack_networking_subnet_v2.Infra_Subnet", "openstack_networking_router_v2.Infra_Router", "openstack_networking_router_interface_v2.Infra_Router_Infra_Network", "openstack_compute_keypair_v2.jenkins_master" ]
#  count = 2
  name = "slave1"
  image_id = "adc1687e-18ce-46c1-85f8-8f6392846608"
  flavor_name = "m1.large"
  key_pair = "jenkins_master"

  network {
#    port = "${openstack_networking_port_v2.port_1.id}"
    uuid = "${openstack_networking_network_v2.Infra_Network.id}"
    name = "Infra_Network"
#    floating_ip = "${format("openstack_compute_floatingip_v2.Slave1_ip.%d.address", count.index)}"
    floating_ip = "${openstack_compute_floatingip_v2.Slave1_ip.address}"
  }
#  network {
#    access_network = true
#  }
}

#output "out" {
#  value = "${format("%s -- %s", openstack_compute_floatingip_v2.Slave1_ip.1.address,openstack_compute_floatingip_v2.Slave1_ip.0.address)}"
#}

# Create Worker for Jenkin's Slave
resource "openstack_compute_instance_v2" "Worker1" {
  name = "worker1"
  image_id = "a6b5495f-046c-42d5-84be-3572d8c9f463"
  flavor_name = "ESXi-4vcpu-32mem-50gb"

  network {
#    port = "${openstack_networking_port_v2.port_2.id}"
    uuid = "${openstack_networking_network_v2.Infra_Network.id}"
    name = "Infra_Network"
  }
}
