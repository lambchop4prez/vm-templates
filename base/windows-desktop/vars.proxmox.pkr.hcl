locals {
  proxmox_url      = vault("/secrets/data/proxmox", "proxmox_url")
  proxmox_node     = vault("/secrets/data/proxmox", "proxmox_node")
  proxmox_username = vault("/secrets/data/proxmox", "proxmox_username")
  proxmox_password = vault("/secrets/data/proxmox", "proxmox_password")
}

variable "proxmox_vm_id" {
  type    = string
  default = "8000"
}
