<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format">


    <xsl:attribute-set name="border1">
        <xsl:attribute name="border">solid 0.1mm black</xsl:attribute>
    </xsl:attribute-set>


    <xsl:template match="/">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format">
            <fo:layout-master-set>
                <fo:simple-page-master master-name="A4" 
                                        page-width="297mm" 
                                        page-height="210mm" 
                                        margin-top="1cm"   
                                        margin-bottom="1cm"
                                        margin-left="1cm"  
                                        margin-right="1cm">
                    <fo:region-body   margin="3cm"/>
                    <fo:region-before extent="2cm"/>
                    <fo:region-after  extent="2cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>

            <fo:page-sequence master-reference="A4">
                <fo:static-content flow-name="xsl-region-before">
                    <fo:block text-align="center">
                        LISTA OSÓB
                    </fo:block>
                </fo:static-content>

                <fo:static-content flow-name="xsl-region-after">
                    <fo:block text-align="right">
                        <fo:page-number />
                    </fo:block>
                </fo:static-content>

                <fo:flow flow-name="xsl-region-body">
                    <xsl:apply-templates />
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="lista_osob">
        <fo:table table-layout="fixed" xsl:use-attribute-sets="border1">
            <fo:table-column column-width="20mm"/>
            <fo:table-column column-width="20mm"/>
            <fo:table-column column-width="27mm"/>
            <fo:table-column />
            <fo:table-column column-width="10mm"/>
            <fo:table-column />
            <fo:table-column />
            <fo:table-column column-width="15mm"/>
            <fo:table-column />
            <fo:table-column />

            <fo:table-header>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block font-weight="bold">Imię</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">Nazwisko</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">PESEL</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">Data urodzenia</fo:block>
                    </fo:table-cell>

                    <fo:table-cell>
                        <fo:block font-weight="bold">Płeć</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">Numer telefonu</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">Adres</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">Wzrost</fo:block>
                    </fo:table-cell>

                    <fo:table-cell xsl:use-attribute-sets="border1">
                        <fo:block font-weight="bold">Kolor oczu</fo:block>
                    </fo:table-cell>

                    <fo:table-cell >
                        <fo:block font-weight="bold">Zawód</fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-header>

            <fo:table-body>
                <xsl:apply-templates select="osoba" />
            </fo:table-body>
        </fo:table>
    </xsl:template>

    <xsl:template match="osoba">
        <fo:table-row>
            <xsl:apply-templates select="imie" />
            <xsl:apply-templates select="nazwisko" />
            <xsl:apply-templates select="pesel" />
            <xsl:apply-templates select="data_urodzenia" />
            <xsl:apply-templates select="plec" />
            <xsl:apply-templates select="numer_telefonu" />
            <xsl:apply-templates select="adres" />
            <xsl:apply-templates select="wzrost" />
            <xsl:apply-templates select="kolor_oczu" />
            <xsl:apply-templates select="zawod" />
        </fo:table-row>
    </xsl:template>

    <xsl:template match="imie">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="nazwisko">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="pesel">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="data_urodzenia">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="plec">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="numer_telefonu">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="adres">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="wzrost">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="kolor_oczu">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

    <xsl:template match="zawod">
        <fo:table-cell xsl:use-attribute-sets="border1">
            <fo:block>
                <xsl:value-of select="." />
            </fo:block>
        </fo:table-cell>
    </xsl:template>

</xsl:stylesheet>
