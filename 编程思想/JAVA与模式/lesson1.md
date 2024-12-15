# 设计模式

[toc]


## 1. 软件可维护性与可复用性 

### 1.1. 存在的问题

1. 过于僵硬
2. 过于脆弱
3. 重复率低
4. 粘度过高

### 1.2. 设计的目标

1. 可扩展性
2. 灵活性
3. 可插入性

## 2. 设计原则

### 2.1. “开-闭”原则

一个软件实体应该对扩展开放、对修改关闭

1. 对于扩展是开放的（Open for extension）。这意味着模块的行为是可以扩展的。当应用的需求改变时，我们可以对模块进行扩展，使其具有满足那些改变的新行为。也就是说，我们可以改变模块的功能。
2. 对于修改是关闭的（Closed for modification）。对模块行为进行扩展时，不必改动模块的源代码或者二进制代码。模块的二进制可执行版本，无论是可链接的库、DLL或者.EXE文件，都无需改动。

### 2.2. 里氏代换原则

任何基类可以出现的地方、子类一定可以出现

### 2.3. 依赖倒转原则

要依赖于抽象，不要依赖于实现

### 2.4. 接口隔离原则

应当为客户端提供尽可能小的单独接口，不是大的总接口

### 2.5. 组合/聚合复用原则

组合/聚合复用原则(Composite/Aggregate Reuse Principle，或 CARP),又称合成复用原则（Composite Reuse Principle,或CRP）要尽量使用合成/聚合，而不是关系达到复用的目的

### 2.6. 迪米特法则(LoD law of Demeter)

又称作最少知识原则（LKP least Knowledge Principle）
一个软件实体应当尽可能少的与其他实体发生相互作用

## 3. 创建形模式（Creational Patterns）

### 3.1. 简单工厂（Simple Factory）模式

#### 3.1.1. 介绍

  又称静态工厂方法模式，简单工厂模式就是一个工厂类根据传入的参数决定创建出哪一种产品类的实例。

#### 3.1.2. 结构

  涉及到三个角色：

* 工厂角色：担任这个角色是简单工厂模式的核心，含有与应用紧密相关的业务逻辑，工厂类在客户端的调用下创建产品对象。往往由一个具体java类实现

```java
    public class ArtTracerFactory {
        public static Shape createShape(String shapeName){
            Shape shape;
            switch (shapeName){
                case "circle":
                    shape = new Circle();
                    break;
                case "quadrate":
                    shape = new Quadrate();
                    break;
                case "triangle":
                    shape = new Triangle();
                    break;
                default:
                    throw new RuntimeException("unknow shape name '"+shapeName+"'");
            }
            return shape;
        }
    }
```

* 抽象产品角色：是由工厂方法创建的对象的父类，或它们共同拥有的接口，抽象产品角色可以用一个java抽象类或者接口来实现

```java
    public interface Shape {
        void draw();
        void erase();
    }
```

* 具体产品角色：工厂方法模式创建的对象都是属于这个角色，其必须实现或继承抽象产品角色，具体产品角色由一个具体java类实现

```java
    public class Circle implements Shape {
        @Override
        public void draw() {
            System.out.println("Draw Circle");
        }
        @Override
        public void erase() {
            System.out.println("Erase Circle");
        }
    }
    public class Quadrate implements Shape {
        @Override
        public void draw() {
            System.out.println("Draw Quadrate");
        }
        @Override
        public void erase() {
            System.out.println("Erase Quadrate");
        }
    }
    public class Triangle implements Shape {
        @Override
        public void draw() {
            System.out.println("Draw Triangle");
        }
        @Override
        public void erase() {
            System.out.println("Erase Triangle");
        }
    }
```

#### 3.1.3. 应用

1. DateFormat
2. SAX2库中的XMLReaderFactory

### 3.2. 工厂方法(Factory Method)模式

#### 3.2.1. 介绍

* 工厂方法模式是类的创建模式，又叫做虚拟构造子（Virtural Constructor）模式或多态性工厂（Polymorphic Factory）模糊
* 工厂方法模式的用意是定义一个创建产品对象的工厂接口，将实际创建工作推迟到子类中

#### 3.2.2. 结构

  使用工厂方法模式涉及到以下几个角色：

1. 抽象工厂角色
   抽象工厂模式的核心，与应用程序无关的，任何创建对象的工厂都必须实现这个接口，在实际系统中，这个角色通常是抽象类来实现

```java
    public interface Creator {
        Product create();
    }
```

2. 具体工厂角色
   实现了抽象工厂的接口，具体工厂角色含有与应用密切相关的逻辑，且被客户端调用以产生具体的产品对象

```java
    public class CreatorOne implements Creator{
        @Override
        public Product create() {
            return new ProductOne();
        }
    }
    public class CreatorTwo implements Creator{
        @Override
        public Product create() {
            return new ProductTwo();
        }
    }
```

3. 抽象产品角色
   工厂方法模式中创建产品的超类型，也就是产品对象共同的父类或者共有的接口，在系统中该角色一般由java抽象类实现

```java
    public interface Product {
        //产品功能
    }
```

4. 具体产品角色
   实现了抽象产品角色申明的接口，工厂方法模式创建的每一个对象都是具体产品角色的实例

```java
    public class ProductOne implements Product{
      //产品功能实现
    }
    public class ProductTwo implements Product{
      //产品功能实现
    }
```

#### 3.2.3. 简单工厂与工厂方法模式比较

* 工厂方法的核心是一个抽象工厂类，简单工厂的核心是一个具体工厂类

#### 3.2.4. 应用

1. 在Java聚集中的应用，所有Java的聚集都实现了java.util.Collection接口，这个接口规定所有的Java聚集都必须实现一个iterator方法，这个方法返回一个Iterator对象
2. URL与URLConnection的应用，URL对象提供一个openConnection()的工厂方法，这个方法返回一个URLConnection对象

### 3.3. 抽象工厂(Abstract Factory)模式

