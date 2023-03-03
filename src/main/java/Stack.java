import java.util.*;
public class Stack {
    private List<Integer> stack;

    public Stack() {
        stack = new ArrayList<Integer>();
    }

    public void push(int num) {
        stack.add(num);
    }

    public int pop() {
        if (stack.isEmpty()) {
            throw new IllegalStateException("Stack is empty!");
        }
        return stack.remove(stack.size() - 1);
    }

    public int peek() {
        if (stack.isEmpty()) {
            throw new IllegalStateException("Stack is empty!");
        }
        return stack.get(stack.size() - 1);
    }

    public boolean isEmpty() {
        return stack.isEmpty();
    }
}
