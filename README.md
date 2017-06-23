Repo for build rally image with tempest

Description:
1. keystonercv3 should be exist in /root , or add variable when you run docker cotainer: -e SOURCE_FILE='pass to file'
2. You can use variable CUSTOM, SET or nothing to run all tests:
CUSTOM='--pattern <pass_to_tests>'
SET=smoke (or full, compute, identity, image, network, object_storage, orchestration, volume, scenario)

How to run tests:

docker run --rm --net=host  -v /root/:/home/rally sandriichenko/rally_tempest_docker:docker_aio

