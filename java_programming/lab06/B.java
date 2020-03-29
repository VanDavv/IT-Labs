interface IA {
    int x = 1;
}

class A {
    int x = 2;
}

class B extends A implements IA {
    public static void main(String... args) {
        System.out.println(x);
    }
}