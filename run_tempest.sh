#!/bin/bash -xe

source /home/rally/$SOURCE_FILE

rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --version $TEMPEST_TAG --system-wide
rally verify add-verifier-ext --source /var/lib/heat-tempest-plugin/
rally verify configure-verifier --extend /var/lib/$TEMPEST_CONF
rally verify configure-verifier --show
rally verify list-verifier-tests
#rally verify start --skip-list /var/lib/skip_lists/$SKIP_LIST $CUSTOM
#rally verify report --type junit-xml --to report.xml
