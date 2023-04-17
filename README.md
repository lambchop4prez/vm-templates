# Packer Templates

This is my public collection of [Packer](https://packer.io) templates.

The base templates use the [proxmox-iso](https://developer.hashicorp.com/packer/plugins/builders/proxmox/iso) builder. Future derived templates will use [proxmox-clone](https://developer.hashicorp.com/packer/plugins/builders/proxmox/clone).

## Building

I want to make the building of these templates as simple as possible. To build the template, run:

```sh
packer build base/{os}
```

### Setting up Vault

Secrets are managed using [HashiCorp Vault](https://developer.hashicorp.com/vault).

First, [install Vault](https://developer.hashicorp.com/vault/downloads) on your system. Then you need to have a running instance of Vault, this can be in a docker container somewhere, or you can start it in a terminal window with `vault server`.

Next, log into the server, don't forget to set your `VAULT_ADDR` environment variable. If using a local instance, run `export VAULT_ADDR='http://127.0.0.1:8200'`  and then run

```sh
vault login
```

This will ask for a token, which you can get from the running server window.

__Note: This uses the default root account, and is not ideal for production purposes.__

Once logged into Vault, you can start setting up a keyvault for proxmox values. Create that by running:

```sh
vault secrets enable -version=2 -path=secrets kv
```

And then create and populate your proxmox secret.

```sh
vault kv put secrets/proxmox proxmox_url=https://<proxmox_host>:8006/api2/json
vault kv patch secrets/proxmox proxmox_node=<your_node>
vault kv patch secrets/proxmox proxmox_username=<your_username>@pam
vault kv patch secrets/proxmox proxmox_password=<your_password>
vault kv patch secrets/proxmox proxmox_skip_tls_verify=<value>
```

Finally, before you can run a `packer build`, export your vault token with the following:

```sh
export VAULT_TOKEN=`vault token lookup --format=json | jq -r '.data.id'`
```
