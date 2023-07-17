build {
  name    = "base.alpine"
  sources = "${var.sources}"

  provisioner "shell" {
    inline = [
      "apk del tiny-cloud-alpine",
      "apk update",
      "apk add --no-cache sudo doas python3 chrony openssh-server-pam",
      "apk add --no-cache cloud-init cloud-utils-growpart e2fsprogs-extra",
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

  provisioner "shell" {
    inline = [
      "shred -u /etc/ssh/*_key /etc/ssh/*_key.pub",
      "rm -f /root/setup.sh",
      "rm -f /root/.ssh/authorized_keys",
      "sed -r -i 's/^#?PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config",
      "sed -r -i 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config",
      "sed -i -e '$aUsePAM yes' /etc/ssh/sshd_config",
      "passwd -d root", # Disable root
      "passwd -l root", # Lock root
      "unset HISTFILE; rm -rf /root/.*history"
    ]
  }
}
