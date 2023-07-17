source "proxmox-iso" "windows-desktop" {
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"

  vm_name = "windows-10-${var.os_version}"
  vm_id   = "${var.proxmox_vm_id}"
  os      = "win10"

  sockets  = "${var.vm_cpu_sockets}"
  cores    = "${var.vm_cpu_cores}"
  memory   = "${var.vm_mem_size}"
  cpu_type = "${var.vm_cpu_type}"

  bios = "ovmf"
  efi_config = {
    "efi_storage_pool" = "local"
  }
  machine = "q35"

  iso_file     = "local:iso/Win10_22H2_English_x64.iso"
  iso_checksum = ""

  additional_iso_files {
    cd_files = [
      "${path.root}/${var.os_version}/autounattend.xml"
    ]
    iso_storage_pool = "local"
    unmount          = true
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

  template_name        = "windows-desktop-${var.os_version}"
  template_description = "Base template for Windows desktop"

  unmount_iso = "true"
  qemu_agent  = "true"

  communicator   = "winrm"
  winrm_username = "vagrant"
  winrm_password = "vagrant"
}
