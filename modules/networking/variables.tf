# Infrastructure Variable File

variable "openstack_user_name" {
    description = "The username for the Tenant."
}

variable "openstack_tenant_name" {
    description = "The name of the Tenant."
}

variable "openstack_domain_id" {
    description = "the Name for OpenStack Domain"
}
variable "openstack_password" {
    description = "The password for the Tenant."
}

variable "openstack_auth_url" {
    description = "The endpoint url to connect to OpenStack."
}

variable "openstack_insecure" {
    description = "Do Not verify Cerificate Authority"
}

variable "openstack_keypair_name" {
    description = "The Name of the keypair to be used."
}

variable "openstack_keypair_public_key" {
    description = "The keypair to be used."
}

variable "tenant_network" {
    description = "The network to be used."
    default = "Network_1"
}

variable "router_name" {
    description = "Name of the Router in OpenStack"
    default = "Router_1"
}

variable "external_network" {
  description = "Name of External Network"
  default = "ext-net"
}

variable "subnets_count" {
    description = "How many subnets to setup."
    default = 5
}
