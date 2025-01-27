# doc https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu#cdrom-25

resource "proxmox_vm_qemu" "srv_demo_1" {

  # VM Settings: Metadaten
  name        = var.vm_name
  desc        = var.vm_description
  vmid        = var.vm_id
  target_node = var.proxmox_target_node
  clone       = var.template_name

  # VM Advanced General Settings
  # onboot = 1

  # VM Settings: Ist der QEMU Agent auf der VM vorhanden? 1 = Ja; 0 = Nein
  agent = 0

  # SCSI Controller
  scsihw = "virtio-scsi-single"

  # Hardware Settings: CPU
  cores    = 1
  sockets  = 1
  cpu_type = "host"

  # Hardware Settings: RAM
  memory = 4096

  vga {
    type = "serial0"
  }

  serial {
    id   = 0
    type = "socket"
  }

  # Hardware Settings: Netzwerk
  network {
    id       = 0
    bridge   = "vmbr1"
    model    = "virtio"
    firewall = true
  }

  # Hardware Settings: Festplatte
  # Sie muss identisch zur Festplatte aus dem Proxmox Template sein. 
  # Andernfalls legt Terraform eine 2. Festplatte mit der Konfiguration an.
  disks {
    scsi {
      # must be identical to the disk in the Proxmox template
      scsi0 {
        disk {
          size    = 8
          storage = "local-lvm"
          discard = true
        }
      }
    }
    # add this to get Cloudinit Driver
    ide {
      ide2 {
        cloudinit {
          storage = "local-lvm"
        }
      }
    }
  }

  os_type = "cloud-init"

  # Optional: Network settings (Wird dann per Cloud-init gesetzt)
  ipconfig0 = "ip=${var.vm_ip_address},gw=${var.vm_ip_gateway},ip6=auto"
  # nameserver = "*.*.*.*" replace with your nameserver adress

  # Optional: User settings (Wird dann per Cloud-init gesetzt)
  ciuser     = var.vm_user
  cipassword = var.vm_password
  sshkeys    = <<EOF
  YOUR_SSH_PUB_KEY 
  EOF

}