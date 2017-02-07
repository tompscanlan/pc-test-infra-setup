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

resource "openstack_compute_keypair_v2" "jenkins_master" {
    name = "jenkins_master"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCnba+HYEtXoiB+X80QyTMF7/AZBpjyZEmeXQ9iRdHHCGFIgy31pSwMFDmtmPhfjbX8a/KKyM23OtnRy0xfCPu5hO+bQztymzwL+tLyCtCWSwBLR4yMCPMd+nrnWD/uoKcgF52yT8NkfcPh9uGySZoxUdcn9E1GOlWjYGyv+Pf8pb6wWJhiEx4SEON8XpuHjuKZw5FmyL7xayrpBPtNPplB5Gw87SGfRIpQ5bVmFzeZ0t0mLqOdWPGDV1hmijBRZE0xcc8nh36c3x6/bK1de++S3eVb51DnEBcpVo05JrmoCF286xdFf0yFPa1xbjF6RQuGYn8uQaJae52wpDpXw9Ex root@test"
}
