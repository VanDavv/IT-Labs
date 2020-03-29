class Man {
    String name;
    int id;

    public Man() {
        System.out.println("1");
    }
}

class Employee extends Man {
    String title;

    {
        System.out.println("4");
    }

    static {
        System.out.println("2");
    }

    public Employee() {
        System.out.println("3");
    }
}

public class TestOrder {
    public static void main(String[] args) {
        Employee obj = new Employee();
    }
}