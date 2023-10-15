# 问题
1. springboot中自动装配功能是如何实现的

# REST

## rest返回的json需要转成xml
pom文件添加依赖
~~~xml
//加了这个依赖后，rest返回的json会被转成xml格式输出
<dependency>
    <groupId>com.fasterxml.jackson.dataformat</groupId>
    <artifactId>jackson-dataformat-xml</artifactId>
</dependency>
~~~
添加该依赖后，若不想将json转成xml，可在接口的GetMapping注解中添加produces = MediaType.APPLICATION_JSON_VALUE，如：
~~~java
 @GetMapping(path = "/json/getUser",produces = MediaType.APPLICATION_JSON_VALUE)
 public User getUser(){
    User user = new User("joddon",22);
    return user;
}
~~~

