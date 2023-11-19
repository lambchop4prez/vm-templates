locals {
  ssh_username = "user-nvme"
  ssh_password = coalesce(var.ssh_password, vault("/secrets/data/vm-templates", "ssh_password"))
  hostname     = "${var.clone_os}-${var.pci_device_name}"
}

variable "sources" {
  type = list(string)
  default = [
    "source.proxmox-clone.nvme-passthrough"
  ]
}

variable "ssh_password" {
  type      = string
  default   = null
  sensitive = true
}

# VM Base config
variable "vm_cpu_sockets" {
  type    = number
  default = "1"
}
variable "vm_cpu_cores" {
  type    = number
  default = "4"
}
variable "vm_mem_size" {
  type    = number
  default = "6144"
}
variable "vm_cpu_type" {
  type    = string
  default = "host"
}
variable "vm_os_disk_size" {
  type    = string
  default = "32G"
}

variable "clone_vm_id" {
  description = "The VM to clone"
  type        = number
  default     = 9005
}

variable "clone_os" {
  description = "OS of Cloned VM"
  type        = string
  default     = "debian-bookworm"
}

variable "pci_device_name" {
  description = "The device name to pass through"
  type        = string
  default     = "nvme-1"
}

variable "pci_host_device" {
  description = "The PCI device ID to attatch"
  type        = string
  default     = "PS5013-NVMe-Controller"
}

variable "pci_device_type" {
  description = "(Optional) - Install custom FusionIO kernel drivers."
  type        = string
  default     = "nvme"
}
