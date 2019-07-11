# spring
## Bean
* spring对bean的使用，主要有两种方式，一种是xml配置文件的配置，一种是通过注解的方式实现
## IOC 控制反转（IoC:Inversion of Control）
* 含义：控制权的转移，应用程序本身不负责依赖对象的创建和维护，而是由外部容器负责创建和维护
* DI(依赖注入): 是IOC的一种实现方式
* 目的：创建对象并且组装对象之间的关系
* 反转：获取依赖对象的过程被反转了
## Spring注入方式
* 设值注入；
* 构造注入；
* 接口注入；

## bean
### bean的常用配置项
* id : bean在IOC容器中的唯一标识
* class : 具体要实例化的类名
* scope : 是bean的作用域
* Constructor arguments ：构造器参数
* Properties : bean的属性
* AutoWiring mode : 自动装配模式
* init-method : bean初始化时执行的方法
* lazy-initialization mode : 懒加载模式
* Initialization/destryction method : 初始化和销毁的方法
> 理论上讲bean的配置中只有class是必须的，想从IOC容器中获取bean的实例，有两种方式一个是通过id获取，这时候就需要配置bean的id，另一种方式就是通过类获取，这时候只需要配置bean的class就足够了
### bean的作用域
* singleton : （默认作用域）单例，指一个bean容器中只存在一份
* prototype : 每次请求（每次使用）都会创建新的实例
* request ： 每次http请求创建一个实例且仅在当前request内有效
* session ： 同上，每次http请求创建，当前session内有效
* global session ： 基于protlet的web中有效（portlet定义的global session），如果是在web中，同session
### bean的生命周期
#### 定义 
* 定义 ：及在配置文件中配置bean的属性及参数
#### 初始化
* 实现org.springframework.beans.factory.InitializingBean接口，覆盖afterPropertiesSet方法
~~~java
    public class OneInterfaceImpl implements InitializingBean {
        @Override
        public void afterPropertiesSet() throws Exception {
            System.out.println("--- 实现InitializingBean接口，重写afterPropertiesSet方法 ---");
        }
    }
~~~
* 配置init-method属性
~~~xml
    <bean id="oneInterface"
          class="com.test.ioc.interfaceImpls.OneInterfaceImpl"
          init-method="init"
    ></bean>
~~~
~~~java
    public void init(){
        System.out.println("--- 配置init-method = 'init' ---");
    }
~~~
> 如果两种方式同时使用，第一种方式优先执行
#### 使用 
* 使用 ：及通过context得到对象的实例
#### 销毁
* 实现org.springframework.beans.factory.InitializingBean接口，覆盖afterPropertiesSet方法
~~~java
    public class OneInterfaceImpl implements DisposableBean {
        @Override
        public void destroy() throws Exception {
            System.out.println("--- 实现DisposableBean接口，重写destroy方法 ---");
        }
    }
~~~
* 配置init-method属性
~~~xml
    <bean id="oneInterface"
          class="com.test.ioc.interfaceImpls.OneInterfaceImpl"
          destroy-method="destroyMethod"
    ></bean>
~~~
~~~java
    public void destroyMethod(){
        System.out.println("--- destroy-method=\"destroyMethod\" ---");
    }
~~~
> 如果两种方式同时使用，第一种方式优先执行
#### 配置全局的初始化和销毁的方法
~~~xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd"
       default-init-method="defInitMethod"
       default-destroy-method="defDestroyMethod"
>
<!-- 当定义一个bean时如果设置了init-method或destroy-method属性时，将不再实行默认的始化或销毁的方法，而执行bean中init-method或destroy-method属性对应的始化或销毁方法 -->
<beans>
~~~
### Aware接口
* spring中提供了一些以Aware结尾的接口，实现了Aware接口的bean在被初始化之后，可以获取相应的资源
* 通过Aware接口可以对Spring相应的资源进行操作（慎用）
* 为对Spring进行简单的扩展提供的方便的接口
### Bean的自动装配（Autowiring）
#### 自动装配的几种类型
1. No : 不做任何操作
2. byname : 根据属性名自动装配，此选项将检查容器并根据名字查找与属性完全一致的bean，并将其与属性自动装配，使用byName的时候，必须有set方法
3. byType : 如果一个容器中存在一个与指定属性类型相同的bean，那么将域该属性自动装配；如果存在多个该类型的bean，那么将抛出异常，并不能使用byType方式进行自动装配；如果没有找到相匹配的bean，则什么也不发生，使用byType的时候，必须有set方法
4. Constructor : 与byType类似，不同之处在于它应用于构造器参数。如果容器中没有找到与构造器参数一致的bean，那么抛出异常
#### Spring Bean装配之Resources
* 针对资源文件的统一接口
* Resources
1. UrlResource:URL对应的资源，根据一个URL地址即可创建
2. ClassPathResource:获取类路径下的资源文件
3. FileSystemResource:获取文件系统里的资源
4. ServletContextResource:ServletContext封装的资源，用于访问ServletContext环境下的资源
5. InputStreamResource:针对于输入流封装的资源
6. ByteArrayResource:针对字节数组封装的资源

## Spring Bean装配之Bean的定义及作用域的注解实现
### Classpath 扫描与组件管理
1. 从Spring3.0 开始，Spring JavaConfig项目提供了很多特性，包括使用java而不是XML定义bean,比如@Configuration ,@Bean,@Import,@DependsOn,
2. @Component是一个通用注解，可用于任何Bean，
3. @Repository ,@Service,@Controller 是更有针对性的注解
4. @Repository:通常用于注解Dao类，即持久层
5. @Service:通常用于注解Service类，即服务层
6. @Controller:通常用于Controllor类，即控制层（MVC）
### 元注解（Meta-annotations）
* 许多Spring提供的注解可以作为字节的代码，即“元数据注解”，元注解是一个简单的注解，可以应用到另一个注解
* 除了value(),元注解还可以有其他属性，允许定制
### 类的自动检测及Bean的注册
* spring 可以自动检测类并注册Bean到ApplicationContext中
* 为了能够检测到这些类并注册相应的Bean，需要下面内容
~~~xml
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
            http://www.springframework.org/schema/beans/spring-beans.xsd
            http://www.springframework.org/schema/context
            http://www.springframework.org/schema/context/spring-context.xsd"
>
    <context:component-scan base-package="com.ltkj.beanannotation"></context:component-scan>
</beans>
~~~
* <context:component-scan> 包 <context:annotation-config>,通常在使用前者后不再使用后者，AutowiredAnnotationBeanPostProcessor和CommonAnnotationBeanPostProcessor也被包含进来






