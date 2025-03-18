package race_conditions.Java_Example;

public class Counter {
    public int count = 0;
    
    public void increment() {
        // Read the current value, add one, and write it back.
        count = count + 1;
    }
}