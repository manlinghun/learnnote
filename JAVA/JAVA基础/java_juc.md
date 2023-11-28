# java JUC

## 概念

JUC是java.util.concurrent包的简称，在Java5.0添加，目的就是为了更好的支持高并发任务。让开发者进行多线程编程时减少竞争条件和死锁的问题！

## 组成部分

 主要包含：tools(工具类)、executor(执行者)、atomic(原子性包)、locks（锁包）、collections(集合类)

### tools

#### CountDownLatch

允许一个或者多个线程等待直到在其他线程中执行的一组操作完成的同步辅助

~~~java

public class CountDownLatchDemo {

    public static void main(String[] args) throws Exception {
        CountDownLatch latch = new CountDownLatch(6);
        IntStream.range(0, 6).forEach(i -> {
            new Thread(() -> {
                Double v = Math.random() * 10;
                try {
                    TimeUnit.SECONDS.sleep(v.intValue());
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.out.println(Thread.currentThread().getName() + "----execute. ");
                latch.countDown();
            }).start();
        });
        latch.await();
        System.out.println("----------all is over");
    }

}

~~~

#### CyclicBarrier

允许一组线程全部等待彼此达到共同屏障点的同步辅助


~~~java
public class CyclicBarrierDemo {
    public static void main(String[] args) {
        int threadNum = 6;
        CyclicBarrier cyclicBarrier = new CyclicBarrier(threadNum, () -> {
            System.out.println("-===========");
        });
        for (int i = 0; i < threadNum; i++) {
            new Thread(() -> {
                System.out.println(Thread.currentThread().getName() + " start ");
                Double v = Math.random() * 10;
                try {
                    TimeUnit.SECONDS.sleep(v.intValue());
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.out.println(Thread.currentThread().getName() + " execute end ");
                try {
                    cyclicBarrier.await();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                } catch (BrokenBarrierException e) {
                    throw new RuntimeException(e);
                }
                System.out.println(Thread.currentThread().getName() + " end ");
            }, "thread-" + i).start();
        }
    }
}
~~~


#### Semaphore

* 计数信号量。从概念上讲，信号量维护一组许可。在获得许可之前，如果有必要，每个区块都将获得许可，然后将其获取。每次释放都会增加一个许可证，可能会释放一个阻塞的收购方。但是，没有使用实际的许可证对象;信号量只是保留可用数量的计数，并相应地进行操作。
* 信号量通常用于限制可以访问某些(物理或逻辑)资源的线程数量。

~~~java

public class SemaphoreDemo {
    public static void main(String[] args) {
        int threadNum = 20;
        Semaphore semaphore = new Semaphore(4);
        for (int i = 0; i < threadNum; i++) {
            new Thread(()->{
                try {
                    semaphore.acquire();
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                System.out.println(Thread.currentThread().getName()+"----------acquire semaphore");
                Double v = Math.random() * 10;
                try {
                    TimeUnit.SECONDS.sleep(v.intValue());
                } catch (InterruptedException e) {
                    throw new RuntimeException(e);
                }
                semaphore.release();
                System.out.println(Thread.currentThread().getName()+" ----------release semaphore");
            }).start();
        }
    }
}

~~~

### executor

#### ScheduledExecutorService 

#### ScheduledThreadPoolExecutor


### atomic

AtomicBoolean、AtomicInteger、AtomicIntegerArray

### locks


#### ReadWriteLock


~~~java
public class ReadWriteLockDemo {

    public static void main(String[] args) {
        OneMap oneMap = new OneMap();
        for (int i = 0; i < 5; i++) {
            oneMap.put(""+i,i);
        }
        for (int i = 0; i < 5; i++) {
            final int index= i;
            new Thread(()->{
                System.out.println(oneMap.get(""+index));
            }).start();

        }
    }
}

class OneMap {
    Map<String, Object> map = new HashMap();

    ReadWriteLock lock = new ReentrantReadWriteLock();

    public Object get(String key) {
        Object result = null;
        lock.readLock().lock();
        try {
            Double v = Math.random() * 2;
            TimeUnit.SECONDS.sleep(v.intValue());
            result = map.get(key);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            lock.readLock().unlock();
        }
        return result;
    }

    public void put(String key,Object value) {
        lock.writeLock().lock();
        try {
            Double v = Math.random() * 2;
            TimeUnit.SECONDS.sleep(v.intValue());
            map.put(key,value);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            lock.writeLock().unlock();
        }
    }

}



~~~



### collections

1. CopyOnWriteArrayList
2. CopyOnWriteArraySet
3. ConcurrentHashMap