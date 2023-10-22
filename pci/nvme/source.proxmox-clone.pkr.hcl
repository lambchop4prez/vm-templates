source "proxmox-clone" "nvme-passthrough" {
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"
  vm_name                  = "alpine-${var.os_version}"
  vm_id                    = "${var.proxmox_vm_id}"

  machine         = "q35"
  sockets         = "${var.vm_cpu_sockets}"
  cores           = "${var.vm_cpu_cores}"
  memory          = "${var.vm_mem_size}"
  cpu_type        = "${var.vm_cpu_type}"
  scsi_controller = "virtio-scsi-pci"
  os              = "l26"

  clone_vm_id = "9002"

  template_name        = "${var.clone_vm}-nvme-${var.pci_device_name}"
  template_description = "Base template for Alpine Linux"

  qemu_agent = "true"

  communicator           = "ssh"
  ssh_username           = "${var.ssh_user}"
  ssh_password           = "${var.ssh_password}"
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
  # disks {
  #   storage_pool = "local-lvm"
  #   type         = "scsi"
  #   disk_size    = "${var.vm_os_disk_size}"
  #   cache_mode   = "none"
  # }

  pci_devices {
    mapping = "${var.pci_host_device}"
    pcie    = true
  }
}