#### 3.3.1. 介绍

  抽象工厂模式是所有形态的工厂模式中最为抽象和最具一般性的一种形态。
  抽象工厂模式可以向客户端提供一个接口，使得客户端在不必指定产品的具体类型的情况下创建多个产品族中的产品对象，这就是抽象工厂模式的用意。
  抽象工厂，“抽象”来自“抽象产品角色”，而“抽象工厂”就是抽象产品角色的工厂
  ![](img/2023-07-01-14-21-23.png)

#### 3.3.2. 结构

  结合上图，可以看出抽象工厂模式涉及到以下橘色

1. 抽象工厂角色，
   担任这个角色的是工厂方法模式的核心，它是与应用系统的商业逻辑无关的。

```java
  public interface Creator {
  
      ProductA createA();
  
      ProductB createB();
  }
```

2. 具体工厂角色
   这个角色直接在客户端的调用下创建产品实例，这个角色含有选择适合产品的逻辑。

```java
  public class CreatorOne implements Creator{
  
  
      @Override
      public ProductA createA() {
          return new ProductAOne();
      }
  
      @Override
      public ProductB createB() {
          return new ProductBOne();
      }
  }
  public class CreatorTwo implements Creator{
      @Override
      public ProductA createA() {
          return new ProductATwo();
      }
  
      @Override
      public ProductB createB() {
          return new ProductBTwo();
      }
  }
```

3. 抽象产品角色
   担任这个角色的类是工厂方法模式所创建的对象的父类，

```java
  
  public interface ProductA {
      // 产品功能
  }
  public interface ProductB {
      // 产品功能
  }
```

4. 具体产品角色
   抽象工厂模式所创建的任何产品对象都是某一个具体产品类的实例，这是客户端最终需要的东西

```java
  public class ProductAOne implements ProductA{
      // 产品功能实现
  }
  public class ProductATwo implements ProductA{
      // 产品功能实现
  }
  public class ProductBOne implements ProductB{
      // 产品功能实现
  }
  public class ProductBTwo implements ProductB{
      // 产品功能实现
  }
```

#### 3.3.3. 在什么情况下使用抽象工厂模式

文献【GOF95】指出，在以下情况下应当考虑使用抽象工厂模式：

1. 一个系统不应当依赖于产品类实例如何被创建、组合和表达的细节，这对于所有形态的工厂模式都是重要的。
2. 这个系统的产品有多于一个的产品族，而系统只消费其中某一族的产品。
3. 同属于一个产品族的产品实在一起使用的、这一约束必须在系统的设计中体现出来。
4. 系统提供一个产品库类的库、所有的产品以通常的接口出现，从而使客户端不依赖于实现。

### 3.4. 单例(Singleton)模式

#### 3.4.1. 介绍

    单例模式的要点有三个，

    * 一是某一个类只能有一个实例、
	* 二是它必须自行创建这个实例、
	* 三是它必须自行向整个系统提供这个实例

#### 3.4.2. 结构

##### 3.4.2.1. 饿汉式单例类

```java
/**
 * 饿汉式单例
 */
public class EagerSingleton {

    private static EagerSingleton singleton = new EagerSingleton();

    private EagerSingleton(){}

    public static EagerSingleton getInstance() {
        return singleton;
    }

}
```

##### 3.4.2.2. 懒汉式单例

```java
/**
 * 懒汉式单例
 */
public class LazySingleton {

    private static LazySingleton singleton;

    private LazySingleton(){}

    synchronized public static LazySingleton getInstance() {
        if(singleton == null){
            singleton = new LazySingleton();
        }
        return singleton;
    }

}
```

#### 3.4.3. 应用

1. java的Runtime对象，

   ```java
   Runtime rt = Runtime.getRuntime();
   ```

#### 3.4.4. 双重检查成例的探讨

  说先说明结论：__双重检查成例在Java中是不成立的__
  双重检查成例的java写法为：

```java
  public class DoubleCheckSingleton {
      private static DoubleCheckSingleton singleton;
      public static DoubleCheckSingleton getInstance() {
          if(singleton == null){
              synchronized (DoubleCheckSingleton.class){
                  if(singleton == null){
                      singleton = new DoubleCheckSingleton();
                  }
              }
          }
          return singleton;
      }
  }
```

### 3.5. 建造(Builder)模式

#### 3.5.1. 介绍

    建造模式是一种对象创建模式，它将产品的构建过程抽象出来，将一个产品的内部表象与产品的生产过程分割开，从而可以使用不同的生成方式来得到同种产品。

#### 3.5.2. 结构

建造模式包含如下角色：
* 抽象建造者(Builder)角色,给出一个抽象接口，以规范产品对象的各个部分的创建工作。
~~~java
public abstract class Builder {

    public abstract void buildPartA();

    public abstract void buildPartB();

    public abstract Product getResult();
}
~~~
* 具体建造者(Concrete Builder)角色，实现抽象建造者所定义的接口，实现产品的各个部件的创建工作。
~~~java
public class ConcreteBuilder extends Builder{

    public Product product = new Product();
    @Override
    public void buildPartA() {
        product.partA = "partA";
    }

    @Override
    public void buildPartB() {
        product.partB = "partB";
    }

    @Override
    public Product getResult() {
        return product;
    }
}
~~~
* 导演者(Director)角色，调用具体建造者来创建产品对象的各个部分，irector不直接操作具体建造者，而是通过抽象建造者来操作。
~~~java
public class Director {

    private Builder builder;

    public void construct() {
        builder.buildPartA();
        builder.buildPartB();
    }
}

~~~
* 产品(Product)角色，是被构建的复杂对象。
~~~java
public class Product {

    String partA;

    String partB;
}
~~~

#### 3.5.3. 应用

1. javaMail

### 3.6. 原始(Prototype)模型

#### 3.6.1. 介绍

    原型模式（Prototype Pattern）是创建型模式，它提供了一种创建对象的最佳方式。通过给出一个原型对象来创建出更多同类型的对象，而不是通过new关键字来创建对象。

#### 3.6.2. 结构



#### 3.6.3. 应用



## 4. 结构模式 （Structural Patterns）

