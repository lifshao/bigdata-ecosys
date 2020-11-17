#!/bin/bash

set -e

script_dir=$( dirname "$0" )

replace_with_env() {
  filename="$1/$2"
  tempname="$script_dir/$2"
  shift 2
  varname="$@"
  cp $tempname $filename
  for var in $varname; do
    eval env_var='${'$var'}'
    # replace path '/' with '\/'
    env_var=$( echo $env_var | sed -z 's/\//\\\//g' )
    sed -i 's/\${'$var"}/$env_var/" $filename
  done
}

# replace hadoop files
HADOOP_CONF_PATH="$HADOOP_HOME/etc/hadoop"

replace_with_env "$HADOOP_CONF_PATH" "hadoop-env.sh" 'JAVA_HOME'
replace_with_env "$HADOOP_CONF_PATH" "core-site.xml" 'NAMENODE_HOST'
replace_with_env "$HADOOP_CONF_PATH" "hdfs-site.xml" 'HDFS_REPLICATION'
replace_with_env "$HADOOP_CONF_PATH" "yarn-site.xml" 'RM_HOST' 'NODE_MEMORY_MB' 'NODE_CPU_VCORES'
replace_with_env "$HADOOP_CONF_PATH" "slaves" 'SLAVES'

