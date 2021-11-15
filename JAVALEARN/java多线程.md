# 多线程基础

## Hook线程

## 线程池原以及自定义线程池



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