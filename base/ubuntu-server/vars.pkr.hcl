variable "os_version" {
    type = string
    default = "22.04"
    description = "OS Version to build, requires a corresponding folder with cloud-init data"
}

variable "sources" {
    type = list(string)
    default = [
        "source.proxmox-iso.ubuntu-server"
    ]
}
variable "ssh_password" {
    type = string
    default = "${env("SSH_PASSWORD")}"
    sensitive = true
}

# VM Base config
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