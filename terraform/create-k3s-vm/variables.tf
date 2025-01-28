# variables.tf
variable "proxmox_api_url" {
  description = "The URL of the Proxmox API"
  type        = string
}

variable "proxmox_api_token_id" {
  description = "The token ID of the Proxmox API"
  type        = string
  sensitive   = true
}

variable "proxmox_api_token" {
  description = "The token of the Proxmox API"
  type        = string
  sensitive   = true
}

variable "template_name" {
  description = "The name of the template to clone"
  type        = string
}

variable "proxmox_target_node" {
  description = "The target Proxmox node"
  type        = string
}

variable "network_bridge" {
  description = "The network bridge to use"
  type        = string
  default     = "vmbr0"
}

variable "gateway" {
  description = "The gateway IP address"
  type        = string
}

variable "password" {
  description = "The password for VM access"
  type        = string
  sensitive   = true
}

variable "k3s_master_nodes" {
  description = "A list of K3s master node configurations"
  type = list(object({
    name          = string
    vmid          = string
    username      = string
    vm_ip_address = string
    ram           = number
    cores         = number
    tags          = string
  }))
}

variable "k3s_worker_nodes" {
  description = "A list of K3s worker node configurations"
  type = list(object({
    name          = string
    vmid          = string
    username      = string
    vm_ip_address = string
    ram           = number
    cores         = number
    tags          = string
  }))
}

variable "bastion-id" {
  description = "The ID of the bastion node"
  type        = string
}