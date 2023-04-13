# Packer Templates

This is my public collection of [Packer](https://packer.io) templates.

The base templates use the [proxmox-iso](https://developer.hashicorp.com/packer/plugins/builders/proxmox/iso) builder. Future derived templates will use [proxmox-clone](https://developer.hashicorp.com/packer/plugins/builders/proxmox/clone).

## Building

I want to make the building of these templates as simple as possible. To build the template, run:

```sh
packer build base/{os}
```

