#!/bin/bash
# about running multiple services in docker
# see: https://docs.docker.com/config/containers/multi-service_container/
# this is a wrapper script to run multiple processes.

set -e

if [ "$1" == 'reinit' ]; then
  # re-init conf
  /hadoop-conf/init-conf.sh
fi

# ssh daemon
/etc/init.d/ssh start


if [ "$NODE_TYPE" == "master" ]; then
  # hadoop daemons
  PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin
  if ! hdfs namenode -metadataVersion; then
    hdfs namenode -format
  fi
  start-dfs.sh
  start-yarn.sh

  # hive daemons
  PATH=$PATH:$HIVE/bin
fi
# ...

# loop the show running java processes and prevent script exits
while sleep 60; do
  echo 'show java processes'
  jps
done

