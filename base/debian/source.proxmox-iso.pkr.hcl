source "proxmox-iso" "debian" {
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"
  vm_name                  = "debian-${var.vm_os_codename}"
  vm_id                    = "${var.proxmox_vm_id}"

  machine  = "q35"
  sockets  = "${var.vm_cpu_sockets}"
  cores    = "${var.vm_cpu_cores}"
  memory   = "${var.vm_mem_size}"
  cpu_type = "${var.vm_cpu_type}"

  template_name        = "debian-${var.vm_os_codename}"
  template_description = "Base template for Debian Linux"

  unmount_iso = "true"
  qemu_agent  = "true"

  communicator           = "ssh"
  ssh_username           = local.ssh_username
  ssh_password           = local.ssh_password
  ssh_handshake_attempts = "20"
  ssh_timeout            = "15m"

  http_content = {
    "/preseed.cfg" = templatefile("${var.os_version}/preseed.cfg.pkrtpl", {
      root_password = local.root_password,
      ssh_username  = local.ssh_username,
      ssh_password  = local.ssh_password
    })
  }
  boot      = null
  boot_wait = "15s"
  boot_command = [
    "<esc><wait>auto url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"
  ]


  iso_checksum    = "file:https://cdimage.debian.org/debian-cd/12.2.0/amd64/iso-cd/SHA256SUMS"
  iso_file        = "local:iso/${var.vm_os_iso_name}"
  scsi_controller = "virtio-scsi-pci"
  os              = "l26"

  vga {
    type   = "std"
    memory = 32
  }

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disks {
    storage_pool = "local-lvm"
    type         = "virtio"
    disk_size    = "${var.vm_os_disk_size}"
    cache_mode   = "none"
  }
}
