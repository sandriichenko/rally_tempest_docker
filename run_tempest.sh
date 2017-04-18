#!/bin/bash -xe

source /home/rally/$SOURCE_FILE

rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --version 15.0.0 --system-wide
rally verify configure-verifier --extend /var/lib/tempest_conf/$TEMPEST_CONF
rally verify configure-verifier --show
wget https://raw.githubusercontent.com/openstack/ironic/master/test-requirements.txt -O ironic-requirements.txt
wget https://raw.githubusercontent.com/openstack/designate-tempest-plugin/master/test-requirements.txt -O designate-requirements.txt
wget https://raw.githubusercontent.com/openstack/ceilometer/master/test-requirements.txt -O ceilometer-requirements.txt
pip install -r ironic-requirements.txt 
pip install -r designate-requirements.txt
pip install -r ceilometer-requirements.txt
rally verify add-verifier-ext --source https://github.com/openstack/ironic.git
rally verify add-verifier-ext --source https://github.com/openstack/ceilometer.git
rally verify add-verifier-ext --source https://github.com/openstack/designate-tempest-plugin.git
rm -rf *-requirements.txt
rally verify start --skip-list /var/lib/skip_lists/$SKIP_LIST $CUSTOM
rally verify report --type junit-xml --to report.xml
