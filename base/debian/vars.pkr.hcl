locals {
  ssh_password = coalesce(var.ssh_password, vault("/secrets/data/vm-templates", "ssh_password"))
}

variable "os_version" {
  type        = string
  default     = "12.2.0"
  description = "OS Version to build, requires a corresponding folder with cloud-init data"
}

variable "sources" {
  type = list(string)
  default = [
    "source.proxmox-iso.debian"
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

variable "vm_os_iso_name" {
  description = "The iso name, including extension, of the OS install media."
  type        = string
  default     = "debian-12.2.0-amd64-netinst.iso"
}
