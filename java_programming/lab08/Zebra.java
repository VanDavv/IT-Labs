package lab08;

import java.io.*;

class Bird implements Serializable {
    protected transient String name = "Bridget";

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public Bird() {
        this.name = "Matt";
    }
}

public class Zebra extends Bird implements Serializable {
    {
        this.name = "Janette";
    }

    public Zebra() {
        this.name = "Daniel";
    }

    public static void main(String[] args) throws IOException, ClassNotFoundException {
        Zebra z1 = new Zebra();
        FileOutputStream fos = new FileOutputStream("student.ser");
        ObjectOutputStream oos = new ObjectOutputStream(fos);
        oos.writeObject(z1);
        oos.close();
        fos.close();
        FileInputStream fis = new FileInputStream("student.ser");
        ObjectInputStream ois = new ObjectInputStream(fis);
        Zebra z2 = (Zebra) ois.readObject();
        System.out.println(z1.name);
        System.out.println(z2.name);
    }
}
