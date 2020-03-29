import static java.lang.System.out;
import java.util.Scanner;
import java.util.NoSuchElementException;

public class Test {
    public static void main(String[] args) {
        try {
            Scanner scn = new Scanner(System.in);
        } catch (NoSuchElementException | IllegalStateException ex) {
            out.println(ex.getMessage());
        } catch (Throwable ex) {
            System.exit(0);
        }
    }
}