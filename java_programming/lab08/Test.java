package lab08;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

public class Test {
    public static String pullBytes(InputStream is, int count) throws IOException {
        is.mark(count);
        final StringBuilder sb = new StringBuilder();
        for (int i = 0; i < count; i++) sb.append((char) is.read());
        is.reset();
        is.skip(1);
        sb.append((char) is.read());
        return sb.toString();
    }

    public static void main(String... args) throws IOException {
        final Path path = Paths.get(".").normalize();
        System.out.println(path.toString());
        int count = 0;
        for (int i = 0; i < path.getNameCount(); ++i) {
            count++;
        }
        System.out.println(count);
    }
}