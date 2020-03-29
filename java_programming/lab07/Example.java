public class Example {
    public <T extends Number> Example(T obj) {
        System.out.println(obj.getClass().getName());
    }

    public <K extends Comparable, R extends Comparable> Example(K a, R b) {
        if(a.compareTo(b) == 1) {
            System.out.println("większe");
        } else {
            System.out.println("nie-większe");
        }
    }
}