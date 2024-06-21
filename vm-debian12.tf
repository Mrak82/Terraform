resource "proxmox_vm_qemu" "k8s-cp" {
#    name = "debian12"
    desc = "A test for using terraform and cloudinit"
    count = 3
    name = "k8s-cp-0${count.index + 1}"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve-01"

    # The template name to clone this vm from
    clone = "debian12-cloud-Template"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 4096
    scsihw = "virtio-scsi-single"

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = var.storage_name                    
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = "10G"
                    storage         = var.storage_name
                    replicate       = true
                    format          = "qcow2"
                }
            }
        }
    }

    # Setup the network interface and assign a vlan tag: 256
    network {
        model = "virtio"
        bridge = "KN01"
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    # Keep in mind to use the CIDR notation for the ip.
    ipconfig0 = "ip=dhcp"
    nameserver = "172.20.0.1"
    ciuser = "root"
}

resource "proxmox_vm_qemu" "k8s-wn" {
#    name = "debian12"
    desc = "A test for using terraform and cloudinit"
    count = 3
    name = "k8s-wn-0${count.index + 1}"

    # Node name has to be the same name as within the cluster
    # this might not include the FQDN
    target_node = "pve-01"

    # The template name to clone this vm from
    clone = "debian12-cloud-Template"

    # Activate QEMU agent for this VM
    agent = 1

    os_type = "cloud-init"
    cores = 4
    sockets = 1
    vcpus = 0
    cpu = "host"
    memory = 8192
    scsihw = "virtio-scsi-single"

    # Setup the disk
    disks {
        ide {
            ide3 {
                cloudinit {
                    storage = var.storage_name                    
                }
            }
        }
        scsi {
            scsi0 {
                disk {
                    size            = "10G"
                    storage         = var.storage_name
                    replicate       = true
                    format          = "qcow2"
                }
            }
        }
    }

    # Setup the network interface and assign a vlan tag: 256
    network {
        model = "virtio"
        bridge = "KN01"
    }

    # Setup the ip address using cloud-init.
    boot = "order=scsi0"
    # Keep in mind to use the CIDR notation for the ip.
    nameserver = "172.20.0.1"
    ciuser = "root"
}