public class StringTest {
    public static void main(String[] args) {
        String s1 = "Anthony";
        String s2 = "Anthony";
        String s3 = new String("Muller");
        String s4 = new String("Muller");

        if (s1 == s2) {
            System.out.print("Anthony");
        }

        if (s3 == s4) {
            System.out.print("Muller");
        }
        byte b1 = 5;
        byte b2 = 10;
        byte a1 = b1 * b2;
        int a2 = b1 * b2;
        short a3 = b1 * b2;
        long a4 = b1 * b2;
        float a5 = b1 * b2;
        double a6 = b1 * b2;
    }
}