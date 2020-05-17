package models;

public class Handlowiec extends Pracownik {
    private float prowizja, limitprowizji;

    public float getProwizja() {
        return prowizja;
    }

    public void setProwizja(float prowizja) {
        this.prowizja = prowizja;
    }

    public float getLimitprowizji() {
        return limitprowizji;
    }

    public void setLimitprowizji(float limitprowizji) {
        this.limitprowizji = limitprowizji;
    }
}
