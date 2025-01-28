# Create K3s master nodes
module "k3s_master" {
  source = "./modules/proxmox_vm"

  for_each = { for idx, master in var.k3s_master_nodes : idx => master }

  name           = each.value.name
  description    = "[K3s Master] ${each.value.name}"
  vmid           = each.value.vmid
  target_node    = var.proxmox_target_node
  template_name  = var.template_name
  cores          = each.value.cores
  memory         = each.value.ram
  network_bridge = var.network_bridge
  ip_address     = each.value.vm_ip_address
  gateway        = var.gateway
  username       = each.value.username
  password       = var.password
  tags           = each.value.tags
  ssh_public_key = <<EOF
  YOUR_SSH_PUBLIC_KEY
EOF
}

# Create K3s worker nodes
module "k3s_worker" {
  source = "./modules/proxmox_vm"

  for_each = { for idx, worker in var.k3s_worker_nodes : idx => worker }

  name           = each.value.name
  description    = "[K3s Worker] ${each.value.name}"
  vmid           = each.value.vmid
  target_node    = var.proxmox_target_node
  template_name  = var.template_name
  cores          = each.value.cores
  memory         = each.value.ram
  network_bridge = var.network_bridge
  firewall       = true
  ip_address     = each.value.vm_ip_address
  gateway        = var.gateway
  username       = each.value.username
  password       = var.password
  tags           = each.value.tags
  ssh_public_key = <<EOF
  YOUR_SSH_PUBLIC_KEY
EOF
}
