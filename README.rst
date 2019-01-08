openstackcloud-playbook
=======================

This project aims to build an openstack cloud along with the official
installation guide. https://docs.openstack.org/install-guide

How to use
----------

1. Update hosts/inventory.ini if needed. `[router]` section is not used
   for now.
2. Prepare secret.yml for passwords and encrypt with ansible-vault like this::

   admin_pass: STRONG_PASSWORD_FOR_ADMIN
   cinder_dbpass: STRONG_PASSWORD_FOR_CINDER_DB
    :

  You can see the other password names on
  https://docs.openstack.org/install-guide/environment-security.html

3. Execute like this::

   ansible-playbook -i hosts/inventory.ini --extra-vars="@secret.yml" ./playbooks/controller.yml