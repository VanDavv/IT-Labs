class Base {
    void methodA() {
        System.out.println("base - MethodA");
    }
}

public class Sub extends Base {
    public void methodA() {
        System.out.println("sub -vMethodA");
    }

    public void methodB() {
        System.out.println("sub -bMethodB");
    }

    public static void main(String args[]) {
        Base b = new Sub();
        b.methodA();
        b.methodB();
    }
}