#!/bin/sh

set -ex

# Enable community repo and update.
# Initially found at https://github.com/sdhibit/packer-proxmox-templates/blob/main/alpine-3-amd64/templates/alpine-setup.sh.pkrtpl
sed -r -i '\|/v[0-9]+\.[0-9]+/community|s|^#\s?||g' /etc/apk/repositories
apk update

apk add qemu-guest-agent
echo -e GA_PATH="/dev/vport2p1" >> /etc/conf.d/qemu-guest-agent
rc-update add qemu-guest-agent
rc-service qemu-guest-agent restart


