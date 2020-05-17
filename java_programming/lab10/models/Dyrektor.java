package lab10.models;

public class Dyrektor extends Pracownik {
    private String karta;
    private float dodatek, limitkosztow;

    public String getKarta() {
        return karta;
    }

    public void setKarta(String karta) {
        this.karta = karta;
    }

    public float getDodatek() {
        return dodatek;
    }

    public void setDodatek(float dodatek) {
        this.dodatek = dodatek;
    }

    public float getLimitkosztow() {
        return limitkosztow;
    }

    public void setLimitkosztow(float limitkosztow) {
        this.limitkosztow = limitkosztow;
    }
}