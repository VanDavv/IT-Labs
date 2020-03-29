public class Example {
    private static final instance = Example();

    private Example() {
    }

    public static Example getInstance() {
        return instance;
    }

    public void cutMaterial() {
        System.out.println("Cut Material");
    }
}