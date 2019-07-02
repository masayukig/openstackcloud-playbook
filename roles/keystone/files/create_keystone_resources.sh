#!/bin/sh

. ${HOME}/admin-openrc

set -x

EXAMPLE_DOMAIN=$(openstack domain list | grep -c example)
if [ ${EXAMPLE_DOMAIN} = 0 ]; then
	openstack domain create --description "An Example Domain" \
		example
fi

SERVICE_PROJECT=$(openstack project list | grep -c service)
if [ ${SERVICE_PROJECT} = 0 ]; then
	openstack project create --domain default \
		--description "Service Project" service
fi

MYPROJECT_PROJECT=$(openstack project list | grep -c myproject)
if [ ${MYPROJECT_PROJECT} = 0 ]; then
	openstack project create --domain default \
	  --description "Demo Project" myproject
fi

MYUSER_USER=$(openstack user list | grep -c myuser)
if [ ${MYUSER_USER} = 0 ]; then
	openstack user create --domain default \
  	--password ${OS_PASSWORD} myuser
fi

MYROLE_ROLE=$(openstack role list | grep -c myrole)
if [ ${MYROLE_ROLE} = 0 ]; then
	openstack role create myrole
	openstack role add --project myproject --user myuser myrole
fi

USER_ROLE=$(openstack role list | grep -c user)
if [ ${USER_ROLE} = 0 ]; then
	openstack role create user
fi

