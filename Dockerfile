FROM rallyforge/rally:0.9.1
MAINTAINER Sofiia Andriichenko <sandriichenko@mirantis.com>

WORKDIR /var/lib
USER root
RUN git clone https://git.openstack.org/openstack/tempest && \
    pip install tempest 

WORKDIR /home/rally

COPY mcp_skip.list /var/lib/mcp_skip.list
COPY lvm_mcp_newton.conf /var/lib/lvm_mcp_newton.conf
COPY run_tempest.sh /usr/bin/run-tempest

ENV SOURCE_FILE keystonercv3

ENTRYPOINT ["run-tempest"]
