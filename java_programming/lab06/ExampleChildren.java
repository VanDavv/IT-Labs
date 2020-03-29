public abstract class Example {
    public abstract void transform();
}

class ExampleChildOne extends Example {
    public void transform() {
        System.out.println("Transform in ExampleChildOne");
    }
}

class ExampleChildTwo extends Example {
    public void transform() {
        System.out.println("Transform in ExampleChildTwo");
    }
}