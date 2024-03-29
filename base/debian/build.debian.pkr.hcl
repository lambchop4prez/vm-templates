build {
  name    = "base.debian"
  sources = "${var.sources}"

  provisioner "shell" {
    execute_command = "echo '${local.root_password}' > su -c {{ .Path }}"
    inline = [
      "echo 'isofs' > /etc/modules-load.d/isofs.conf",
      "chmod -x /etc/modules-load.d/isofs.conf",
      "echo 'datasource_list: [NoCloud, ConfigDrive, None]' > /etc/cloud/cloud.cfg.d/99_pve.cfg",
      "chmod 644 /etc/cloud/cloud.cfg.d/99_pve.cfg",
    ]
  }

  provisioner "shell" {
    execute_command = "echo '${local.root_password}' > su -c {{ .Path }}"
    script          = "${path.cwd}/scripts/cleanup.sh"
  }
}
