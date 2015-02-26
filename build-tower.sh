#! /bin/bash -ex

if [ "$#" -ne 1 ]
then
  echo "Usage: $(basename $0) tower-version"
  echo "Example: $(basename $0) 2.1.1"
  exit 1
fi

tower_version=$1
setup_dir=/tmp/ansible-tower-setup


# tower playbooks need to be fetched prior to vagrant up or vagrant
# provisioner will complain that they don't exist
wget -P /tmp/ -N  http://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-${tower_version}.tar.gz

rm -rf ${setup_dir}
mkdir ${setup_dir}
tar xvf /tmp/ansible-tower-setup-${tower_version}.tar.gz -C ${setup_dir} --strip-components=1

cp tower_setup_conf.yml /tmp/ansible-tower-setup

if [ ! -e "output-virtualbox-iso/centos7.0.ovf" ]; then
	packer build packer-centos-7.json
fi
packer build -var "tower_version=$tower_version" packer-tower.json