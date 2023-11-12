locals {
  ssh_password = coalesce(var.ssh_password, vault("/secrets/data/vm-templates", "ssh_password"))
  hostname     = "${var.clone_os}-nvme-${var.pci_device_name}"
}

variable "os_version" {
  type        = string
  default     = "3.18"
  description = "OS Version to build, requires a corresponding folder with cloud-init data"
}

variable "sources" {
  type = list(string)
  default = [
    "source.proxmox-clone.nvme-passthrough"
  ]
}

variable "ssh_user" {
  type      = string
  default   = "user-nvme"
  sensitive = true
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

variable "clone_vm" {
  description = "The VM to clone"
  type        = string
  default     = "debian-12.2.0"
}

variable "clone_os" {
  description = "OS of Cloned VM"
  type        = string
  default     = "debian-bookworm"
}

variable "pci_device_name" {
  description = "The device name to pass through"
  type        = string
  default     = "iomemory-1"
}

variable "pci_host_device" {
  description = "The PCI device ID to attatch"
  type        = string
  default     = "sandisk-iomemory"
}

variable "pci_device_type" {
  description = "(Optional) - Install custom FusionIO kernel drivers."
  type        = string
  default     = "fio"
}
