
import java.util.Arrays;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        outer:
        for (int i = 0; i < 100; i++) {
            inner:
            for (int j = 0; j < 100; j++) {
                if (j == 50) {
                    continue outer;
                }
            }
        }
    }
}