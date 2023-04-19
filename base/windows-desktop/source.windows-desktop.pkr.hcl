source "proxmox-iso" "windows-desktop" {
  proxmox_url              = "${var.proxmox_url}"
  username                 = "${var.proxmox_username}"
  password                 = "${var.proxmox_password}"
  insecure_skip_tls_verify = true
  node                     = "${var.proxmox_node}"
  iso_file                 = "local:/iso/Win10_22H2_English_x64.iso"
  iso_checksum             = ""
  iso_storage_pool         = "vmstorage"
  floppy_files = [
    "${path.root}/${var.os_version}/autounattend.xml"
  ]

  vm_name = "windows-10-${var.os_version}"
  os      = "win10"
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
}
