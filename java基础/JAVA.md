# Native方法

## JNI 
* 首先要讲一下JNI。Java很好，使用的人很多、应用极 广，但是Java不是完美的。Java的不足体现在运行速度要比传统的C++慢上许多之外，还有Java无法直接访问到操作系统底层如硬件系统，为此 Java提供了JNI来实现对于底层的访问。JNI，Java Native Interface，它是Java的SDK一部分，JNI允许Java代码使用以其他语言编写的代码和代码库，本地程序中的函数也可以调用Java层的函 数，即JNI实现了Java和本地代码间的双向交互

## native 
* JDK开放给用户的源码中随处可见Native方法，被Native关键字声明的方法说明该方法不是以Java语言实现的，比如C。

# hashCode()

## hash

* 把任意长度的输入通过散列算法变换成固定长度的输出
* Hash算法也被称为散列算法，Hash算法虽然被称为算法，但实际上它更像是一种思想。Hash算法没有一个固定的公式，只要符合散列思想的算法都可以被称为是Hash算法

## hashCode()

* hashCode() 是在Object类中定义的，且它是一个native方法
~~~java
	public native int hashCode();
~~~
* hashCode总合同：
	* 只要在执行Java应用程序时多次在同一个对象上调用该方法， hashCode方法必须始终返回相同的整数，前提是修改了对象中equals比较中的信息。 该整数不需要从一个应用程序的执行到相同应用程序的另一个执行保持一致。
	* 如果根据equals(Object)方法两个对象相等，则在两个对象中的每个对象上调用hashCode方法必须产生相同的整数结果。
	* 不要求如果两个对象根据equals(java.lang.Object)方法不相等，那么在两个对象中的每个对象上调用hashCode方法必须产生不同的整数结果。 但是，程序员应该意识到，为不等对象生成不同的整数结果可能会提高哈希表的性能。