### 4.1. 适配器（Adapter）模式

#### 4.1.1. 介绍

适配器模式（Adapter Pattern）是作为两个不兼容的接口之间进行转换。适配器有类适配器和对象适配器两种不同的形式

#### 4.1.2. 类适配器

类适配器模式把被适配的类的API转换成目标类的API

##### 4.1.2.1. 结构

类适配器涉及以下几个角色

1. 目标角色

~~~java
public interface Target {

    void sampleOperation1();

    void sampleOperation2();

}
~~~

2. 源角色

~~~java
public class Source {

    public void sampleOperation1(){
        System.out.println("this is original sampleOperation1");
    }

}
~~~

3. 适配器角色

~~~java
public class Adapter extends Source implements Target{

    @Override
    public void sampleOperation2() {
        System.out.println("Adapter sampleOperation2");
    }
}
~~~

#### 4.1.3. 对象适配器

与类适配器不同的是，对象适配器是通过组合的方式，把源角色作为适配器的成员变量，从而实现源角色和目标角色之间的转换。

##### 4.1.3.1. 结构

对象适配器涉及以下几个角色

1. 目标角色

~~~java
public interface Target {

    void sampleOperation1();

    void sampleOperation2();

}
~~~

2. 源角色

~~~java
public class Source {

    public void sampleOperation1(){
        System.out.println("this is original sampleOperation1");
    }

}
~~~

3. 适配器角色

~~~java

public class Adapter implements Target {

    public Source source;

    public Adapter(Source source) {
        this.source = source;
    }
    
    @Override
    public void sampleOperation1() {
        source.sampleOperation1();
    }

    @Override
    public void sampleOperation2() {
        System.out.println("Adapter sampleOperation2");
    }
}

~~~

#### 4.1.4. 应用场景

1. 以前开发的系统存在满足新系统的需求，但是接口不符合要求，此时，可以使用适配器模式。
2. 使用第三方提供的API，但是API接口不匹配，此时，可以使用适配器模式。


### 4.2. 缺省适配（Default Adapter）模式

### 4.3. 合成（Composite）模式

#### 4.3.1. 介绍

合成模式将对象组织到树结构中，可以用来描述整体与部分的关系，合成模式可以是客户端将单纯元素与复合元素同等看待

#### 4.3.2. 结构

合成模式涉及以下角色
1. 抽象构件（Component）角色：抽象角色，给参加组合的对象规定一个接口，这个角色给出共有的接口及其默认行为
2. 树叶构件（Leaf）角色，代表参入组合的树叶对象，一个树叶没有下级的子对象、定义出参加组合柜的原始对象的行为
3. 树枝构件（Composite）角色，代表参加组合的有子对象的对象，并给出树枝构件对象的行为


#### 4.3.3. 应用


### 4.4. 装饰（Decorator）模式

#### 4.4.1. 介绍
装饰模式（Derection Pattern）又称为包装模式（wrapper pattern），它通过继承的方式，将一个对象嵌入到另一个对象中，从而扩展对象的功能。

#### 4.4.2. 结构

装饰模式涉及以下几个角色
1. 抽象构件（ Component ）定义一个抽象接口以规范准备接收附加责任的对象
~~~java
public interface Component {
    void operation();
}
~~~
2. 具体构件（ Concrete Component ）定义一个准备接收附加责任的类
~~~java
public class ConcreteComponent implements Component{
    @Override
    public void operation() {
        System.out.println("ConcreteComponent operation");
    }
}
~~~
3. 抽象装饰类（ Decorator ）持有一个构件对象的实例，并定义一个与抽象接口一致的接口
~~~java
public class Decorator implements Component{

    private Component component;

    public Decorator(Component component)
    {
        this.component = component;
    }

    public Decorator(){

    }

    @Override
    public void operation() {
        component.operation();
    }
}
~~~
1. 具体装饰类（ Concrete Decorator ）负责给构件对象添加附加的职责
~~~java
public class ConcreteDecorator extends Decorator{

    @Override
    public void operation() {
        super.operation();
    }
}

~~~

#### 4.4.3. 应用

什么时间使用装饰者模式
1. 需要扩展一个类的功能
2. 对一个类进行功能扩展
3. 需要增加由一些基本功能的排列组合而产生的非常大量的功能，从而使得继承关系变的不现实

实际应用场景：
1. IO流中的包装类 BufferedInputStream、BufferedReader等

#### 4.4.4. 代理模式和适配器模式区别

* 相同点
   1. 都要实现与目标类相同的业务接口
   2. 在两个类中都要生命目标对象
   3. 都可以在不修改目标类的前提下增强目标方法
* 不同点
  1. 目的不同：装饰者是为了增强目标对象，静态代理是为了保护和隐藏目标对象
  2. 获取目标对象的方式不同：代理模式通过new关键字获取目标对象，而适配器模式通过构造函数或者setter方法获取目标对象 

### 4.5. 代理（Proxy）模式

#### 4.5.1. 介绍
    
    代理模式（Proxy Pattern）是作为一个对象，这个对象封装另一个对象的功能，从而扩展对象的功能。代理模式给某一个对象提供一个代理对象，并有代理对象控制对源对象的引用

    Java中的代理按照代理对象生成式时机不同，分为静态代理和动态代理。静态代理在类加载的时候就确定下来了，而动态代理是在运行时动态生成的。动态代理有两种常用的实现方式：JDK动态代理、CGLIB动态代理

#### 4.5.2. 结构

代理模式涉及的角色如下：

* 抽象主题角色（Subject）：声明了真实主题的和代理主题的公共接口，
~~~java
public interface Subject {

    void doSomething();
}
~~~
* 代理角色（Proxy）：持有真实主题的引用，所以代理可以访问真实主题，在真实主题不可用的时候提供替身访问能力，
~~~java
public class ProxySubject implements Subject{

    private RealSubject realSubject=new RealSubject();

    @Override
    public void doSomething() {
        System.out.println("ProxySubject doSomething");
        realSubject.doSomething();
    }
}
~~~
* 真实主题角色（RealSubject）：定义真实主题的接口，
~~~java

