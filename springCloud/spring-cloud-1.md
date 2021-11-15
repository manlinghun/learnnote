# 技术回顾

## Spring Environment

* 是一种在容器内以配置(Profile)和属性(Properties)为模型的应用环境抽象模型
* Spring Framework提供了两种Enviroment的实现，即：
    * 一般应用：StandardEnviroment
    * Web应用：StandardServletEnviroment

## Spring Profiles

* 在Spring容器，Profile是一种命名的Bean定义逻辑组，一个Spring应用可以同时激活多个Profile,常见的使用场景如：应用部署环境（test,stage,production）、单元测试等
* 应用程序可以通过调用 ConfigurableEnvironment 接口控制Profile的激活，如：
    * setActiveProfiles(Stirng...)
    * addActiveProfile(String)
    * setDefaultProfiles(String...)

## Spring Properties
* 属性又称之为配置项，Key-Value等形式，在Spring应用中常用作占位符（Placeholder）,而在API层面，Spring Framework如下抽象来描述
    * 组合属性：PropertySources
    * 单一属性：PropertySource

## Spring 事件监听器

* 事件（Event）
    * ApplicationEvent
* 事件监听器（EventListener）
    * ApplicationListener
* ConfigFileApplicationListener
    * 在SpringBoot中，用于读取默认以及Profile关联的配置文件（application.properties）

### spring配置文件
#### application.properties
* 加载器：PropertiesPropertySourceLoader

#### application.yml或者yaml

* 加载器：YamlPropertySourceLoader

### Environment端点

* 请求URL：/env

## Bootstrap属性配置

参考实现：org.springframework.cloud.bootstrap,BootstrapApplicationListener

#### bootstrap配置文件

~~~java
String configName = environment
				.resolvePlaceholders("${spring.cloud.bootstrap.name:bootstrap}");
~~~

当spring.cloud.bootstrap.name存在时，使用spring.cloud.bootstrap.name值，否则使用bootstrap

vm启动参数设置

~~~properties
-Dspring.application.name=argument
-Dspring.cloud.bootstrap.enabled=true
-Dspring.cloud.bootstrap.name=spring_cloud
-Dspring.cloud.bootstrap.location=aaa
~~~



##### 调整bootstrap配置文件名称

~~~properties
-Dspring.cloud.bootstrap.name=spring_cloud
~~~



##### 调整bootstrap配置文件路径

~~~properties
-Dspring.cloud.bootstrap.location=aaa
~~~



* 覆盖远程配置文件属性

~~~properties
-Dspring.cloud.config.allowOverride=true
~~~



* 自定义bootstrap配置
* 自定义bootstrap配置属性源



## Spring ConfigFileApplication



# Spring Cloud配置服务器

## 分布式配置架构

### 传统架构

![image-20210712222738587](../img/image-20210712222738587.png)

### Spring Cloud Config架构

![image-20210712222646003](../img/image-20210712222646003.png)

## Spring Cloud配置服务器

* Spring Cloud Config Server
  * Spring Cloud配置服务器提供分布式、动态化集中管理应用信息的能力
* 构建Spring Cloud配置服务器
  * @EnableConfigServer

##  服务端Environment仓储

* EnvironmentRepository
  * SpringCloud配置服务器管理多个客户端应用的配置信息，然而这些配置信息需要通过一定的规则获取。Spring Cloud Config Sever 提供EnvironmentRepository接口供客户端应用获取，其中获取维度有三：
    * {application}: 配置客户端应用名称，及配置项：spring.application.name
    * {profile}: 配置客户端应用当前激活的Profile,及配置项：spring.profile.active
    * {label}: 配置服务端标记的版本信息，如Git中的分支名
