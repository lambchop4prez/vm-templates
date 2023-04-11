variable "proxmox_url" {
    type = string
    default = "${env("PROXMOX_URL")}"
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
variable "proxmox_node" {
    type = string
    default = "${env("PACKER_PROXMOX_NODE")}"
}
variable "ssh_password" {
    type = string
    default = "${env("SSH_PASSWORD")}"
    sensitive = true
}
variable "vm_cpu_sockets" {
    type = number
    default = "1"
}
variable "vm_cpu_cores" {
    type = number
    default = "4"
}
variable "vm_mem_size" {
    type = number
    default = "6144"
}
variable "vm_cpu_type" {
    type = string
    default = "host"
}
variable "vm_os_disk_size" {
    type = string
    default = "32G"
}
