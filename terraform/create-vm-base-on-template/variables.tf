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

variable "proxmox_target_node" {
  description = "The target node for the VM"
  type        = string
  default     = "pve"
}

variable "vm_description" {
  description = "The description of the VM"
  type        = string
  default = "[Debian12] Created with Terraform"
}

variable "vm_name" {
  description = "The name of the VM"
  type        = string
  default     = "terra-srv"
}

variable "vm_id" {
  description = "The ID of the VM"
  type        = string
  default     = "101"
}

variable "vm_user" {
  description = "The user for the VM"
  type        = string
  default     = "f3lin"
}

variable "vm_password" {
  description = "The password for the VM"
  type        = string
  sensitive   = true

}

variable "template_name" {
  description = "The name of the template to clone"
  type        = string
  default     = "temp-debian-12"
}

variable "vm_ip_address" {
  description = "The IP address of the VM"
  type        = string
  default     = "192.168.1.110/24"
}

variable "vm_ip_gateway" {
  description = "The gateway of the VM"
  type        = string
  default     = "192.168.1.245"

}