# XmlBeanFactory

# IoC容器的启动
BeanDefinition的Resource定位、载入和注册三个过程
## Resource定位
1. 指的是BeanDefinition的资源定位
2. 
## BeanDefinition的载入
1. 这个载入过程就是把用户定义好的的Bean表示成IoC容器内部的数据结构，而这个容器内部的数据结构就时BeanDefinition
## 注册
1. 通过调用BeanDefinitionRegistry接口的实现来完成的，这个注册过程把载入过程中解析得到的BeanDefinition向IoC容器中进行注册


