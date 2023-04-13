variable "proxmox_url" {
    type = string
    default = "${env("PROXMOX_URL")}"
}
variable "proxmox_node" {
    type = string
    default = "${env("PACKER_PROXMOX_NODE")}"
}
variable "proxmox_username" {
    type = string
    default = "${env("PACKER_PROXMOX_USER")}"
}
variable "proxmox_password" {
    type = string
    default = "${env("PACKER_PROXMOX_PASSWORD")}"
    sensitive = true
}
variable "proxmox_vm_id" {
    type = string
    default = "9000"
}