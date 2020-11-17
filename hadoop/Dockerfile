FROM openjdk:8

WORKDIR /

# set up ssh for hadoop use
RUN apt update && apt install -y ssh
RUN  ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa && \
     cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys && \
     chmod 0600 ~/.ssh/authorized_keys
RUN echo 'Host *\n   StrictHostKeyChecking no' > ~/.ssh/config

# add hadoop platform frameworks
ADD *.tar.gz ./
ADD *.tgz ./

# ENV JAVA_HOME= set in openjdk
ENV HADOOP_HOME=/hadoop-2.10.1 
ENV HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop
ENV HIVE_HOME=/apache-hive-2.3.7 
ENV SPARK_HOME=/spark-2.4.7-bin-hadoop2.7
ENV NAMENODE_HOST=localhost
ENV HDFS_REPLICATION=1
ENV RM_HOST=localhost
ENV NODE_MEMORY_MB=-1
ENV NODE_CPU_VCORES=-1

# set configurations
ADD conf hadoop-conf

RUN chmod +x /hadoop-conf/*.sh
RUN /hadoop-conf/init-conf.sh

EXPOSE 22 9870 8088
ADD run-services.sh /
# run services in one script
CMD ./run-services.sh 'reinit'
