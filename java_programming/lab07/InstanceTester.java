import java.util.*;

public class InstanceTester {
    public static <E> void tester(List<E> list) { //Line 1
        if (list instanceof ArrayList<Integer>) { //Line 2
            System.out.println("Test Successsful");
        }
    }

    public static void main(String... args) {
        List<String> str = new ArrayList<>(); //Line 3
        InstanceTester.tester(str);
    }
}