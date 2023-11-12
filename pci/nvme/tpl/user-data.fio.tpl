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

users:
  - name: ${username}
    gecos: TMP User
    groups: sudo
    create_groups: true
    plain_text_passwd: ${password}
    sudo: "ALL=(ALL) NOPASSWD:ALL"

packages:
  - apt:
    - git
    - build-essential
    - linux-headers-amd64
    - linux-headers-$(uname -r)
    - zip
    - unzip
    - fakeroot
    - debhelper
    - rsync
    - dkms

package_update: true
package_upgrade: true
package_reboot_if_required: true

runcmd:
  - ["git", "clone", "https://github.com/RemixVSL/iomemory-vsl4.git"]
  - ["cd", "iomemory-vsl4"]
  - ["make", "dpkg"]
  - ["cd", ".."]
  - ["dpkg", "--install", "iomemory-vsl4-$(uname -r)_4.3.7.1205-1.0_amd64.deb"]
  - ["wget", "https://www.dropbox.com/s/d18dokktt0g2aau/fio-util_4.3.7.1205-1.0_amd64.deb"]
  - ["dpkg", "--install", "fio-util_4.3.7.1205-1.0_amd64.deb"]
