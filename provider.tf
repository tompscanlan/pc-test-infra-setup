# Configure the OpenStack Provider
provider "openstack" {
    domain_id = "${var.openstack_domain_id}"
    user_name  = "${var.openstack_user_name}"
    tenant_name = "${var.openstack_tenant_name}"
    password  = "${var.openstack_password}"
    auth_url  = "${var.openstack_auth_url}"
    insecure = "${var.openstack_insecure}"
}
