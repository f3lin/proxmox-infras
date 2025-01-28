proxmox_api_url      = "https://your-proxmox-url:8006/api2/json"
proxmox_api_token    = "your_proxmox_api_token"
proxmox_api_token_id = "your_pam_user@pam!your_pam_user_id"

gateway             = "your_gateway_ip"
network_bridge      = "your_network_bridge"
proxmox_target_node = "yo proxmox node"
template_name       = "the template name you want to clone"
password            = "password"

k3s_master_nodes = [
  {
    name          = "k3s-master-1"
    vmid          = "110"
    username      = "refus"
    vm_ip_address = "xxx.xxx.xxx.xxx/24"
    ram           = 4096
    cores         = 2
    tags          = "master,net-101,terraform,k3s"
  },
  {
    name          = "k3s-master-2"
    vmid          = "111"
    username      = "herakles"
    vm_ip_address = "xxx.xxx.xxx.xxx/24"
    ram           = 4096
    cores         = 2
    tags          = "master,net-101,terraform,k3s"
  }
]

k3s_worker_nodes = [
  {
    name          = "k3s-worker-1"
    vmid          = "112"
    username      = "jerry"
    vm_ip_address = "192.168.1.112/24"
    ram           = 2048
    cores         = 1
    tags          = "worker,net-101,terraform,k3s"
  },
  {
    name          = "k3s-worker-2"
    vmid          = "113"
    username      = "tom"
    vm_ip_address = "192.168.1.113/24"
    ram           = 2048
    cores         = 1
    tags          = "worker,net-101,terraform,k3s"
  }
]