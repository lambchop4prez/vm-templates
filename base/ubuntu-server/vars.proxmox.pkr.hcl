locals {
    proxmox_url = vault("/secrets/data/proxmox", "proxmox_url")
    proxmox_node = vault("/secrets/data/proxmox", "proxmox_host")
    proxmox_username = vault("/secrets/data/proxmox", "proxmox_username")
    proxmox_password = vault("/secrets/data/proxmox", "proxmox_password")
    proxmox_skip_tls_verify = vault("/secrets/data/proxmox", "proxmox_skip_tls_verify")
}
# variable "proxmox_url" {
#     type = string
#     default = vault("/secrets/data/proxmox", "proxmox_url")
# }
# variable "proxmox_node" {
#     type = string
#     default = "${env("PACKER_PROXMOX_NODE")}"
# }
# variable "proxmox_username" {
#     type = string
#     default = "${env("PACKER_PROXMOX_USER")}"
# }
# variable "proxmox_password" {
#     type = string
#     default = "${env("PACKER_PROXMOX_PASSWORD")}"
#     sensitive = true
# }
variable "proxmox_vm_id" {
    type = string
    default = "9000"
}
