#!/bin/bash

# Create template
# For single node Proxmox installations
# args:
# vm_id: The ID for the virtual machine
# vm_name: The name for the virtual machine
# file_name: The image file to be used for the template
function create_template() {
    echo "Creating template $2 ($1)"

    # Create new VM 
    # Feel free to change any of these to your liking
    qm create $1 --name $2 --ostype l26 
    qm set $1 --net0 virtio,bridge=vmbr0  # Set networking to default bridge
    qm set $1 --serial0 socket --vga serial0  # Set display to serial
    qm set $1 --memory 1024 --cores 4 --cpu host  # Set memory, CPU, and type defaults
    qm set $1 --scsi0 ${storage}:0,import-from="$(pwd)/$3",discard=on  # Set boot device
    qm set $1 --boot order=scsi0 --scsihw virtio-scsi-single  # Set SCSI hardware
    qm set $1 --agent enabled=1,fstrim_cloned_disks=1  # Enable Qemu guest agent
    qm set $1 --ide2 ${storage}:cloudinit  # Add cloud-init device
    qm set $1 --ipconfig0 "ip6=auto,ip=dhcp"  # Set CI IP config
    qm set $1 --sshkeys ${ssh_keyfile}  # Import SSH keyfile
    qm set $1 --ciuser ${username}  # Add the user
    qm disk resize $1 scsi0 8G  # Resize the disk
    qm template $1  # Convert the VM to a template

    rm $3  # Remove the image file when done
}

# Validate if an ISO exists locally or download it if missing
# args:
# url: The URL to download the file from
# file_name: The name of the file to validate or download
function validate_iso() {
    local url=$1
    local file_name=$2

    if [ ! -f "$file_name" ]; then
        echo "$file_name does not exist. Downloading from $url..."
        wget "$url" -O "$file_name"
        if [ $? -ne 0 ]; then
            echo "Failed to download $file_name. Exiting."
            exit 1
        fi
    else
        echo "$file_name already exists. Skipping download."
    fi
}

# Path to your SSH authorized_keys file
export ssh_keyfile=/etc/pve/priv/authorized_keys 
# Username to create on VM template
export username=f3lin
# Name of your storage
export storage=local-lvm

# URLs for images
DEBIAN_URL="https://cloud.debian.org/images/cloud/bookworm/latest/debian-12-genericcloud-amd64.qcow2"
UBUNTU_URL="https://cloud-images.ubuntu.com/releases/24.04/release/ubuntu-24.04-server-cloudimg-amd64.img"

# Filenames for images
DEBIAN_IMG="debian-12-genericcloud-amd64.qcow2"
UBUNTU_IMG="ubuntu-24.04-server-cloudimg-amd64.img"

# Default VM IDs
DEBIAN_ID=6000
UBUNTU_ID=7000

# Default names
DEBIAN_NAME="debian-12"
UBUNTU_NAME="ubuntu-24-04"

# Print usage/help message
function print_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -n vm-name       Specify the name of the VM (optional, defaults to predefined names)"
    echo "  -i vm-id         Specify the ID of the VM (optional, defaults to predefined IDs)"
    echo "  -d               Create a Debian template"
    echo "  -u               Create an Ubuntu template"
    echo "  -h               Display this help message"
    echo
    echo "Examples:"
    echo "  $0 -d                           Create a Debian template with default settings"
    echo "  $0 -u                           Create an Ubuntu template with default settings"
    echo "  $0 -d -n custom-name -i 123     Create a Debian template with custom name and ID"
    echo "  $0                               Create both Debian and Ubuntu templates with default settings"
}

# Parse arguments
while getopts "n:i:duh" opt; do
    case $opt in
        n) VM_NAME=$OPTARG ;;  # Set custom VM name
        i) VM_ID=$OPTARG ;;    # Set custom VM ID
        d) RUN_DEBIAN=true ;;  # Flag to create Debian template
        u) RUN_UBUNTU=true ;;  # Flag to create Ubuntu template
        h) print_help; exit 0 ;;  # Display help message and exit
        *)
            echo "Invalid option: -$OPTARG" >&2
            print_help
            exit 1
            ;;
    esac
done

# If no specific OS is selected, default to both
if [ -z "$RUN_DEBIAN" ] && [ -z "$RUN_UBUNTU" ]; then
    RUN_DEBIAN=true
    RUN_UBUNTU=true
fi

# Create Debian template if selected
if [ "$RUN_DEBIAN" = true ]; then
    VM_NAME=${VM_NAME:-$DEBIAN_NAME}  # Use default name if not specified
    VM_ID=${VM_ID:-$DEBIAN_ID}        # Use default ID if not specified
    validate_iso "$DEBIAN_URL" "$DEBIAN_IMG"  # Validate or download Debian ISO
    create_template "$VM_ID" "$VM_NAME" "$DEBIAN_IMG"  # Create Debian template
fi

# Create Ubuntu template if selected
if [ "$RUN_UBUNTU" = true ]; then
    VM_NAME=${VM_NAME:-$UBUNTU_NAME}  # Use default name if not specified
    VM_ID=${VM_ID:-$UBUNTU_ID}        # Use default ID if not specified
    validate_iso "$UBUNTU_URL" "$UBUNTU_IMG"  # Validate or download Ubuntu ISO
    create_template "$VM_ID" "$VM_NAME" "$UBUNTU_IMG"  # Create Ubuntu template
fi

exit 0