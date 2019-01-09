#!/bin/sh

. ${HOME}/admin-openrc

set -x

wget http://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img
IMAGE=$(openstack image list | grep -c cirros)
if [ ${IMAGE} = 0 ]; then
	openstack image create "cirros" \
  --file cirros-0.4.0-x86_64-disk.img \
  --disk-format qcow2 --container-format bare \
  --public
fi
IMAGE=$(openstack image list | grep -c cirros)
if [ ${IMAGE} = 0 ]; then
  echo "ERROR: A cirros image doesn't exist."
	exit 1
fi
