#!/bin/bash -xe

source /home/rally/$SOURCE_FILE

rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --system-wide
rally verify add-verifier-ext --source /var/lib/designate-tempest-plugin
rally verify add-verifier-ext --source /var/lib/ironic
#rally verify add-verifier-ext --source /var/lib/murano
rally verify configure-verifier --extend /var/lib/lvm_mcp.conf
rally verify configure-verifier --show
rally verify start --skip-list /var/lib/mcp_skip.list $CUSTOM
report='report_'`date +%F_%H-%M`
rally verify report --type junit-xml --to $report.xml
rally verify report --type html --to $report.html