public class RealSubject implements Subject{
    @Override
    public void doSomething() {
        System.out.println("real do something");
    }
}
~~~

#### 4.5.3. 静态代理

动态代理就是上述结构中描述的代理方式

#### 4.5.4. 动态代理

1. JDK动态代理

~~~java

public class ProxyFactory {

    public static Object getProxy(Object target)
    {
        return Proxy.newProxyInstance(target.getClass().getClassLoader(), target.getClass().getInterfaces(), new InvocationHandler() {
            @Override
            public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
                System.out.println("proxy do something");
                method.invoke(target, args);
                return null;
            }
        });
    }

}

~~~

2. CGLIB动态代理

由于是第三方jar提供，所以需要引入第三方jar，maven依赖如下：

~~~xml

<dependency>
    <groupId>cglib</groupId>
    <artifactId>cglib</artifactId>
    <version>3.3.0</version>
</dependency>

~~~

~~~java

import net.sf.cglib.proxy.Enhancer;
import net.sf.cglib.proxy.MethodInterceptor;
import net.sf.cglib.proxy.MethodProxy;

import java.lang.reflect.Method;

public class CglibProxyFactory {

    public Object getProxy(Class clazz)
    {
        Enhancer enhancer = new Enhancer();
        enhancer.setSuperclass(clazz);
        enhancer.setCallback(new MethodInterceptor() {
            @Override
            public Object intercept(Object o, Method method, Object[] objects, MethodProxy methodProxy) throws Throwable {
                System.out.println("cglib proxy do something");
                return method.invoke(o, objects);
            }
        });
        return enhancer.create();
    }

}

~~~


### 4.6. 享元（Flyweight）模式

#### 4.6.1. 介绍

享元模式（Flyweight Pattern）是使用共享对象来有效地支持大量细粒度的对象。

#### 4.6.2. 结构

享元模式涉及的角色如下：
1. 抽象享元角色（Flyweight）：声明一个接口，用于定义内部状态和外部状态，并且定义一个接口，用于返回内部状态的值。
2. 具体享元角色（ConcreteFlyweight）：实现抽象享元角色，定义具体享元角色的内部状态，并且可以共享内部状态
3. 享元工厂角色（FlyweightFactory）：用于创建和保存享元角色，当用户请求一个享元时，享元工厂角色会首先检查享元是否已经存在，如果存在则返回该享元，如果不存在则创建一个享元并返回。

#### 4.6.3. 应用

### 4.7. 门面（Facade）模式

#### 4.7.1. 介绍

门面模式，又称为外观模式，他要求一个子系统的外部于与其内部的通信必须通过一个统一的门面（Facade）对象进行。门面模式定义了一个统一的接口，用来调用子系统中的一组接口，让外部调用者可以透明地调用子系统接口。

#### 4.7.2. 结构

门面模式涉及的角色如下：

1. 外观角色（Facade）：定义一个统一的接口，为多个复杂的子系统提供一个统一、简单的接口，外观角色直接与子系统交互。
2. 子系统角色（Subsystem）：定义子系统的接口，供外观角色调用。可以同时有一个或者多个子系统


#### 4.7.3. 应用

门面模式是迪米特法则的典型应用

什么情况下使用门面模式：
1. 层次化结构，避免子系统之间出现循环调用，而是通过引入一个外观对象来引入层次结构
2. 为一个复杂子系统提供一个简单接口
3. 子系统的独立性

### 4.8. 桥接（Bridge）模式

#### 4.8.1. 介绍

桥接模式（Bridge Pattern）是把抽象（抽象类）与实现（接口）分离，使它们可以独立变化。

#### 4.8.2. 结构

1. 抽象化角色（ Abstraction ）给出抽象接口，并保留对实现化对象的引用。
~~~java
public abstract class Abstraction {

    private Implementor implementor;

    public void operation(){
        implementor.operationImpl();
    }
}
~~~
2. 修正抽象化（ Refined Abstraction ）角色，实现抽象化角色的接口，以便扩展更多功能。
~~~java
public class RefinedAbstraction extends Abstraction{

    public void operation(){
        System.out.println("RefinedAbstraction operation");
    }

}
~~~
3. 实现化（ Implementor ）角色，定义实现化角色的接口，供扩展使用。
~~~java
public abstract class Implementor {
    public abstract void operationImpl();
}

~~~
4. 具体实现化（ Concrete Implementor ）角色，实现实现化角色接口，以便扩展更多功能。
~~~java
public class ConcreteImplementorA extends Implementor{
    @Override
    public void operationImpl() {
        System.out.println("ConcreteImplementorA");
    }
}
~~~

#### 4.8.3. 应用

好处：
1. 提高系统的可维护性，在两个变化维度中任意修改一个维度，都不需要修改原有系统
2. 实现细节对客户端透明

什么情况下使用桥梁模式
1. 如果一个系统需要再构件的抽象化角色和具体化角色之间增加更多的灵活性，避免在两个层次之间建立静态的联系
2. 设计要求实现化角色的任何改变不应当影响客户端、或者说实现化角色的改变对客户端是完全透明的
3. 一个构件有多于一个的抽象化角色和实现化角色，系统需要他们之间进行动态耦合
4. 虽然在系统中使用继承是没有问题的，但是由于抽象化角色和具体化角色需要独立变化，设计要求需要独立管理这两者
   



## 5. 行为模式 (Behavioral Patterns)

### 5.1. 不变（Immutable）模式

#### 5.1.1. 介绍

不变模式（Immutable Pattern）是创建型模式，通过将一个对象封装在它的不可变类中，来保证该对象在 throughout its lifetime 不会改变。

#### 5.1.2. 结构


#### 5.1.3. 应用


 
### 5.2. 策略(Strategy)模式

#### 5.2.1. 介绍

策略模式（Strategy Pattern）是定义一系列的算法，把它们一个个封装起来，并且使他们可以相互替换。

#### 5.2.2. 结构

策略模式包含以下角色：

