variable "openstack_user_name" {
    description = "The username for the Tenant."
    default  = "admin"
}

variable "openstack_tenant_name" {
    description = "The name of the Tenant."
    default  = "Test"
}

variable "openstack_domain_id" {
    description = "the Name for OpenStack Domain"
    default = "default"
}
variable "openstack_password" {
    description = "The password for the Tenant."
    default  = "VMware1!"
}

variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
    default  = "https://10.40.206.155:5000/v2.0"
}

variable "openstack_insecure" {
    description = "Do Not verify Cerificate Authority"
    default = "True"
}
variable "openstack_keypair" {
    description = "The keypair to be used."
    default  = "Jenkins_Master"
}

variable "tenant_network" {
    description = "The network to be used."
    default  = "network_1"
}
# Variable File
