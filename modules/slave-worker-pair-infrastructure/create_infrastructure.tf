# Create a Network
resource "openstack_networking_network_v2" "Infra_Network" {
  name = "Infra_Network"
  admin_state_up = "true"
}

# Create a Subnet
resource "openstack_networking_subnet_v2" "Infra_Subnet" {
  name = "Infra_Subnet"
  network_id = "${openstack_networking_network_v2.Infra_Network.id}"
  cidr = "10.1.1.0/24"
  dns_nameservers = ["10.20.20.1", "8.8.8.8"]
  ip_version = 4
#  enable_dhcp = false
}

# Create a Router
resource "openstack_networking_router_v2" "Infra_Router" {
  name = "Infra-Router"
	external_gateway = "d5c89e0d-75e0-4806-867a-19ece99226f0"
}

# Attach Router Interface to Subnet
resource "openstack_networking_router_interface_v2" "Infra_Router_Infra_Network" {
  router_id = "${openstack_networking_router_v2.Infra_Router.id}"
  subnet_id = "${openstack_networking_subnet_v2.Infra_Subnet.id}"
}

resource "openstack_compute_keypair_v2" "keypair" {
#    tags {
#      name = "${var.openstack_keypair}"
#      }
  name = "${var.openstack_keypair_name}"
  public_key = "${var.openstack_keypair_public_key}"
#  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi3AA2bA7KNRexXQn97a0eGcP2+3QUy7IvQlCG8TJsejE56t8AOQjG75HaS8ziN8DW0cxkcGydGaYONCdPgVjYJP6DVjTVNQJEAWsOXkHq6U03E22we7csQTUA3i7DQFy8be8DMZ5EoiTx4z7dZp7nJsaFtsqXYMGFC+L16xA/zi+GXoFyV67cgq97jeJO3FOlQ/zM5ntORT4CGMK0Gyme6pNbBPjp9cgWVB4uWgcivuNPI8p48hX/I8ixKoUbR8pytx15ndFFQrij3yfdfunbB+TpGfx/2tylrGl41Ggs3I4CPwgXIniqxsdJUyDjOdUFurMuUgk5gMaE0yOkz7uf jenkins@jenkins"
}
