# Hadoop on Docker

The image will contain the Hadoop distribution installed, along with other popular libraries such as Hive, Spark, etc.

# Image Builds

Build hadoop image with the *Dockerfile*.

```bash
./download.sh
docker build -t lifsh/hadoop .
```

> verion 1.0

* Hadoop: 2.10.1

* Hive: 2.3.7

* Spark: 2.4.7

# Start Hadoop Cluster

Run with the *docker-compose.yml*.

# Run Application

As an example, submit the Spark PI example to the Yarn cluster.

```bash
./bin/spark-submit \
--class org.apache.spark.examples.SparkPi \
--master yarn \
--deploy-mode client \
--executor-memory 1g \
examples/jars/spark-examples_2.11-2.4.7.jar 10
```

Limit the executor resource is important (such as the above --executor-memory 1g).
