source "proxmox-iso" "alpine" {
  proxmox_url              = "${local.proxmox_url}"
  username                 = "${local.proxmox_username}"
  password                 = "${local.proxmox_password}"
  insecure_skip_tls_verify = "${local.proxmox_skip_tls_verify}"
  node                     = "${local.proxmox_node}"
  vm_name                  = "alpine-${var.os_version}"
  vm_id                    = "${var.proxmox_vm_id}"

  sockets  = "${var.vm_cpu_sockets}"
  cores    = "${var.vm_cpu_cores}"
  memory   = "${var.vm_mem_size}"
  cpu_type = "${var.vm_cpu_type}"

  boot      = null
  boot_wait = "7s"
  boot_command = [
    "root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
    "wget http://{{ .HTTPIP }}:{{ .HTTPPort }}/answers<enter><wait>",
    "setup-alpine -f answers<enter><wait5>",
    "{{user `ssh_password`}}<enter><wait>",
    "{{user `ssh_password`}}<enter><wait5>",
    "<wait>y<enter><wait10>",
    "rc-service sshd stop<enter>",
    "mount /dev/sda3 /mnt<enter>",
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter>",
    "umount /mnt<enter>",
    "reboot<enter>"
  ]

  # additional_iso_files {
  #   cd_files = [
  #     "${path.root}/${var.os_version}/meta-data",
  #     "${path.root}/${var.os_version}/user-data"
  #   ]
  #   cd_label         = "cidata"
  #   iso_storage_pool = "local"
  #   unmount          = true
  # }

  iso_checksum    = "file:https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/x86_64/${var.vm_os_iso_name}.sha256"
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
    type         = "scsi"
    disk_size    = "${var.vm_os_disk_size}"
    cache_mode   = "none"
  }

  template_name        = "alpine-${var.os_version}"
  template_description = "Base template for Alpine Linux"
  http_directory       = "${var.os_version}"

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
