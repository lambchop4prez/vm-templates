---
#cloud-config

hostname: ${hostname}.lan
manage_etc_hosts: true
locale: en_US.UTF-8
timezone: America/Detroit
keyboard:
  layout: us
ssh_pwauth: true
ssh:
  emit_keys_to_console: false
packages:
  - apt:
      - nvme
users:
  - name: ${username}
    gecos: TMP User
    groups: sudo
    create_groups: true
    plain_text_passwd: ${password}
    sudo: "ALL=(ALL) NOPASSWD:ALL"