1. 抽象策略（Strategy）：定义了一个公共接口，各种不同的算法以不同的方式实现这个接口，环境（Context）使用这个接口调用不同的算法，一般使用接口或抽象类定义
~~~java
public interface Strategy {

    void strategyInterface();

}
~~~
2. 具体策略（Concrete Strategy）：实现了抽象策略定义的接口，提供具体的算法实现
~~~java
public class ConcreteStrategy implements Strategy{
    @Override
    public void strategyInterface() {

    }
}
~~~
3. 环境（Context）：定义使用的算法，使用策略对象，客户端不关心算法的细节，只关心接口。
~~~java
public class Context {

    private Strategy strategy;

    public Context(Strategy strategy)
    {
        this.strategy = strategy;
    }

    public void contextInterface(){
        strategy.strategyInterface();
    }

}
~~~

#### 5.2.3. 应用

##### 5.2.3.1. 什么时候使用策略模式

1. 如果一个系统里面有许多类，它们之间的区别在于他们的行为，那么使用策略模式可以动态地让一个对象在许多行为中选择一种行为
2. 一个系统需要动态地在几个算法中选择一种
3. 一个系统的算法使用的数据不可以让客户端知道，策略模式可以避免让客户端涉及到不必要接触到的复杂的和只与算法有关的数据
4. 如果一个对象有很多行为，如果不使用恰当的模式，这些行为就只好使用多层的条件选择语句

##### 5.2.3.2. 优缺点

### 5.3. 模板方法(Template Method)模式

#### 5.3.1. 介绍

模板方法模式（Template Method Pattern）定义一个操作中的算法的骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。

#### 5.3.2. 结构

模板方法模式包含以下角色：

1. 抽象模板角色（Abstract Template）：定义一个模板方法，该模板方法执行一个或多个抽象操作，这些操作在模板方法中以抽象方式声明；定义一个回调方法，用于让 Concrete Template 扩展模板方法
~~~java
public abstract class AbstractTemplate {

    /**
     * 模板方法
     */
    public final void templateMethod(){
        abstractMethod1();
        abstractMethod2();
        doOperation();
    }

    public abstract void abstractMethod1();

    public abstract void abstractMethod2();

    public final void doOperation() {

	}

}
~~~
2. 具体模板角色（Concrete Template）：实现抽象模板角色中的抽象操作，并可以增加自己的操作
~~~java
public class ConcreteTemplate extends AbstractTemplate{

    @Override
    public void abstractMethod1() {

    }

    @Override
    public void abstractMethod2() {

    }
}

~~~

### 5.4. 观察者（Observer）模式

#### 5.4.1. 介绍

观察者模式（Observer Pattern）定义对象间的一种一对多的依赖关系，以便当一个对象的状态发生改变时，所有依赖于它的对象都得到通知并被自动更新。

#### 5.4.2. 结构

观察者模式包含以下角色：

1. 抽象观察者（Observer）：定义一个更新接口，当接到通知时更新自己
~~~java
public interface Observer {

    /**
     * 更新
     */
    void update();
}
~~~
2. 具体观察者（Concrete Observer）：实现抽象观察者定义的更新接口，以便在得到通知时更新自身的状态
~~~java
public class ConcreteObserver implements Observer{
    @Override
    public void update() {
        System.out.println("ConcreteObserver update");
    }
}
~~~
3. 抽象主题（Subject）：定义一个接口，可以增加或删除观察者对象，当状态发生改变时，通知所有观察者
~~~java
public interface Subject {

    void registerObserver(Observer observer);

    void removeObserver(Observer observer);

    void notifyObservers();
}
~~~
4. 具体主题（Concrete Subject）：实现抽象主题定义的接口，当状态发生改变时，通知所有观察者
~~~java
public class ConcreteSubject implements Subject{

    private Vector<Observer> observerVector = new Vector();

    @Override
    public void registerObserver(Observer observer) {
        observerVector.add(observer);
    }

    @Override
    public void removeObserver(Observer observer) {
        observerVector.remove(observer);
    }

    @Override
    public void notifyObservers() {
        Enumeration<Observer> enumeration = getObservers();
        while (enumeration.hasMoreElements()){
            enumeration.nextElement().update();
        }
    }

    private Enumeration<Observer> getObservers() {
        return ((Vector<Observer>)observerVector.clone()).elements();
    }
}
~~~

### 5.5. 迭代器（Iterator）模式

#### 5.5.1. 介绍

迭代器模式（Iterator Pattern）也称游标（Cursor）模式，提供一种方法顺序访问一个聚合对象中的各个元素，而又不暴露该对象的内部表示。

#### 5.5.2. 结构

迭代器模式包含以下角色：
1. 抽象迭代器（Iterator）：定义一个接口，声明方法，用于访问和遍历元素
~~~java
public interface Iterator {
    /**
     * 迭代方法，移动到第一个元素
     */
    void first();
    /**
     * 迭代方法，移动到下一个元素
     */
    void next();
    /**
     * 迭代方法，是否已经迭代完毕
     */
    boolean isDone();
    /**
     * 迭代方法，返还当前元素
     */
    Object currentItem();
}
~~~
2. 具体迭代器（Concrete Iterator）：实现抽象迭代器定义的接口，在迭代器中维持一个对创建它的工厂对象的引用，并提供一个返回工厂对象的方法
~~~java
public class ConcreteIterator implements Iterator{

    private ConcreteAggregate  aggregate;

    private int index = 0;
    private int size = 0;

    public ConcreteIterator(ConcreteAggregate aggregate) {
        this.aggregate = aggregate;
        size = aggregate.size();
        index = 0;
    }

    @Override
    public void first() {
        index = 0;
    }

    @Override
    public void next() {
        if(index<size){
            index++;
        }
    }

    @Override
    public boolean isDone() {
        return index>=size;
    }

    @Override
    public Object currentItem() {
        return aggregate.getElement(index);
    }
}
~~~
3. 聚集（Aggregate）：定义一个接口，声明一个创建迭代器的抽象工厂方法
~~~java
public interface Aggregate {

