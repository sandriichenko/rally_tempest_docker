FROM rallyforge/rally:0.9.0
MAINTAINER Sofiia Andriichenko <sandriichenko@mirantis.com>

WORKDIR /var/lib
USER root
RUN git clone https://git.openstack.org/openstack/tempest && \
    pip install tempest && \
    git clone https://github.com/openstack/ironic.git && \
    pip install -r ironic/test-requirements.txt
 


WORKDIR /home/rally

COPY mcp_skip.list /var/lib/mcp_skip.list
COPY lvm_mcp.conf /var/lib/lvm_mcp.conf
COPY run_tempest.sh /usr/bin/run-tempest

ENTRYPOINT ["run-tempest"]
