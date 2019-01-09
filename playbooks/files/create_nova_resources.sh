#!/bin/sh

. ${HOME}/admin-openrc

set -x

### for nova
USER=$(openstack user list | grep -c nova)
if [ ${USER} = 0 ]; then
	openstack user create --domain default \
  	--password ${OS_PASSWORD} nova
fi
ROLE=$(openstack role assignment list --project service --names | grep -c nova)
if [ ${ROLE} = 0 ]; then
	openstack role add --project service --user nova admin
fi
SERVICE=$(openstack service list | grep -c nova)
if [ ${SERVICE} = 0 ]; then
	openstack service create --name nova \
  --description "OpenStack Compute" compute
fi
ENDPOINT=$(openstack endpoint list | grep -c nova)
if [ ${SERVICE} = 0 ]; then
	openstack endpoint create --region RegionOne \
  compute public http://controller:8774/v2.1
	openstack endpoint create --region RegionOne \
  compute internal http://controller:8774/v2.1
	openstack endpoint create --region RegionOne \
  compute admin http://controller:8774/v2.1
fi

### for placement
USER=$(openstack user list | grep -c placement)
if [ ${USER} = 0 ]; then
	openstack user create --domain default \
  	--password ${OS_PASSWORD} placement
fi
ROLE=$(openstack role assignment list --project service --names | grep -c placement)
if [ ${ROLE} = 0 ]; then
	openstack role add --project service --user placement admin
fi
SERVICE=$(openstack service list | grep -c placement)
if [ ${SERVICE} = 0 ]; then
	openstack service create --name placement \
  --description "Placement API" placement
fi
ENDPOINT=$(openstack endpoint list | grep -c placement)
if [ ${SERVICE} = 0 ]; then
	openstack endpoint create --region RegionOne \
  placement public http://controller:8780
	openstack endpoint create --region RegionOne \
  placement internal http://controller:8780
	openstack endpoint create --region RegionOne \
  placement admin http://controller:8780
fi


