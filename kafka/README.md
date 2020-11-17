# Kafka on Docker

## Docker Compose

To run kafka compose, start up zookeeper compose first, with the default network *zookeeper_default*. 

```bash
docker-compose -f docker-local.kafka.yml up -d
```
## Build Kafka Image

### Download
https://www.apache.org/dyn/closer.cgi?path=/kafka/2.6.0/kafka_2.12-2.6.0.tgz

### Build
[Dockerfile](./dockerfile-build)

```bash
docker build -f dockerfile-build -t lifsh/kafka 

docker run -it --rm --name kafka -p 9092:9092 \
	--network zookeeper_default \
	-e ZK_SERVER=zoo1:2181,zoo2:2181,zoo3:2181 \
	-e KAFKA_HOST=kafka \
	lifsh/kafka

```

**配置参数**

> listeners=PLAINTEXT://:9092

设置默认参数, 如果host设置成localhost, 那么服务器将拒绝所有外部访问。


> advertised.listeners=PLAINTEXT://$KAFKA_HOST:9092

设置一个外部可见的hostname，这个hostname必须是服务器和Producer/Consumer都可见的。

如果Producer/Consumer也使用Docker并和Kafka在同一个network里面，使用默认值或者Container Name即可；否则，要通过改hosts文件的方式手动将hostname解析成目标IP。

```
/etc/hosts
...
# add kafka mapping at the end
kafka 127.0.0.1
```

## Web UI

[kafdrop](https://github.com/obsidiandynamics/kafdrop)

### Start with Docker

```bash
docker pull obsidiandynamics/kafdrop

docker run -it --rm --name kafdrop -p 9000:9000 \
	--network zookeeper_default \
	-e KAFKA_BROKERCONNECT=kafka:9092 \
	obsidiandynamics/kafdrop

```
