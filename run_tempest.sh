#!/bin/bash -xe

source /home/rally/$SOURCE_FILE

log_dir='/home/rally/rally_reports'
mkdir -p $log_dir

report='report_'$SET'_'`date +%F_%H-%M`
log=$log_dir/$report.log
rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --system-wide
rally verify add-verifier-ext --source /var/lib/designate-tempest-plugin
rally verify add-verifier-ext --source /var/lib/ironic
#rally verify add-verifier-ext --source /var/lib/murano
rally verify configure-verifier --extend /var/lib/lvm_mcp.conf 
rally verify configure-verifier --show | tee -a $log
if [ $SET ]
then
    rally verify start --skip-list /var/lib/mcp_skip.list --pattern set=$SET | tee -a  $log
else
    rally verify start --skip-list /var/lib/mcp_skip.list $CUSTOM  | tee -a  $log
fi
rally verify report --type junit-xml --to $log_dir/$report.xml
rally verify report --type html --to $log_dir/$report.html
