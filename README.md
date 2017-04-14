Repo for build rally image with tempest

How to run tests:

docker run --rm --net=host \
  -e TEMPEST_CONF=mcp.conf \
  -e SKIP_LIST=mcp_skip.list \
  -e SOURCE_FILE=keystonercv3 \
  -e CUSTOM='--pattern tempest.api.compute.' \
  -e DEBUG=FALSE \
  -v /root/:/home/rally ${image} >> image.output

How to run docker for debugging:
docker run --rm --net=host \
  -e TEMPEST_CONF=mcp.conf \
  -e SKIP_LIST=mcp_skip.list \
  -e SOURCE_FILE=keystonercv3 \
  -e DEBUG=TRUE \
  -tid \
  -v /root/:/home/rally 
