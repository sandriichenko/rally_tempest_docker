#!/bin/bash -xe

source /home/rally/$SOURCE_FILE

rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --version 15.0.0 --system-wide
rally verify add-verifier-ext --source /var/lib/designate-tempest-plugin
rally verify configure-verifier --extend /var/lib/tempest_conf/$TEMPEST_CONF
rally verify configure-verifier --show 
report='report'_`date +%F_%H-%M`
rally verify start --skip-list /var/lib/skip_lists/$SKIP_LIST $CUSTOM
rally verify report --type junit-xml --to $report.xml
rally verify report --type html --to $report.html 