    public Iterator createIterator();

}
~~~
4. 具体聚集（Concrete Aggregate）：实现抽象聚集定义的接口，创建一个具体迭代器对象，以具体聚集为参数
~~~java
public class ConcreteAggregate implements Aggregate{

    private Object[] objects = {1,2,3,4,5,6,7,8,9,10};


    @Override
    public Iterator createIterator() {
        return new ConcreteIterator(this);
    }

    public Object getElement(int index) {
        if (index < objects.length) {
            return objects[index];
        } else {
            return null;
        }
    }

    public int size() {
        return objects.length;
    }
}
~~~
5. 客户端（CLient）：创建一个具体聚集对象，并使用一个具体迭代器对象来遍历该聚集对象
~~~java
public class Client {

    private Iterator iterator;
    private Aggregate aggregate=new ConcreteAggregate();

    public void operation(){
        iterator = aggregate.createIterator();
        while (!iterator.isDone()){
            System.out.println(iterator.currentItem());
            iterator.next();
        }
    }

    public static void main(String[] args) {
        Client client=new Client();
        client.operation();
    }
}
~~~

#### 5.5.3. 应用

##### 5.5.3.1. 优缺点
1. 优点
   1. 简化了聚集的设计，迭代器具有一个遍历接口，这样聚集的接口就不需要具备遍历接口
   2. 每一个聚集对象都可以有一个或多个迭代子对象，且状态是相互独立的，所以一个聚集对象可以有多个迭代子对象在进行中
   3. 遍历方法被封装在迭代子中，聚集无需关心
2. 缺点
   1. 迭代子给客户端一种聚集是顺序化的错觉
   2. 迭代子给出的聚类元素没有类型特征，所以客户端必须知道元素类型才能使用

### 5.6. 责任链（Chain of Responsibility）模式

#### 5.6.1. 介绍
责任链模式（Chain of Responsibility Pattern），也称职责链模式，是一种对象的行为设计模式。在链中前一个对象处理完请求后，将请求传给下一个对象，直到链中的最后一个对象处理完请求。

#### 5.6.2. 结构
责任链模式包含以下角色：
1. 抽象处理者（Handler）：定义一个接口，实现该接口可以处理请求，同时可以保存一个对下一个处理者的引用
~~~java
public abstract class Handler {
    private Handler successor;
    public abstract void handleRequest();
    public void setSuccessor(Handler successor){
        this.successor = successor;
    }

    public Handler getSuccessor() {
        return successor;
    }
}
~~~
2. 具体处理者（Concrete Handler）：实现抽象处理者的接口，在具体处理者中定义处理请求的方法，在处理请求时通常会委托其他对象处理，或者自己处理
~~~java
public class ConcreteHandler extends Handler{
    @Override
    public void handleRequest() {
        if (Objects.nonNull(getSuccessor())){
            System.out.println("ConcreteHandler handleRequest");
            getSuccessor().handleRequest();
        }else {
            System.out.println("no handle");
        }
    }
}
~~~

#### 5.6.3. 应用
~~~java
public class Client {
    public static void main(String[] args) {
        Handler h1 = new ConcreteHandler();
        Handler h2 = new ConcreteHandler();
        h1.setSuccessor(h2);
        h1.handleRequest();
    }
}
~~~

### 5.7. 命令（Command）模式

#### 5.7.1. 介绍

命令模式（Command Pattern），也称行动（Action）模式或者交易（Transation）模式，是一种对象行为设计模式。在命令模式中，一个请求以命令的形式包裹在对象中，并传给调用对象。调用对象寻找可以处理该命令的合适的对象，并把该命令传给相应的对象，该对象执行命令。

#### 5.7.2. 结构

命令模式包含以下角色：
1. 抽象命令（Command）：定义一个接口，实现该接口可以执行一个请求
~~~java
public interface Command {
    public void execute();
}
~~~
2. 具体命令（Concrete Command）：实现抽象命令定义的接口，在具体命令中实现请求
~~~java
public class ConcreteCommand implements Command{

    private Receiver receiver;

    public ConcreteCommand(Receiver receiver) {
        this.receiver = receiver;
    }

    @Override
    public void execute() {
        receiver.action();
    }
}
~~~
3. 请求者（Invoker）：负责调用命令对象执行请求，它know 哪些命令对象可用，unknow 命令对象如何使用
~~~java
public class Invoker {

    private Command command;

    public Invoker(Command command) {
        this.command = command;
    }

    public void invoke() {
        command.execute();
    }
}
~~~
4. 接收者（Receiver）：执行请求所调用的方法的类
~~~java
public class Receiver {
    public Receiver(){
        System.out.println("receiver init");
    }
    public void action(){
        System.out.println("receiver action");
    }
}
~~~
5. 客户端（Client）: 创建一个具体命令对象并指定它的接收者
~~~java
public class Client {
    public static void main(String[] args) {
        Receiver receiver = new Receiver();
        Command command = new ConcreteCommand(receiver);
        Invoker invoker = new Invoker(command);
        invoker.invoke();
    }
}
~~~

#### 5.7.3. 应用

### 5.8. 备忘录（Memento）模式

#### 5.8.1. 介绍

备忘录模式（Memento Pattern），也称快照（Snapshot）模式或者Token模式，是一种对象行为设计模式。在备忘录模式中，发起人（Originator）对象通过创建备忘录对象（Memento）来保存其内部状态，而将备忘录对象保存在某一存储器（Caretaker）对象中。当发起人需要时，可以从备忘录对象（Memento）中恢复其内部状态。

#### 5.8.2. 结构

备忘录模式包含以下角色：
1. 备忘录（Memento）：记录发起人内部状态的对象
2. 发起人（Originator）：创建备忘录对象，保存和恢复内部状态
3. 存储器（Caretaker）：保存备忘录对象，提供获取备忘录对象的方法

#### 5.8.3. 应用

##### 5.8.3.1. 白箱实现
1. 备忘录（Memento）
~~~java

public class Memento {
    private String state;

