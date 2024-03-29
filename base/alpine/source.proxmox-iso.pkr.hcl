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
  boot_wait = "20s"
  boot_command = [
    "root<enter><wait>",
    "ifconfig eth0 up && udhcpc -i eth0<enter><wait5>",
    "mount /dev/sr1 /media/cdrom<enter><wait>",
    "cp /media/cdrom/answers $PWD<enter><wait>",
    "setup-alpine -f $PWD/answers<enter><wait5>",
    "${local.ssh_password}<enter><wait>",
    "${local.ssh_password}<enter><wait20>",
    "no<enter><wait15>",
    "y<enter><wait25>",
    "rc-service sshd stop<enter><wait>",
    "mount /dev/sda3 /mnt<enter><wait>",
    "echo 'PermitRootLogin yes' >> /mnt/etc/ssh/sshd_config<enter><wait>",
    "umount /mnt<enter><wait>",
    "reboot<enter>",
    "<wait30>",
    "root<enter>",
    "${local.ssh_password}<enter><wait>",
    "mount /dev/sr1 /media/cdrom<enter><wait>",
    "cp /media/cdrom/setup.sh $PWD<enter><wait>",
    "chmod +x $PWD/setup.sh<enter><wait>",
    "$PWD/setup.sh<enter><wait5>",
    "rm $PWD/setup.sh<enter>"
  ]

  additional_iso_files {
    cd_files = [
      "${path.root}/${var.os_version}/answers",
      "${path.root}/${var.os_version}/setup.sh"
    ]

    cd_label         = "cidata"
    iso_storage_pool = "local"
    unmount          = true
  }

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

  unmount_iso = "true"
  qemu_agent  = "true"

  communicator           = "ssh"
  ssh_username           = "root"
  ssh_password           = "${local.ssh_password}"
  ssh_handshake_attempts = "20"
  ssh_timeout            = "15m"
}
