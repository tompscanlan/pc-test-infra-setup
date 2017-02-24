# infra Output File
# This file exports all the infra related variable in order to create VM later on

output "get_network_id" {
  value = "${openstack_networking_network_v2.Infra_Network.id}"
}

output "get_ext_pool_id" {
  value = "${var.external_network}"
}

output "get_openstack_user_name" {
  value = "${var.openstack_user_name}"
}

output "get_openstack_tenant_name" {
  value = "${var.openstack_tenant_name}"
}

output "get_openstack_domain_id" {
  value = "${var.openstack_domain_id}"
}

output "get_openstack_password" {
value = "${var.openstack_password}"
}

output "get_openstack_auth_url" {
  value = "${var.openstack_auth_url}"
}

output "get_openstack_insecure" {
  value = "${var.openstack_insecure}"
}

output "get_openstack_keypair_name" {
  value = "${var.openstack_keypair_name}"
}
output "get_openstack_keypair_public_key" {
  value = "${var.openstack_keypair_public_key}"
}
