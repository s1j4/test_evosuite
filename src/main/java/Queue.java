import java.util.*;
public class Queue {
    private List<Integer> queue;

    public Queue() {
        queue = new ArrayList<Integer>();
    }

    public void enqueue(int num) {
        queue.add(num);
    }

    public int dequeue() {
        if (queue.isEmpty()) {
            throw new IllegalStateException("Queue is empty!");
        }
        return queue.remove(0);
    }

    public int peek() {
        if (queue.isEmpty()) {
            throw new IllegalStateException("Queue is empty!");
        }
        return queue.get(0);
    }

    public boolean isEmpty() {
        return queue.isEmpty();
    }
}
