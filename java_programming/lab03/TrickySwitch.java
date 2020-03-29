
public class TrickySwitch {
    enum Bound {LEFT, RIGHT, DOWN, UP};

    public static void main(String[] args) {
        Bound[] bounds = {Bound.LEFT, Bound.RIGHT, Bound.DOWN, Bound.UP};
        for (Bound bound: bounds) {
            switch (bound) {
                case LEFT:
                    DOWN:
                    System.out.println(bound);
                    break;
                case RIGHT:
                    UP:
                    System.out.println(bound);
                    break;
            }
        }
    }
}