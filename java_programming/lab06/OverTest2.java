public class OverTest {
    public int add(int a, int b) {
        return a + b;
    }

    public static long add2(long a, long b) {
        return a + b;
    }
}

public class OverTest2 extends OverTest {
    @Override
    public int add(int a, int b) {
        return a - b;
    }

    public static long add2(long a, long b) {
        return a - b;
    }
}