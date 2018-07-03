# ansible

An ansible image, based on alpine, with the following additional third-party
packages:

* ca-certificates
* bash
* git
* openssh-client
* openssl
* python
* py-pip
* rsync
* sshpass
* tini

The image includes a user called 'ansible', which the container runs as.

To make it easy to use ssh, the ssh-add utility is installed root-owned and
setuid. This allows ssh to use private keys mounted into an ansible container
regardles of who owns them.

