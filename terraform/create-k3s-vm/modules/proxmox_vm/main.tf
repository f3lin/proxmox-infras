# modules/proxmox_vm/main.tf

resource "proxmox_vm_qemu" "vm" {
  name        = var.name
  desc        = var.description
  vmid        = var.vmid
  target_node = var.target_node
  clone       = var.template_name
  onboot      = true
  agent       = 0
  tags        = var.tags

  cores    = var.cores
  sockets  = 1
  cpu_type = "host"
  memory   = var.memory
  scsihw   = "virtio-scsi-single"

  vga {
    type = "serial0"
  }

  serial {
    id   = 0
    type = "socket"
  }

  network {
    id       = 0
    bridge   = var.network_bridge
    model    = "virtio"
    firewall = var.firewall
  }

  disks {
    scsi {
      scsi0 {
        disk {
          size    = var.disk_size
          storage = var.storage
          discard = true
        }
      }
    }
    ide {
      ide2 {
        cloudinit {
          storage = var.storage
        }
      }
    }
  }

  os_type     = "cloud-init"
  ipconfig0   = "ip=${var.ip_address},gw=${var.gateway},ip6=auto"
  ciuser      = var.username
  cipassword  = var.password
}
