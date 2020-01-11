<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">                                        
    <html>
      <head>
      </head>
      <body>
        <h2> 
            LISTA OSÓB
        </h2>
        <xsl:apply-templates/>
      </body>   
    </html>
  </xsl:template>
  
  <xsl:template match="lista_osob">                                        
    <table border="1px">
      <tr>
        <th>Imię</th>
        <th>Nazwisko</th>
        <th>Pesel</th>
        <th>Data urodzenia</th>
        <th>Płeć</th>
        <th>Numer telefonu</th>
        <th>Ulica</th>
        <th>Nr domu</th>
        <th>Nr mieszkania</th>
        <th>Kod pocztowy</th>
        <th>Miejscowość</th>
        <th>Wzrost</th>
        <th>Kolor oczu</th>
        <th>Zawód</th>
      </tr>
      <xsl:apply-templates select="osoba"/>
    </table>
  </xsl:template>

  <xsl:template match="osoba">                                        
    <tr>
        <xsl:apply-templates select="imie"/>
        <xsl:apply-templates select="nazwisko"/>
        <xsl:apply-templates select="pesel"/>
        <xsl:apply-templates select="data_urodzenia"/>
        <xsl:apply-templates select="plec"/>
        <xsl:apply-templates select="numer_telefonu"/>
        <xsl:apply-templates select="adres/ulica"/>
        <xsl:apply-templates select="adres/numer_domu"/>
        <xsl:apply-templates select="adres/numer_mieszkania"/>
        <xsl:apply-templates select="adres/kod_pocztowy"/>
        <xsl:apply-templates select="adres/miejscowosc"/>
        <xsl:apply-templates select="wzrost"/>
        <xsl:apply-templates select="kolor_oczu"/>
        <xsl:apply-templates select="zawod"/>
    </tr>
  </xsl:template>

  <xsl:template match="imie">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="nazwisko">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="pesel">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="data_urodzenia">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="plec">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="numer_telefonu">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="adres/ulica">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="adres/numer_domu">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="adres/numer_mieszkania">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="adres/kod_pocztowy">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="adres/miejscowosc">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="wzrost">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="kolor_oczu">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>

  <xsl:template match="zawod">                                        
    <td>
        <xsl:value-of select="."/>
    </td>
  </xsl:template>
        
</xsl:stylesheet>