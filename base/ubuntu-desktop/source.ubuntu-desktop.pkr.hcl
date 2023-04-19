source "proxmox-iso" "ubuntu-desktop" {
  proxmox_url              = "${var.proxmox_url}"
  username                 = "${var.proxmox_username}"
  password                 = "${var.proxmox_password}"
  insecure_skip_tls_verify = "true"
  node                     = "${var.proxmox_node}"

  vm_name = "${var.vm_name_ubuntu}"
  vm_id   = "9000"

  sockets  = "${var.vm_cpu_sockets}"
  cores    = "${var.vm_cpu_cores}"
  memory   = "${var.vm_mem_size}"
  cpu_type = "${var.vm_cpu_type}"

  boot_command = [
    "<enter><enter><f6><esc><wait> ",
    "autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<enter>"
  ]
  boot_wait = "5s"

  http_directory = "ubuntu-desktop/"

  iso_checksum = "file:https://releases.ubuntu.com/22.04.1/SHA256SUMS"
  iso_file     = "local:/iso/ubuntu-desktop-22.04.1-desktop-amd64.iso"

  os = "l26"
  vga {
    type   = "std"
    memory = 32
  }

  network_adapters {
    model  = "virtio"
    bridge = "vmbr0"
  }

  disks {
    storage_pool      = "local-lvm"
    storage_pool_type = "lvm-thin"
    type              = "scsi"
    disk_size         = "${var.vm_os_disk_size}"
    cache_mode        = "none"
    format            = "qcow2"
  }

  template_name = "${var.vm_name_ubuntu}"
}
