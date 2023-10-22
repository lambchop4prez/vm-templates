locals {
  proxmox_url             = vault("/secrets/data/proxmox", "proxmox_url")
  proxmox_node            = vault("/secrets/data/proxmox", "proxmox_node")
  proxmox_username        = vault("/secrets/data/proxmox", "proxmox_username")
  proxmox_password        = vault("/secrets/data/proxmox", "proxmox_password")
  proxmox_skip_tls_verify = vault("/secrets/data/proxmox", "proxmox_skip_tls_verify")
}

variable "proxmox_vm_id" {
  type    = string
  default = "9011"
}
