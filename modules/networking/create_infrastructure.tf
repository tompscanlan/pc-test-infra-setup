# Create a Network
resource "openstack_networking_network_v2" "main_network" {
  admin_state_up = "true"
}

# Create a Subnet
resource "openstack_networking_subnet_v2" "subnet" {
  count = "${var.subnets_count}"
  name = "10.1.${count.index}"
  network_id = "${openstack_networking_network_v2.main_network.id}"

  cidr = "10.1.${count.index}.0/24"
  dns_nameservers = ["10.20.20.1", "8.8.8.8"]
  ip_version = 4
  enable_dhcp = true
  allocation_pools = [
    {
      start = "10.1.${count.index}.100"
      end = "10.1.${count.index}.250"
    }
  ]
}


# Create a Router
resource "openstack_networking_router_v2" "Infra_Router" {
  name = "Infra-Router"
  external_gateway = "d5c89e0d-75e0-4806-867a-19ece99226f0"
}

# Attach Router Interface to Subnet
resource "openstack_networking_router_interface_v2" "Infra_Router_Infra_Network" {
  count = "${var.subnets_count}"
  //name = "subnet-router-${count.index}"

  router_id = "${openstack_networking_router_v2.Infra_Router.id}"

//    availability_zone = "${element(var.azs, count.index)}"
//  instance = "${element(aws_instance.example.*.id, count.index)}"

  subnet_id = "${element(openstack_networking_subnet_v2.subnet.*.id, count.index)}"

}

resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.openstack_keypair_name}"
  public_key = "${var.openstack_keypair_public_key}"
}
