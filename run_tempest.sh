#!/bin/bash -xe

source /home/rally/$SOURCE_FILE

rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --version 15.0.0 --system-wide
rally verify configure-verifier --extend /var/lib/tempest_conf/$TEMPEST_CONF
rally verify configure-verifier --show
if [ $DEBUG ==  FALSE ]
then
    rally verify start --skip-list /var/lib/skip_lists/$SKIP_LIST $CUSTOM
    rally verify report --type junit-xml --to report.xml
fi
if [ $DEBUG ==  TRUE ]
then
    while true; do; sleep 1; done;
fi