    public Memento(String state)
    {
        this.state = state;
    }

    public String getState()
    {
        return state;
    }

    public void setState(String state)
    {
        this.state = state;
    }
}
~~~
2. 发起人（Originator）
~~~java
public class Originator {
    private String state;

    public Memento createMemento()
    {
        return new Memento(state);
    }

    public void setMemento(Memento memento)
    {
        state = memento.getState();
    }

    public void setState(String state)
    {
        this.state = state;
    }
    public String getState()
    {
        return state;
    }

}
~~~
3. 存储器（Caretaker）
~~~java
public class Caretaker {
    private Memento memento;

    public Memento getMemento()
    {
        return memento;
    }

    public void setMemento(Memento memento)
    {
        this.memento = memento;
    }
}
~~~
4. 客户端（Client）
~~~java
public class Client {

    public static void main(String[] args)
    {
        Originator originator = new Originator();
        Caretaker caretaker = new Caretaker();
        // 改变负责人的状态
        originator.setState("On");
        // 创建备忘录
        caretaker.setMemento(originator.createMemento());
        // 喜好发起人的状态
        originator.setState("Off");
        // 恢复发起人的状态
        originator.setMemento(caretaker.getMemento());
    }
}

~~~

##### 5.8.3.2. 黑箱实现
1. 备忘录（Memento）
~~~java
~~~
1. 发起人（Originator）
~~~java
~~~
1. 存储器（Caretaker）
~~~java
~~~

### 5.9. 状态（State）模式

#### 5.9.1. 介绍

状态模式（State Pattern），也称状态对象（State Object）模式，是一种行为设计模式。在状态模式中，我们用一个对象（状态对象）来封装一系列状态相关的行为，当状态对象发生改变时，它会自动将状态对象所对应的行为进行调用。

#### 5.9.2. 结构

状态模式包含以下角色：

1. 抽象状态（State）：定义一个接口，用以封装与抽象同事类的对话
~~~java
public interface State {

    void simpleOperation();
}
~~~
2. 具体状态（Concrete State）：实现抽象状态定义的接口，并且在其中封装具体的行为
~~~java
public class ConcreteState implements State{
    @Override
    public void simpleOperation() {
        System.out.println("ConcreteState simpleOperation");
    }
}
~~~
3. 环境（Context）：定义客户端所感兴趣的接口，并且保存具体状态的对象，提供设置和返回具体状态的方法
~~~java
public class Context {

    private State state;

    public Context(State state)
    {
        this.state = state;
    }

    public void setState(State state){
        this.state = state;
    }

    public void simpleOperation(){
        state.simpleOperation();
    }

}
~~~

#### 5.9.3. 应用

### 5.10. 访问者（Visitor）模式

#### 5.10.1. 介绍

访问者模式（Visitor Pattern），是一种行为设计模式。在访问者模式中，我们通过一个抽象的访问者对象（Visitor）来封装一系列的对象（Element）所具有的行为，从而实现对象之间的松耦合。

#### 5.10.2. 结构

访问者模式包含以下角色：
1. 抽象访问者（Visitor）：定义一个接口，用以封装与抽象同事类的对话
~~~java
public interface Visitor {

    void visit(NodeA nodeA);

    void visit(NodeB nodeB);
}
~~~
2. 具体访问者（Concrete Visitor）：实现抽象访问者定义的接口，并且在其中封装具体的行为
~~~java
public class VisitorA implements Visitor{

    @Override
    public void visit(NodeA nodeA) {

    }

    @Override
    public void visit(NodeB nodeB) {

    }
}
public class VisitorB implements Visitor{

    @Override
    public void visit(NodeA nodeA) {

    }

    @Override
    public void visit(NodeB nodeB) {

    }
}
~~~
3. 抽象节点（Node）：定义一个接口，接收一个访问者对象作为参数
~~~java
public interface Node {

    void accept(Visitor visitor);

}
~~~
4. 具体节点（Concrete Node）：实现抽象节点定义的接口，并且在其中封装具体的行为
~~~java
public class NodeA implements Node{
    @Override
    public void accept(Visitor visitor) {
        operation();
    }

    public void operation()
    {
        System.out.println( "NodeA operation");
    }
}
public class NodeB implements Node{
    @Override
    public void accept(Visitor visitor) {
           operation();
    }

    public void operation()
    {
        System.out.println("NodeB operation");
    }
}
~~~
5. 结构对象（ObjectStructure）:可以遍历结构中的所有元素，如果需要可提供一个高层次的接口让访问者可以访问每一个元素
~~~java
public class ObjectStructure {

    private Node node;

    private Vector<Node> nodes;

    public ObjectStructure(){
        nodes = new Vector<>();
    }

    public void action(Visitor visitor){
        for (Node v : nodes){
            v.accept(visitor);
        }
    }

    public void add(Node node){
        nodes.add(node);
    }
}
~~~

#### 5.10.3. 应用
~~~
public class Client {

    public static void main(String[] args) {
        ObjectStructure objectStructure = new ObjectStructure();
        objectStructure.add(new NodeA());
        objectStructure.add(new NodeB());
        objectStructure.action(new VisitorA());
    }
}
~~~

### 5.11. 解释器（Interpreter）模式

#### 5.11.1. 介绍

解释器模式（Interpreter Pattern），也称文法分析模式，是一种行为设计模式。在解释器模式中，我们通过一个抽象的表达式对象（Expression）来封装一系列的对象（TerminalExpression）所具有的行为，从而实现对象之间的松耦合。

#### 5.11.2. 结构

解释器模式包含以下角色：
1. 抽象表达式（Abstract Expression）：定义解释器的接口，封装解释器的基本方法
~~~java
public abstract class Expression {

    /**
     * 以环境类为准，解释给定的任何一个表达式
     * @param context
     * @return
     */
    public abstract boolean interpret(Context context);


    /**
     * 判断两个对象是否相同
     * @param object
     * @return
     */
    public abstract boolean equals(Object object);

    /**
     * 返回表达式的哈希码
     * @return
     */
    public abstract int hashCode();

