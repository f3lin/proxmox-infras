variable "name" {
  description = "The name of the VM"
  type        = string
}

variable "description" {
  description = "The description of the VM"
  type        = string
}

variable "vmid" {
  description = "The unique VM ID in Proxmox"
  type        = string
}

variable "target_node" {
  description = "The target Proxmox node"
  type        = string
  default     = "pve"
}

variable "template_name" {
  description = "The name of the template to clone"
  type        = string
}

variable "cores" {
  description = "Number of CPU cores for the VM"
  type        = number
}

variable "memory" {
  description = "Amount of RAM (in MB) for the VM"
  type        = number
}

variable "network_bridge" {
  description = "The network bridge to use"
  type        = string
  default     = "vmbr1"
}

variable "firewall" {
  description = "Enable or disable the firewall"
  type        = bool
  default     = true
}

variable "disk_size" {
  description = "Size of the VM disk in GB"
  type        = number
  default     = 8
}

variable "storage" {
  description = "The Proxmox storage to use"
  type        = string
  default     = "local-lvm"
}

variable "ip_address" {
  description = "The VM's IP address"
  type        = string
}

variable "gateway" {
  description = "The network gateway"
  type        = string
}

variable "username" {
  description = "The username for the VM"
  type        = string
}

variable "ssh_public_key" {
  description = "The SSH public key to add to the VM"
  type        = string
  sensitive = true
}

variable "password" {
  description = "The password for the VM"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = string  
}