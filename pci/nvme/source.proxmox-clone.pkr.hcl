source "proxmox-clone" "nvme-passthrough" {
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"
  vm_name                  = "${local.proxmox_vm_name}"
  vm_id                    = "${var.proxmox_vm_id}"

  machine         = "q35"
  sockets         = "${var.vm_cpu_sockets}"
  cores           = "${var.vm_cpu_cores}"
  memory          = "${var.vm_mem_size}"
  cpu_type        = "${var.vm_cpu_type}"
  scsi_controller = "virtio-scsi-pci"
  os              = "l26"

  clone_vm_id = "9005"

  template_name        = "${local.hostname}"
  template_description = "NVME Disk template with ${var.pci_host_device} attached"

  qemu_agent = "true"

  communicator           = "ssh"
  ssh_username           = "vagrant"
  ssh_password           = "vagrant"
  ssh_handshake_attempts = "20"
  ssh_timeout            = "15m"


  vga {
    type   = "std"
    memory = 32
  }

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  pci_devices {
    mapping = "${var.pci_host_device}"
    pcie    = true
  }

  additional_iso_files {
    cd_content = {
      "meta-data" = jsonencode("{}")
      "user-data" = templatefile("tpl/user-data.${var.install_mode}.tpl", { hostname = local.hostname, username = var.ssh_user, password = local.ssh_password })
    }
    cd_label         = "cidata"
    iso_storage_pool = "local"
    unmount          = true
  }
}
