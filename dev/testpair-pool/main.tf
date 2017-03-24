module "networking" {
  source = "../../modules/networking"

  openstack_keypair_name = "jenkins_server"
  openstack_keypair_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi3AA2bA7KNRexXQn97a0eGcP2+3QUy7IvQlCG8TJsejE56t8AOQjG75HaS8ziN8DW0cxkcGydGaYONCdPgVjYJP6DVjTVNQJEAWsOXkHq6U03E22we7csQTUA3i7DQFy8be8DMZ5EoiTx4z7dZp7nJsaFtsqXYMGFC+L16xA/zi+GXoFyV67cgq97jeJO3FOlQ/zM5ntORT4CGMK0Gyme6pNbBPjp9cgWVB4uWgcivuNPI8p48hX/I8ixKoUbR8pytx15ndFFQrij3yfdfunbB+TpGfx/2tylrGl41Ggs3I4CPwgXIniqxsdJUyDjOdUFurMuUgk5gMaE0yOkz7uf jenkins@jenkins"

# ------------ Variables values ------------
# name of the External Network in OpenStack.
# !!!!This needs to be pre-created!!!!
  external_network = "ext-net"

# Credentials for OpenStack
  openstack_user_name = "admin"
  openstack_tenant_name = "Test"
  openstack_domain_id = "default"
  openstack_password = "VMware1!"
  openstack_auth_url = "https://10.40.206.155:5000/v2.0"
  openstack_insecure = "True"
  subnets_count = "2"
}

# Copying the below module multiple times will create multiple
# pairs of Slave and Workers
module "dev-pair" {
  source = "../../modules/slave-worker-pair-VMs"
  pairs_count = "${module.networking.get_subnets_count}"

# ------------ Infrastructure Credentials ------------
  network_id = "${module.networking.get_network_id}"
  external_network = "${module.networking.get_ext_pool_id}"
  openstack_user_name = "${module.networking.get_openstack_user_name}"
  openstack_tenant_name = "${module.networking.get_openstack_tenant_name}"
  openstack_domain_id = "${module.networking.get_openstack_domain_id}"
  openstack_password = "${module.networking.get_openstack_password}"
  openstack_auth_url = "${module.networking.get_openstack_auth_url}"
  openstack_insecure = "${module.networking.get_openstack_insecure}"

  openstack_keypair_name = "${module.networking.get_openstack_keypair_name}"
  openstack_keypair_public_key = "${module.networking.get_openstack_keypair_public_key}"
}

//output "dev-pair" {
//    value = [
//      "${module.dev-pair.*.FIP}",
//      "${module.dev-pair.*.SlaveIP}",
//      "${module.*.WorkerIP}"
//    ]
//}
