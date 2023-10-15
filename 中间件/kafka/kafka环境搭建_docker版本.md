# kafka环境搭建

## 安装zookeeper

~~~shell
docker pull zookeeper 
 
docker run -d --restart=always --log-driver json-file --log-opt max-size=100m --log-opt max-file=2  --name zookeeper -p 2181:2181 -v /etc/localtime:/etc/localtime wurstmeister/zookeeper


docker pull wurstmeister/kafka
docker run --name kafka -d -p 9092:9092            -e KAFKA_BROKER_ID=0            -e ALLOW_ANONYMOUS_LOGIN=yes            -e KAFKA_ZOOKEEPER_CONNECT=192.168.1.119:2181            -e ALLOW_PLAINTEXT_LISTENER=yes            -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.1.119:9092            -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092            --mount type=bind,source=/home/docker/kafka/data,target=/bitnami/kafka/data            --mount type=bind,source=/home/docker/kafka/logs,target=/opt/bitnami/kafka/logs            -t bitnami/kafka


docker run --name kafka -d -p 9092:9092 \
           -e KAFKA_BROKER_ID=0 \
           -e ALLOW_ANONYMOUS_LOGIN=yes \
           -e KAFKA_ZOOKEEPER_CONNECT=192.168.31.19:2181 \
           -e ALLOW_PLAINTEXT_LISTENER=yes \
           -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://127.0.0.1:9092 \
           -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 \
           --mount type=bind,source=/home/docker/kafka/data,target=/bitnami/kafka/data \
           --mount type=bind,source=/home/docker/kafka/logs,target=/opt/bitnami/kafka/logs \
           -t bitnami/kafka
~~~
 


 
参数说明：
-e KAFKA_BROKER_ID=0  在kafka集群中，每个kafka都有一个BROKER_ID来区分自己
 
-e KAFKA_ZOOKEEPER_CONNECT=192.168.244.132:2181/kafka 配置zookeeper管理kafka的路径172.16.0.13:2181/kafka
 
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://192.168.244.132:9092  把kafka的地址端口注册给zookeeper，如果是远程访问要改成外网IP,类如Java程序访问出现无法连接。
 
-e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 配置kafka的监听端口
 
-v /etc/localtime:/etc/localtime 容器时间同步虚拟机的时间
 
5、验证kafka是否可以使用

 docker exec -it kafka /bin/bash

 cd opt/bitnami/kafka/bin/
 
5.1 创建topic

./kafka-topics.sh --bootstrap-server localhost:9092 --create --partitions 1 --topic firsttopic

5.2 查看创建的额topic列表

./kafka-topics.sh --bootstrap-server localhost:9092 --list

5.3 执⾏以下命令查看指定 topic 相关信息

./kafka-topics.sh --bootstrap-server localhost:9092 --describe --topic firsttopic

5.4 发送消息

./kafka-console-producer.sh --broker-list localhost:9092 --topic firsttopic

5.5 接收消息

./kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic firsttopic

