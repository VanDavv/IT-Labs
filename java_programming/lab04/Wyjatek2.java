public class Wyjatek2 {
    public static void main(String... args) {
        int d, a;
        System.out.println("Start");
        try {
            d = 0;
            a = 42 / d;
            System.out.println("Nieosiągalne");
        } catch (ArithmeticException e) {
            System.out.println("Wyjatek: " + e);
        }
    }
}