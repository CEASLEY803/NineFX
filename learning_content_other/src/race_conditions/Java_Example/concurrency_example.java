package race_conditions.Java_Example;

public class concurrency_example {
    public static void main(String[] args) throws InterruptedException {
        Counter counter = new Counter();
        
        // Create two threads that both increment the counter
        Thread t1 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });
        
        Thread t2 = new Thread(() -> {
            for (int i = 0; i < 1000; i++) {
                counter.increment();
            }
        });
        
        t1.start();
        t2.start();
        t1.join();
        t2.join();
        
        // Expected result: 2000, but due to race conditions, result may be less.
        System.out.println("Final count: " + counter.count);
    }
}
