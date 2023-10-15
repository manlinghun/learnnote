#  什么是SpringCloud



## Eureka服务注册与发现

### 三大角色：

#### Eureka Server

* 提供服务注册与发现

* 使用

  * 导入依赖

    ~~~xml
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
    </dependency>
    ~~~

  * 配置文件

    ~~~yml
    server:
      port: 7001
    
    eureka:
      instance:
        hostname: localhost # Eureka服务的实例名称
      client:
        register-with-eureka: false # 是否向注册中心注册自己
        fetch-registry: false # 为false表示自己为注册中心
        service-url: # 监控页面
          defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka/
    ~~~

    

  * 启动类

    ~~~java
    @SpringBootApplication
    //开启EurekaServer
    @EnableEurekaServer
    public class Application {
        public static void main(String[] args) {
            SpringApplication.run(Application.class,args);
        }
    }
    ~~~

    


#### Service Provider

* 将自身服务注册到Eureka中，从而使消费方能够找到
* 使用
 * 导入依赖

    ~~~xml
    <dependency>
        <groupId>org.springframework.cloud</groupId>
        <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
    </dependency>
    ~~~

  * 配置文件

    ~~~yml
    spring:
      application:
        name: simple-demo
    eureka:
      client:
        service-url:
          defaultZone: http://localhost:7001/eureka/
      instance:
        instance-id: simple-demo-8080
    ~~~
    
    

  * 启动类

    ~~~java
    @SpringBootApplication
    //开启EurekaServer
    @EnableEurekaServer
    public class Application {
        public static void main(String[] args) {
            SpringApplication.run(Application.class,args);
        }
    }
    ~~~


#### Service Consumer

* 服务消费方从Eureka中获取注册服务列表，从而找到消费服务

# ribbon

# Feign
* 申明式的webservice客户端，使服务间的调用变得更加的简单，集成了Ribbon和Eureka，可以再使用Feign的时候负载均衡的http客户端

# Hystrix

* 是一个用于处理分布式系统的延迟和容错的开源库，在分布式系统里，许多依赖不可避免的会调用失败，比如超时、异常等，Hystrix能够保证在一个依赖出现问题的情况下，不会导致整体服务失败，避免级联故障，以提供分布式系统的弹性

* ## 服务熔断

* 服务端做，某个服务超时、异常。就会引起熔断

* ## 服务降级

* 客户端，从整体负载考虑，当某个服务熔断或者关闭后，服务端不会再被调用，此时可以再客户端准备一个fallbackFactory，返回一个默认值

* ## 监控






# SpringCLoud之API网关

## API网关应用场景

