build {
  name    = "base.alpine"
  sources = "${var.sources}"



  provisioner "file" {
    source      = "${path.cwd}/files/99-pve.cfg"
    destination = "/tmp/99-pve.cfg"
  }

  provisioner "shell" {
    inline = [
      "sudo cp /tmp/99-pve.cfg /etc/cloud/cloud.cfg.d/99-pve.cfg"
    ]
  }
}
