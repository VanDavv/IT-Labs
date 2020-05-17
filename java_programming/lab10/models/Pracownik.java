package lab10.models;

import java.io.Serializable;

public class Pracownik implements Serializable {
    private static final long serialVersionUID = 1L;
    protected String pesel, imie, nazwisko, stanowisko, telefon;
    protected float wynagrodzenie;

    public boolean validatePesel(String numberPesel) {
        if (numberPesel.length() != 11) {
            return false;
        }

        int pierwszaCyfra = Integer.parseInt(numberPesel.substring(0, 1));
        int drugaCyfra = Integer.parseInt(numberPesel.substring(1, 2));
        int trzeciaCyfra = Integer.parseInt(numberPesel.substring(2, 3));
        int czwartaCyfra = Integer.parseInt(numberPesel.substring(3, 4));
        int piataCyfra = Integer.parseInt(numberPesel.substring(4, 5));
        int szostaCyfra = Integer.parseInt(numberPesel.substring(5, 6));
        int siodmaCyfra = Integer.parseInt(numberPesel.substring(6, 7));
        int osmaCyfra = Integer.parseInt(numberPesel.substring(7, 8));
        int dziewiataCyfra = Integer.parseInt(numberPesel.substring(8, 9));
        int dziesiataCyfra = Integer.parseInt(numberPesel.substring(9, 10));
        int jedenastaCyfra = Integer
                .parseInt(numberPesel.substring(10, 11));

        int check = pierwszaCyfra + 3 * drugaCyfra + 7 * trzeciaCyfra
                + 9 * czwartaCyfra + piataCyfra + 3 * szostaCyfra + 7
                * siodmaCyfra + 9 * osmaCyfra + dziewiataCyfra + 3
                * dziesiataCyfra;
        int lastNumber = check % 10;
        int controlNumber = 10 - lastNumber;

        return controlNumber == jedenastaCyfra;
    }

    public String getPesel() {
        return pesel;
    }

    public void setPesel(String pesel) throws Exception {
        if(validatePesel(pesel)) {
            this.pesel = pesel;
        } else {
            throw new Exception("PESEL niepoprawny");
        }
    }

    public String getImie() {
        return imie;
    }

    public void setImie(String imie) {
        this.imie = imie;
    }

    public String getNazwisko() {
        return nazwisko;
    }

    public void setNazwisko(String nazwisko) {
        this.nazwisko = nazwisko;
    }

    public String getStanowisko() {
        return stanowisko;
    }

    public void setStanowisko(String stanowisko) {
        this.stanowisko = stanowisko;
    }

    public String getTelefon() {
        return telefon;
    }

    public void setTelefon(String telefon) {
        this.telefon = telefon;
    }

    public float getWynagrodzenie() {
        return wynagrodzenie;
    }

    public void setWynagrodzenie(float wynagrodzenie) {
        this.wynagrodzenie = wynagrodzenie;
    }
}
