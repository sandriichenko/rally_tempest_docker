FROM xrally/xrally-openstack:0.10.1

ENV TEMPEST_TAG '17.2.0'

WORKDIR /var/lib
USER root
RUN git clone https://git.openstack.org/openstack/tempest -b $TEMPEST_TAG && \
    pip install tempest==$TEMPEST_TAG && \
    git clone https://github.com/openstack/heat-tempest-plugin.git && \
    pip install -r heat-tempest-plugin/test-requirements.txt && \
    pip install -r heat-tempest-plugin/requirements.txt && \
    pip install ansible==2.3

WORKDIR /home/rally

COPY mcp_skip.list /var/lib/mcp_skip.list
COPY lvm_mcp.conf /var/lib/lvm_mcp.conf
COPY run_tempest.sh /usr/bin/run-tempest

ENV TEMPEST_CONF lvm_mcp.conf
ENV SOURCE_FILE keystonercv3
#ENTRYPOINT ["run-tempest"]
