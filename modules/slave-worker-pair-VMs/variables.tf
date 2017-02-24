# VMs Variable file
variable "openstack_keypair_name" {
    description = "The Name of the keypair to be used."
}

variable "openstack_keypair_public_key" {
    description = "The keypair to be used."
}

variable "slave_name" {
  description = "Name of the Slave VM"
  default = "slave01"
}

variable "worker_name" {
  description = "Name of the Worker VM"
  default = "Worker 01"
}

variable "network_id" {
  description = "ID of the Network to which VMs would be attached to"
}

variable "external_network" {
  description = "External network for the Cluster"
}

# Provider Credentials
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
