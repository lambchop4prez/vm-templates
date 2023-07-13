build {
  name    = "base.alpine"
  sources = "${var.sources}"

  provisioner "shell" {
    inline = [
      "apk update",
      "apk add --no-cache sudo doas python3 chrony openssh-server-pam",
      "apk add --no-cache cloud-init cloud-utils-growpart e2fsprogs-extra",
    ]
  }

  provisioner "shell" {
    inline = [
      "sed -i -e '$aUsePAM yes' /etc/ssh/sshd_config"
    ]
  }

  provisioner "shell" {
    inline = [
      "echo 'isofs' > /etc/modules-load.d/isofs.conf",
      "chmod -x /etc/modules-load.d/isofs.conf",
      "setup-cloud-init",
      "echo 'datasource_list: [NoCloud, ConfigDrive, None]' > /etc/cloud/cloud.cfg.d/99_pve.cfg",
      "chmod 644 /etc/cloud/cloud.cfg.d/99_pve.cfg",
    ]
  }

  # provisioner "shell" {

  # }
}
