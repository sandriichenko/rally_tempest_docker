#!/bin/bash -xe

#cd /var/lib/barbican-tempest-plugin
#git apply barbican_skip.patch 
#git add barbican_tempest_plugin/tests/api/base.py 
#git commit -m 'Added skip'
#git checkout -b 0.1

git am barbican_skip.patch
git checkout -b 0.1

export BARBICAN_TAG="0.1"

cd

source /home/rally/$SOURCE_FILE

log_dir="${LOG_DIR:-/home/rally/rally_reports/}"
mkdir -p $log_dir

report='report_'$SET'_'`date +%F_%H-%M`
log=$log_dir/$report.log
rally-manage db recreate
rally deployment create --fromenv --name=tempest
rally verify create-verifier --type tempest --name tempest-verifier --source /var/lib/tempest --version $TEMPEST_TAG  --system-wide
rally verify add-verifier-ext --source /var/lib/designate-tempest-plugin --version $DESIGNATE_TAG

rally verify add-verifier-ext --source /var/lib/barbican-tempest-plugin/ --version  $BARBICAN_TAG

#rally verify add-verifier-ext --source /var/lib/ironic
#rally verify add-verifier-ext --source /var/lib/murano
rally verify configure-verifier --extend /var/lib/lvm_mcp.conf 

mkdir /etc/tempest
rally verify configure-verifier --show > /etc/tempest/tempest.conf
sed -i '1,3d' /etc/tempest/tempest.conf

rally verify configure-verifier --show | tee -a $log
if [ $SET ]
then
    rally verify start --skip-list /var/lib/mcp_skip.list --pattern set=$SET | tee -a  $log
else
    rally verify start --skip-list /var/lib/mcp_skip.list $CUSTOM  | tee -a  $log
fi
rally verify report --type junit-xml --to $log_dir/$report.xml
rally verify report --type html --to $log_dir/$report.html
