package lab10;

import lab10.controllers.PracownikController;

import java.util.Scanner;

public class Main {
    public static void main(String... args) {
        PracownikController controller = new PracownikController();
        String text = "MENU\n" +
                "    1. Lista pracowników\n" +
                "    2. Dodaj pracownika\n" +
                "    3. Usuń pracownika\n" +
                "    4. Kopia zapasowa\n" +
                "    5. Wyjdź";
        Scanner scan = new Scanner(System.in);
        String op;
        do {
            System.out.println(text);
            System.out.print("Wybór> ");
            op = scan.nextLine();
            switch (op) {
                case "1":
                    controller.listPracownicy();
                    break;
                case "2":
                    controller.createPracownik();
                    break;
                case "3":
                    controller.removePracownik();
                    break;
                case "4":
                    controller.backup();
                    break;
                case "5":
                    break;
                default:
                    System.err.println("Your choice is invalid, please try again");
            }
        }
        while (!op.equals("5"));
    }
}
