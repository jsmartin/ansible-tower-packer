#! /bin/bash -ex

if [ "$#" -ne 2 ]
then
  echo "Usage: $(basename $0) tower-version ansible-version"
  echo "Example: $(basename $0) 2.1.3 1.9.0.1"
  exit 1
fi

tower_version=$1
ansible_version=$2
setup_dir=/tmp/ansible-tower-setup
tower_box=tower-${tower_version}_ansible-${ansible_version}_virtualbox.box


if [ ! -e "output-virtualbox-iso/centos7.0.ovf" ]; then
	packer build packer-centos-7.json
fi

packer build -var "tower_version=$tower_version" -var "ansible_version=$ansible_version" packer-tower.json

