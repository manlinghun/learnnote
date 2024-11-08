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

### 4.1. 适配器模式

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


### 4.2. 缺省模式

### 4.3. 合成模式

### 4.4. 装饰模式

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

### 4.5. 代理模式

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


### 4.6. 享元模式

### 4.7. 门面模式

### 4.8. 桥接模式

#### 4.8.1. 介绍

桥接模式（Bridge Pattern）是把抽象（抽象类）与实现（接口）分离，使它们可以独立变化。

#### 4.8.2. 结构

1. 抽象化角色（Abstraction）给出抽象接口，并保留对实现化对象的引用。

2. 修正抽象化角色的子类，实现抽象化角色的接口，以便扩展更多功能。

3. 实现化角色（Implementor）定义实现化角色的接口，供扩展使用。

4. 扩展实现化角色的子类，实现实现化角色接口，以便扩展更多功能。

#### 4.8.3. 应用


## 5. 行为模式

### 5.1. 不变模式

### 5.2. ~~策略模式~~
