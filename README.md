## Requirements

- VirtualBox;
- VirtualBox Guest Additions;
- Vagrant

## Clone this repo

`git clone repo_url`

## Change environment configurations to what is suitable to you

`vim .env`

## Easy M2 installation

There is a script available `m2-install.sh` which is useful to install new M2 instances. It's fully configurable through the n98-magerun2.yaml available inside config folder

## Get environment up

`export VAGRANT_EXPERIMENTAL="disks" && vagrant up`

## Caveats

If you face any issue while trying to connect to MySQL from the host, add the following lines to ~/.ssh/config:
```
 Host vagrant
    User vagrant
    Hostname 127.0.0.1
    port 2222
    IdentityFile /path/to/Vagrantfile/.vagrant/machines/default/virtualbox/private_key
    IdentitiesOnly yes
```
