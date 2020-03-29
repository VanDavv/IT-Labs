public class Bird {
    Bird(String name) {
        System.out.println("Bird Name = " + name);
    }

    Bird() {
        this( "Starling" );
        System.out.println("Constructor Bird.class");
    }

    public static void main(String args[]) {
        Bird a = new Bird();
    }
}