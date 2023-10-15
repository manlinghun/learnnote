# Spring Cloud Consul

## windows consul配置



## 注册中心

## 配置中心
### 引入依赖
~~~xml
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-consul-all</artifactId>
    </dependency>
~~~
### 添加配置
~~~properties
    spring.cloud.consul.host=127.0.0.1
    spring.cloud.consul.port=8500
    spring.cloud.consul.config.format=yaml
    spring.cloud.consul.config.prefix=config
    spring.cloud.consul.config.data-key=data
    spring.cloud.consul.config.default-context=joddon
    spring.cloud.consul.config.enabled=true
~~~
### 
