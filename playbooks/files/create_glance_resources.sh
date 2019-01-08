#!/bin/sh

. ${HOME}/admin-openrc

set -x

USER=$(openstack user list | grep -c glance)
if [ ${USER} = 0 ]; then
	openstack user create --domain default \
  	--password ${OS_PASSWORD} glance
fi
ROLE=$(openstack role assignment list --project service --names | grep -c glance)
if [ ${ROLE} = 0 ]; then
	openstack role add --project service --user glance admin
fi
SERVICE=$(openstack service list | grep -c glance)
if [ ${SERVICE} = 0 ]; then
	openstack service create --name glance \
  --description "OpenStack Image" image
fi
ENDPOINT=$(openstack endpoint list | grep -c glance)
if [ ${SERVICE} = 0 ]; then
	openstack endpoint create --region RegionOne \
  image public http://controller:9292
	openstack endpoint create --region RegionOne \
  image internal http://controller:9292
	openstack endpoint create --region RegionOne \
  image admin http://controller:9292
fi

