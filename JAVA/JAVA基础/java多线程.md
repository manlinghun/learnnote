# 多线程基础

## 线程生命周期
1. 线程的NEW状态
2. 线程的RUNNABLE状态
3. 线程的RUNNING状态
4. 线程的BLOCKING状态
5. 线程的TERMINATED状态

## 线程启动
1. 调用start方法，start方法调用run方法，体现了模板设计模式在Thread中的使用

## Hook线程

## 线程池原以及自定义线程池
### 线程池原理
* 一个线程池应具备一下要素
1. 任务队列，用于缓存提交的任务
2. 线程数量管理，一个线程池必须能够很好的管理和控制线程数量，可通过如下三个条件来实现，比如：
    * 创建线程池时初始的线程数量init；
    * 线程池自动扩充时的最大线程数量max；
    * 在线程池空闲时需要释放线程但是也要维护一定数量的活跃数量或者核心数量core
有了这三个参数，就能够很好地控制线程池中的线程数量，将其维护在一个合理的范围内，三者之间的关系是init<=core<=max
3. 任务拒绝策略：如果线程数量已达到上限且任务队列已满，则需要有相应的拒绝策略来通知任务提交者
4. 线程工厂：用于个性化定制线程，比如线程设置为守护线程或者定义线程名称等
5. QueueSize: 任务队列主要用于存放提交的Runable，但是为了防止内存溢出，需要有limit数量对其进行控制
6. Keepedalive时间：该时间主要决定线程各个重要参数自动维护的时间间隔


# 多线程设计架构模式

## 监控任务的生命周期
1. 利用观察者模式，监控任务的生命周期
    1. 定义Task接口，执行任务的接口
    ~~~ java
    public interface Task<T> {
        T call();
    }
    ~~~
    2. 定义Observable接口，观察者接口
    ~~~ java
    public interface Observable {
        // 任务生命周期的定义：开始，运行中、结束、异常
        enum Cycle{
            STARTED,RUNNING,DONE,ERROR
        }
        // 获取生命周期
        Cycle getCycle();
        // 开始运行
        void start();
        // 中断
        void interrupt();
    }
    ~~~
    3. 定义TaskLifecycle接口，定义线程生命周期状态更新的回调接口，并提供一个默认的回调类
    ~~~java
    public interface TaskLifecycle<T> {
        //开始
        void onStart(Thread thread);
        //运行中
        void onRunning(Thread thread);
        //结束
        void onFinish(Thread thread,T result);
        //异常
        void onError(Thread thread,Exception e);
    
        class EmptyLifecycle<T> implements TaskLifecycle<T>{
    
            @Override
            public void onStart(Thread thread) {
    
            }
    
            @Override
            public void onRunning(Thread thread) {
    
            }
    
            @Override
            public void onFinish(Thread thread, T result) {
    
            }
    
            @Override
            public void onError(Thread thread, Exception e) {
    
            }
        }
    
    }
    ~~~
    4. 定义ObservableThread类，继承Thread类并实现Observable接口
    ~~~ java
    public class ObservableThread<T> extends Thread implements Observable {
    
        private final TaskLifecycle<T> lifecycle;
    
        private final Task<T> task;
    
        private Cycle cycle;
    
        public ObservableThread(Task<T> task) {
            this(new TaskLifecycle.EmptyLifecycle<>(),task);
        }
    
        public ObservableThread(TaskLifecycle<T> lifecycle, Task<T> task) {
            super();
            if(task == null){
                throw new IllegalArgumentException("The task is required.");
            }
            this.lifecycle = lifecycle;
            this.task = task;
        }
    
        @Override
        public final void run() {
            this.update(Cycle.STARTED,null,null);
            try{
                this.update(Cycle.RUNNING,null,null);
                T result = this.task.call();
                this.update(Cycle.DONE,result,null);
            }catch (Exception e){
                this.update(Cycle.DONE,null,e);
            }
        }
    
        private void update(Cycle cycle,T result,Exception e){
            this.cycle = cycle;
            if(lifecycle == null){
                return;
            }
            try{
                switch (cycle){
                    case STARTED:
                        this.lifecycle.onStart(currentThread());
                        break;
                    case RUNNING:
                        this.lifecycle.onRunning(currentThread());
                        break;
                    case DONE:
                        this.lifecycle.onFinish(currentThread(),result);
                        break;
                    case ERROR:
                        this.lifecycle.onError(currentThread(),e);
                        break;
                }
            }catch (Exception ex){
                if(cycle == Cycle.ERROR){
                    throw ex;
                }
            }
        }
    
        @Override
        public Cycle getCycle() {
            return this.cycle;
        }
    }
    ~~~
    5. 测试
    
    ~~~java
    public class RunMain {
    
        public static void main(String[] args) {
    
            final TaskLifecycle<String> lifecycle = new TaskLifecycle<String>() {
                @Override
                public void onStart(Thread thread) {
                    System.out.println("the thread is started!!!");
                }
    
                @Override
                public void onRunning(Thread thread) {
                    System.out.println("the thread is running!!!");
                }
    
                @Override
                public void onFinish(Thread thread, String result) {
                    System.out.println("The thread is finish and result is : "+result);
                }
    
                @Override
                public void onError(Thread thread, Exception e) {
                    System.out.println(" The result is error "+e.getMessage());
                }
            };
            Observable observable = new ObservableThread<String>(lifecycle,() -> {
                try {
                    TimeUnit.SECONDS.sleep(2);
                } catch (Exception e) {
                    e.printStackTrace();
                }
                System.out.println(" finish done. ");
                return "dsdsadasdsada";
            });
            observable.start();
        }
    }
    ~~~
    6. 执行结果如下：
    ~~~
    the thread is started!!!
    the thread is running!!!
    finish done. 
    The thread is finish and result is : dsdsadasdsada
    ~~~