import java.util.Random;

interface Figura {
    public void rysuj();
}

class Wielokat implements Figura {
    public void rysuj() {
        System.out.print("Wielokat.rysuj() -");
    }
}

class Elipsa implements Figura {
    public void rysuj() {
        System.out.print("Elipsa.rysuj() -");
    }
}

public class PolymorphismExample {
    public static void main(String[] args) {
        Random random = new Random();
        Figura[] figura = new Figura[9];
        for (int i = 0; i < figura.length; i++) {
            figura[i] = (random.nextInt(2) == 0) ? new Wielokat() : new Elipsa();
        }
        for (Figura f : figura) {
            if(f instanceof  Elipsa) {
                System.out.println("Mamy Elipse!");
            }
            if(f instanceof  Wielokat) {
                System.out.println("Mamy Wielokąt!");
            }
        }
    }
}