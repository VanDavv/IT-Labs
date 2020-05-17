package lab10.controllers;

import lab10.models.Dyrektor;
import lab10.models.Handlowiec;
import lab10.models.Pracownik;

import java.io.*;
import java.util.*;
import java.util.zip.*;

public class PracownikController {
    private List<Pracownik> pracownicy = new ArrayList<>();
    private Scanner in = new Scanner(System.in);

    public boolean checkIfExists(String pesel) {
        for (Pracownik pracownik : pracownicy) {
            if (pracownik.getPesel().equals(pesel)) {
                return true;
            }
        }
        return false;
    }

    public void createPracownik() {
        Pracownik pracownik;
        System.out.print("[D]yrektor/[H]andlowiec:      ");
        String type = in.nextLine();
        switch (type) {
            case "D": {
                pracownik = new Dyrektor();
                break;
            }
            case "H": {
                pracownik = new Handlowiec();
                break;
            }
            default: {
                System.err.println("Invalid choice!");
                return;
            }
        }
        System.out.println("------------------------------------------------------------------");
        System.out.print("Identyfikator PESEL          :     ");
        String pesel = in.nextLine();
        if(checkIfExists(pesel)) {
            System.err.println("Osoba o danym nr PESEL już jest w bazie!");
            return;
        }
        try {
            pracownik.setPesel(pesel);
        } catch (Exception e) {
            System.err.println("Podano nieprawidłowy PESEL");
            return;
        }
        System.out.print("Imię                         :     ");
        pracownik.setImie(in.nextLine());
        System.out.print("Nazwisko                     :     ");
        pracownik.setNazwisko(in.nextLine());
        System.out.print("Wynagrodzenie (zł)           :     ");
        pracownik.setWynagrodzenie(Float.parseFloat(in.nextLine()));
        System.out.print("Telefon służbowy numer       :     ");
        pracownik.setTelefon(in.nextLine());

        if(pracownik instanceof Dyrektor) {
            Dyrektor dyrektor = (Dyrektor) pracownik;
            System.out.print("Dodatek służbowy (zł)        :     ");
            dyrektor.setDodatek(Float.parseFloat(in.nextLine()));
            System.out.print("Karta służbowa numer         :     ");
            dyrektor.setKarta(in.nextLine());
            System.out.print("Limit kosztów/miesiąc (zł)   :     ");
            dyrektor.setLimitkosztow(Float.parseFloat(in.nextLine()));
        } else {
            Handlowiec handlowiec = (Handlowiec) pracownik;
            System.out.print("Prowizja %                   :     ");
            handlowiec.setProwizja(Float.parseFloat(in.nextLine()));
            System.out.print("Limit prowizji/miesiąc (zł)  :     ");
            handlowiec.setLimitprowizji(Float.parseFloat(in.nextLine()));
        }
        System.out.println("------------------------------------------------------------------");
        System.out.println("[ENTER] - potwierdź");
        System.out.println("[q] - porzuć");
        System.out.print("Wybór> ");
        String op = in.nextLine();
        if(op.equals("")) {
            pracownicy.add(pracownik);
        } else {
            System.out.println("Zmiany odrzucone");
        }
    }

    private void printPracownik(Pracownik pracownik) {
        System.out.println("Identyfikator PESEL          :     " + pracownik.getPesel());
        System.out.println("Imię                         :     " + pracownik.getImie());
        System.out.println("Nazwisko                     :     " + pracownik.getNazwisko());
        System.out.println("Wynagrodzenie (zł)           :     " + pracownik.getWynagrodzenie());
        System.out.println("Telefon służbowy numer       :     " + pracownik.getTelefon());

        if(pracownik instanceof Dyrektor) {
            Dyrektor dyrektor = (Dyrektor) pracownik;
            System.out.println("Stanowisko                   :     Dyrektor");
            System.out.println("Dodatek służbowy (zł)        :     " + dyrektor.getDodatek());
            System.out.println("Karta służbowa numer         :     " + dyrektor.getKarta());
            System.out.println("Limit kosztów/miesiąc (zł)   :     " + dyrektor.getLimitkosztow());
        } else {
            Handlowiec handlowiec = (Handlowiec) pracownik;
            System.out.println("Stanowisko                   :     Handlowiec");
            System.out.println("Prowizja %                   :     " + handlowiec.getProwizja());
            System.out.println("Limit prowizji/miesiąc (zł)  :     " + handlowiec.getLimitprowizji());
        }
    }

    public void listPracownicy() {
        ListIterator<Pracownik> it = pracownicy.listIterator();
        while(it.hasNext()){
            int index = it.nextIndex();
            Pracownik pracownik = it.next();
            printPracownik(pracownik);
            System.out.println(String.format("[Pozycja: %d/%d]", index + 1, pracownicy.size()));
            if(pracownicy.size() == (index + 1)) {
                return;
            }
            System.out.println("[ENTER] - następny");
            System.out.println("[q] - powrót");
            System.out.print("Wybór> ");
            String op = in.nextLine();
            if(!op.equals("")) {
                return;
            }
        }
    }

