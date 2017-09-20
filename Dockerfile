FROM rallyforge/rally:0.9.0
MAINTAINER Sofiia Andriichenko <sandriichenko@mirantis.com>

ENV TEMPEST_TAG="16.0.0"
ENV DESIGNATE_TAG="0.2.0"

WORKDIR /var/lib
USER root

    # TBD define plugins tag/branch and Ironic plugin

RUN git clone https://github.com/openstack/tempest.git -b $TEMPEST_TAG && \
    pip install tempest==$TEMPEST_TAG && \
    pip install ddt==1.0.1 && \
    git clone https://github.com/openstack/designate-tempest-plugin.git -b $DESIGNATE_TAG && \
    pip install -r designate-tempest-plugin/test-requirements.txt

WORKDIR /home/rally

COPY mcp_skip.list /var/lib/mcp_skip.list
COPY lvm_mcp.conf /var/lib/lvm_mcp.conf
COPY run_tempest.sh /usr/bin/run-tempest

ENV SOURCE_FILE keystonercv3

ENTRYPOINT ["run-tempest"]
