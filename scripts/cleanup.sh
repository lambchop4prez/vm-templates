#!/bin/sh
shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
# rm -f /root/setup.sh
rm -f /root/.ssh/authorized_keys
sed -r -i 's/^#?PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
sed -r -i 's/^#?PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sed -i -e '$aUsePAM yes' /etc/ssh/sshd_config
passwd -d root # Disable root
passwd -l root # Lock root
unset HISTFILE
rm -rf /root/.*history
