# Terraform Script for Proxmox VM Automation

This Terraform script automates the provisioning of virtual machines (VMs) in a Proxmox environment. The script leverages the Proxmox Terraform provider to create and configure VMs based on a predefined template, along with specific network, storage, and system configurations.

## What Does the Script Do?

### 1. Clone a Proxmox VM Template

- The script clones a VM template specified in the variables.tf file.

### 2. Configure the VM

- Name and Description: Sets a custom name and description for the VM.

- Hardware Settings:

    - Configures CPU cores, sockets, and RAM.

    - Sets up disk storage and cloud-init for dynamic configuration.

    - Configures a serial console and VGA.

- Network: Sets up a VirtIO network interface with a bridge, firewall, and IP configuration (via Cloud-init).

### 3. Initialize User and Cloud-init Settings

- Sets the username, password, and SSH key for the VM using Cloud-init.

### 4. Dynamic Configuration with Cloud-init

- Dynamically applies IP address, gateway, and other configurations provided in the proxmox.credentials.auto.tfvars file.

## Prerequisites

### 1. Terraform Installed

- Ensure Terraform is installed on your system. You can download it from Terraform’s official website.

### 2. Proxmox Environment

- You need access to a Proxmox Virtual Environment (PVE) with API enabled.

- Ensure you have a Proxmox template to clone.

### 3. Proxmox Terraform Provider

- Install the Proxmox Terraform provider plugin. 

### 4. SSH Key Pair

- Generate an SSH key pair if you haven’t already and update the ``sshkeys`` section in ``main.tf`` with your public key.

### 5. Variables Configuration

- Update the proxmox.credentials.auto.tfvars file with the required values:

```hcl
proxmox_api_url      = "https://your-proxmox-url:8006/api2/json"
proxmox_api_token    = "your-api-token"
proxmox_api_token_id = "your-token-id"
vm_password          = "your-vm-password"
vm_ip_address        = "192.168.1.xxx/24"
vm_ip_gateway        = "192.168.1.xxx"
template_name        = "your-template-name"
```

## Files and Structure

```text
Folder PATH listing
C:.
│   .gitignore
│   .terraform.lock.hcl
│   main.tf
│   notes.md
│   provider.tf
│   proxmox.credentials.auto.tfvars
│   terraform.tfstate
│   terraform.tfstate.backup
│   variables.tf
│   vm-template.sh
```



- ``vm-template.sh``: Shell script for create Ubuntu24.04 or Debian12 VM Template on your proxmox. This need to be donne befor run the terraform scripts and it shoul be on the proxmox Host.

- ``variables.tf``: Contains all the input variables for the script, such as API credentials, VM settings, and defaults.

- ``proxmox.credentials.auto.tfvars``: Stores sensitive data like API credentials and VM-specific configuration.

- ``main.tf``: The main Terraform script for defining the VM resource.

- ``provider.tf``: Defines the Proxmox provider configuration.

## How to Run the Script

### 1. Initialize Terraform

Run the following command to initialize Terraform and download the required providers:

```bash
terraform init
```
### 2. Validate the Configuration

Validate the Terraform configuration to ensure there are no errors:

```bash
terraform validate
```

### 3. Plan the Execution

Generate and review an execution plan:

```bash
terraform plan
```

### 4. Apply the Configuration
Apply the Terraform script to create the VM in Proxmox:

```bash
terraform apply
```

Confirm the operation when prompted.

### 5.Verify the VM

Once the script completes, log in to the Proxmox web interface to verify that the VM has been created and configured as specified.

## Troubleshooting

- **Authentication Errors**: Check your API credentials in ``proxmox.credentials.auto.tfvars``.

- **Template Issues**: Ensure the specified template exists and is configured correctly in Proxmox.

- **Network Problems**: Verify your IP address and gateway settings.