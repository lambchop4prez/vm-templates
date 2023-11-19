source "proxmox-clone" "nvme-passthrough" {
  # VM Configuration
  vm_name              = "${local.hostname}"
  vm_id                = "${var.proxmox_vm_id}"
  clone_vm_id          = "${var.clone_vm_id}"
  template_name        = "${local.hostname}"
  template_description = "NVME Disk template with ${var.pci_host_device} attached"
  machine              = "q35"
  sockets              = "${var.vm_cpu_sockets}"
  cores                = "${var.vm_cpu_cores}"
  memory               = "${var.vm_mem_size}"
  cpu_type             = "${var.vm_cpu_type}"
  scsi_controller      = "virtio-scsi-pci"
  os                   = "l26"

  # Proxmox configuration
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"
  qemu_agent               = "true"

  # Communicator configuration
  communicator           = "ssh"
  ssh_username           = "${local.ssh_username}"
  ssh_password           = "${local.ssh_password}"
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
      "user-data" = templatefile("tpl/user-data.${var.pci_device_type}.tpl", { hostname = local.hostname, username = local.ssh_username, password = local.ssh_password })
    }
    cd_label         = "cidata"
    iso_storage_pool = "local"
    unmount          = true
  }
}
