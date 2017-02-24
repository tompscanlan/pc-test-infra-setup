module "Infra" {
  source = "../../modules/slave-worker-pair-infrastructure"

  openstack_keypair_name = "jenkins_server"
  openstack_keypair_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCi3AA2bA7KNRexXQn97a0eGcP2+3QUy7IvQlCG8TJsejE56t8AOQjG75HaS8ziN8DW0cxkcGydGaYONCdPgVjYJP6DVjTVNQJEAWsOXkHq6U03E22we7csQTUA3i7DQFy8be8DMZ5EoiTx4z7dZp7nJsaFtsqXYMGFC+L16xA/zi+GXoFyV67cgq97jeJO3FOlQ/zM5ntORT4CGMK0Gyme6pNbBPjp9cgWVB4uWgcivuNPI8p48hX/I8ixKoUbR8pytx15ndFFQrij3yfdfunbB+TpGfx/2tylrGl41Ggs3I4CPwgXIniqxsdJUyDjOdUFurMuUgk5gMaE0yOkz7uf jenkins@jenkins"

# ------------ Variables values ------------
#  Name of the network to be created
#  default Value is Network_1
#  tenant_network = "Network_1"

# Name of the Router that needs to be created
# default value os Router_1
#  router_name = "Router_1"

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
}


# Copying the below module multiple times will create multiple
# pairs of Slave and Workers
module "slave-worker-pair1" {
  source = "../../modules/slave-worker-pair-VMs"
  slave_name = "slave02"
  worker_name = "worker02"

# ------------ Infrastructure Credentials ------------
  network_id = "${module.Infra.get_network_id}"
  external_network = "${module.Infra.get_ext_pool_id}"
  openstack_user_name = "${module.Infra.get_openstack_user_name}"
  openstack_tenant_name = "${module.Infra.get_openstack_tenant_name}"
  openstack_domain_id = "${module.Infra.get_openstack_domain_id}"
  openstack_password = "${module.Infra.get_openstack_password}"
  openstack_auth_url = "${module.Infra.get_openstack_auth_url}"
  openstack_insecure = "${module.Infra.get_openstack_insecure}"

  openstack_keypair_name = "${module.Infra.get_openstack_keypair_name}"
  openstack_keypair_public_key = "${module.Infra.get_openstack_keypair_public_key}"
}
output "slave-worker-pair1" {
    value = ["${module.slave-worker-pair1.FIP}",
    "${module.slave-worker-pair1.SlaveIP}",
    "${module.slave-worker-pair1.WorkerIP}"]
}


module "slave-worker-pair2" {
  source = "../../modules/slave-worker-pair-VMs"
  slave_name = "slave03"
  worker_name = "worker03"

# ------------ Infrastructure Credentials ------------
  network_id = "${module.Infra.get_network_id}"
  external_network = "${module.Infra.get_ext_pool_id}"
  openstack_user_name = "${module.Infra.get_openstack_user_name}"
  openstack_tenant_name = "${module.Infra.get_openstack_tenant_name}"
  openstack_domain_id = "${module.Infra.get_openstack_domain_id}"
  openstack_password = "${module.Infra.get_openstack_password}"
  openstack_auth_url = "${module.Infra.get_openstack_auth_url}"
  openstack_insecure = "${module.Infra.get_openstack_insecure}"


  openstack_keypair_name = "${module.Infra.get_openstack_keypair_name}"
  openstack_keypair_public_key = "${module.Infra.get_openstack_keypair_public_key}"
}
output "slave-worker-pair2" {
    value = ["${module.slave-worker-pair2.FIP}",
    "${module.slave-worker-pair2.SlaveIP}",
    "${module.slave-worker-pair2.WorkerIP}"]
}
