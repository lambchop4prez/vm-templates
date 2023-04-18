source "proxmox-iso" "ubuntu-server" {
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"
  vm_name                  = "ubuntu-server-${var.os_version}"
  vm_id                    = "${var.proxmox_vm_id}"

  sockets  = "${var.vm_cpu_sockets}"
  cores    = "${var.vm_cpu_cores}"
  memory   = "${var.vm_mem_size}"
  cpu_type = "${var.vm_cpu_type}"

  boot      = "c"
  boot_wait = "7s"
  boot_command = [
    "<esc><wait>",
    "e<wait>",
    "<down><down><down><end>",
    "<bs><bs><bs><bs><wait>",
    "autoinstall ds=nocloud-net;s=/cidata/ ---<wait>",
    "<f10><wait>"
  ]

  additional_iso_files {
    cd_files = [
      "${path.root}/${var.os_version}/meta-data",
      "${path.root}/${var.os_version}/user-data"
    ]
    cd_label         = "cidata"
    iso_storage_pool = "local"
    unmount          = true
  }

  iso_checksum    = "file:https://releases.ubuntu.com/22.04.2/SHA256SUMS"
  iso_file        = "local:iso/ubuntu-22.04.2-live-server-amd64.iso"
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
    type         = "scsi"
    disk_size    = "${var.vm_os_disk_size}"
    cache_mode   = "none"
  }

  template_name        = "ubuntu-server-${var.os_version}"
  template_description = "Base template for ubuntu servers"

  unmount_iso             = "true"
  qemu_agent              = "true"
  cloud_init              = true
  cloud_init_storage_pool = "local"

  communicator           = "ssh"
  ssh_username           = "ubuntu"
  ssh_password           = "ubuntu"
  ssh_handshake_attempts = "20"
  ssh_timeout            = "30m"
}