    public void removePracownik() {
        System.out.print("Podaj identyfikator PESEL    :     ");
        String pesel = in.nextLine();
        ListIterator<Pracownik> it = pracownicy.listIterator();
        while(it.hasNext()){
            Pracownik pracownik = it.next();
            if(pracownik.getPesel().equals(pesel)) {
                System.out.println("------------------------------------------------------------------");
                printPracownik(pracownik);
                System.out.println("------------------------------------------------------------------");
                System.out.println("[ENTER] - potwierdź");
                System.out.println("[q] - porzuć");
                System.out.print("Wybór> ");
                String op = in.nextLine();
                if(op.equals("")) {
                    it.remove();
                }
                return;
            }
        }
        System.err.println("Nie znaleziono pracownika o danym numerze PESEL");
    }

    public void dumpZip(String filename) {
        try {
            FileOutputStream fos = new FileOutputStream(filename);
            ZipOutputStream zipStream = new ZipOutputStream(fos);
            zipStream.putNextEntry(new ZipEntry("pracownicy"));
            ObjectOutputStream output = new ObjectOutputStream(zipStream);
            for (Pracownik pracownik : pracownicy) {
                output.writeObject(pracownik);
            }
            output.close();
            zipStream.close();
            fos.close();
        } catch (Exception e) {
            System.err.println("Saving failed!");
            e.printStackTrace();
        }
    }

    public void recreateZip(String filename) {
        try {
            FileInputStream fis = new FileInputStream(filename);
            ZipInputStream zis = new ZipInputStream(fis);
            zis.getNextEntry();
            ObjectInputStream input = new ObjectInputStream(zis);
            while(true) {
                try {
                    Pracownik pracownik = (Pracownik) input.readObject();
                    if (pracownik == null) {
                        break;
                    }
                    pracownicy.add(pracownik);
                } catch (EOFException e) {
                    break;
                }
            }
            zis.closeEntry();
            input.close();
            zis.close();
            fis.close();
        } catch (Exception e) {
            System.err.println("Restoring failed!");
            e.printStackTrace();
        }
    }

    public void dumpGzip(String filename) {
        try {
            FileOutputStream fos = new FileOutputStream(filename);
            GZIPOutputStream gos = new GZIPOutputStream(fos);
            ObjectOutputStream output = new ObjectOutputStream(gos);
            for (Pracownik pracownik : pracownicy) {
                output.writeObject(pracownik);
            }
            output.close();
            gos.close();
            fos.close();
        } catch (Exception e) {
            System.err.println("Saving failed!");
            e.printStackTrace();
        }
    }

    public void recreateGzip(String filename) {
        try {
            FileInputStream fis = new FileInputStream(filename);
            GZIPInputStream gis = new GZIPInputStream(fis);
            ObjectInputStream input = new ObjectInputStream(gis);
            while(true) {
                try {
                    Pracownik pracownik = (Pracownik) input.readObject();
                    if (pracownik == null) {
                        break;
                    }
                    pracownicy.add(pracownik);
                } catch (EOFException e) {
                    break;
                }
            }
            input.close();
            gis.close();
            fis.close();
        } catch (Exception e) {
            System.err.println("Restoring failed!");
            e.printStackTrace();
        }
    }

    private String getExtension(String filename) {
        String extension = "";

        int i = filename.lastIndexOf('.');
        int p = Math.max(filename.lastIndexOf('/'), filename.lastIndexOf('\\'));

        if (i > p) {
            extension = filename.substring(i+1);
        }
        return extension;
    }

    public void backup() {
        System.out.print("[Z]achowaj/[O]dtwórz     :     ");
        String op = in.nextLine();
        switch (op.toLowerCase()) {
            case "z":
                System.out.println("------------------------------------------------------------------");
                System.out.print("Nazwa pliku                :     ");
                String filename = in.nextLine();
                System.out.print("Kompresja [G]zip/[Z]ip     :     ");
                String op2 = in.nextLine();
                System.out.println("------------------------------------------------------------------");
                switch (op2.toLowerCase()) {
                    case "g":
                        dumpGzip(filename);
                        break;
                    case "z":
                        dumpZip(filename);
                        break;
                    default:
                        System.err.println("Invalid choice!");
                }
                break;
            case "o":
                System.out.println("------------------------------------------------------------------");
                System.out.print("Nazwa pliku                :     ");
                String inFilename = in.nextLine();
                String ext =  getExtension(inFilename);
                String op3 = "";
                if(ext.equals("zip")) {
                    op3 = "Z";
                } else if (ext.equals("gzip")) {
                    op3 = "G";
                } else {
                    System.out.print("Kompresja [G]zip/[Z]ip     :     ");
                    op3 = in.nextLine();
                }
                System.out.println("------------------------------------------------------------------");
                switch (op3.toLowerCase()) {
                    case "g":
                        recreateGzip(inFilename);
                        break;
                    case "z":
                        recreateZip(inFilename);
                        break;
                    default:
                        System.err.println("Invalid choice!");
                }
                break;
            default:
                System.err.println("Invalid choice!");
        }
    }
}