    /**
     * 返回表达式的字符串形式
     * @return
     */
    public abstract String toString();

}
~~~
2. 终结符表达式（Terminal Expression）：实现抽象表达式定义的接口，封装终结符表达式所具有的行为
~~~java
public class Variable extends Expression{

    private String name;

    public Variable(String name) {
        this.name = name;
    }

    @Override
    public boolean interpret(Context context) {
        return context.lookup(this);
    }

    @Override
    public boolean equals(Object object) {
        return (object != null &&
                (this.getClass() == object.getClass()) &&
                (name.equals(((Variable) object).name)));
    }

    @Override
    public String toString() {
        return name;
    }
}
public class Constant extends Expression{

    private boolean value;

    public Constant(boolean value) {
        this.value = value;
    }

    @Override
    public boolean interpret(Context context) {
        return value;
    }

    @Override
    public boolean equals(Object object) {
        return Objects.nonNull(object) && (object instanceof Constant) && (this.value == ((Constant) object).value);
    }

    @Override
    public String toString() {
        return new Boolean(value).toString();
    }
}
~~~
3. 非终结符表达式（Nonterminal Expression）：实现抽象表达式定义的接口，封装非终结符表达式所具有的行为
~~~java
public class And extends Expression{

    private Expression left;
    private Expression right;

    public And(Expression left, Expression right)
    {
        this.left = left;
        this.right = right;
    }

    @Override
    public boolean interpret(Context context) {
        return left.interpret(context) && right.interpret(context);
    }

    @Override
    public boolean equals(Object object) {
        if(Objects.nonNull(object) && (this.getClass() == object.getClass())){
            return left.equals(((And) object).left) && right.equals(((And) object).right);
        }
        return false;
    }

    @Override
    public String toString() {
        return "("+left.toString()+" and "+right.toString()+")";
    }

    public Expression getLeft() {
        return left;
    }

    public Expression getRight() {
        return right;
    }
}
public class Or extends And{

    public Or(Expression left, Expression right) {
        super(left, right);
    }

    @Override
    public boolean interpret(Context context) {
         return getLeft().interpret(context) || getRight().interpret(context);
    }

    @Override
    public String toString() {
    	return "(" + getLeft() + " or " + getRight() + ")";
    }

}
public class Not extends Expression{

    private Expression expression;

    public Not(Expression expression) {
        this.expression = expression;
    }

    @Override
    public boolean interpret(Context context) {
        return !expression.interpret(context);
    }

    @Override
    public boolean equals(Object object) {
        if(Objects.nonNull(object) && (this.getClass() == object.getClass())){
            return expression.equals(((Not) object).expression) ;
        }
        return false;
    }

    @Override
    public String toString() {
        return "Not("+expression.toString()+")";
    }
}
~~~
4. 客户端（Client）：创建环境对象，并调用其方法
~~~java
public class Client {
    public static void main(String[] args)
    {
        Context context = new Context();
        Variable x = new Variable("x");
        Variable y = new Variable("y");
        Constant c = new Constant(true);
        context.assign(x, false);
        context.assign(y, true);

        Expression expression = new Or(new And(x, y), c);

        System.out.println("x=" + x.interpret(context));
        System.out.println("y=" + y.interpret(context));
        System.out.println("c=" + c.interpret(context));
        System.out.println(expression.toString() + "=" +expression.interpret(context));

        Not not = new Not(expression);
        System.out.println(not.toString() + "=" + not.interpret(context));
    }


}
~~~
5. 环境对象（Context）：提供解释器之外的一些全局变量
~~~java
public class Context {

    private HashMap map = new HashMap();

    public void assign(Variable variable, boolean value){
        map.put(variable, new Boolean(value));
    }

    public boolean lookup(Variable variable){
        Object o = map.get(variable);
        if(Objects.nonNull(o)){
            return ((Boolean) o).booleanValue();
        }else{
            throw new RuntimeException();
        }

    }
}
~~~

#### 5.11.3. 应用

### 5.12. 调停者（Mediator）模式

#### 5.12.1. 介绍

调停者模式（Mediator Pattern），也称中介者模式，是一种行为设计模式。在调停者模式中，我们通过一个抽象的中介者对象（Mediator）来封装一系列的同事对象（Colleague）所具有的行为，从而实现对象之间的松耦合。

#### 5.12.2. 结构

调停者模式包含以下角色：

1. 抽象调停者（Mediator）：定义一个接口，用以封装与抽象同事类的对话
~~~java
public abstract class Mediator {

    public abstract void colleagueChanged(Colleague colleague);

}
~~~
2. 具体调停者（Concrete Mediator）：实现抽象调停者定义的接口，并且在其中封装具体的行为
~~~java
public class ConcreteMediator extends Mediator{

    private ColleagueA colleagueA;
    private ColleagueB colleagueB;

    public void crateColleagues()
    {
        colleagueA = new ColleagueA(this);
        colleagueB = new ColleagueB(this);
    }


    @Override
    public void colleagueChanged(Colleague colleague) {
        colleagueA.action();
        colleagueB.action();
    }
}
~~~
3. 抽象同事（Colleague）：定义一个接口，用以封装与调停者类的对话
~~~java
public abstract class Colleague {

    protected Mediator mediator;

    public Colleague(Mediator mediator)
    {
        this.mediator = mediator;
    }

    public Mediator getMediator() {
        return mediator;
    }

    public abstract void action();

    public void change(){
        mediator.colleagueChanged(this);
    }
}
~~~
4. 具体同事（Concrete Colleague）：实现抽象同事定义的接口，并且在其中封装具体的行为
~~~java
public class ColleagueA extends Colleague{

    public ColleagueA(Mediator mediator) {
        super(mediator);
    }

    @Override
    public void action() {
        System.out.println("ColleagueA action");
    }
}
public class ColleagueB extends Colleague{
    public ColleagueB(Mediator mediator) {
        super(mediator);
    }

    @Override
    public void action() {
        System.out.println("ColleagueB action");
    }
}
~~~

#### 5.12.3. 应用





