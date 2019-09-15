CREATE TABLE LINIE 
(
  NUMER_LINII NUMBER(3, 0) NOT NULL 
, TYP CHAR(1) NOT NULL 
, CONSTRAINT LINIE_PK PRIMARY KEY 
  (
    NUMER_LINII 
  )
  ENABLE 
);

CREATE TABLE PRZYSTANKI 
(
  NR_PRZYSTANKU NUMBER(3, 0) NOT NULL 
, NAZWA VARCHAR2(20) NOT NULL 
, CZY_NA_ZADANIE CHAR(1) NOT NULL 
, CONSTRAINT PRZYSTANKI_PK PRIMARY KEY 
  (
    NR_PRZYSTANKU 
  )
  ENABLE 
);

CREATE TABLE KIEROWCY 
(
  NR_KIEROWCY NUMBER(3, 0) NOT NULL 
, IMIE VARCHAR2(20) NOT NULL 
, NAZWISKO VARCHAR2(20) NOT NULL 
, PESEL CHAR(11) 
, NUMER_LINII NUMBER(3, 0) NOT NULL 
, CONSTRAINT KIEROWCY_PK PRIMARY KEY 
  (
    NR_KIEROWCY 
  )
  ENABLE 
);

CREATE TABLE ODCINKI_PRZYSTANKOW 
(
  PRZYSTANEK1 NUMBER(3, 0) NOT NULL 
, PRZYSTANEK2 NUMBER(3, 0) NOT NULL 
, ODLEGLOSC NUMBER(4, 0) 
, CONSTRAINT ODCINKI_PRZYSTANKOW_PK PRIMARY KEY 
  (
    PRZYSTANEK1 
  , PRZYSTANEK2 
  )
  ENABLE 
);

CREATE TABLE TRASY 
(
  NUMER_LINII NUMBER(3, 0) NOT NULL 
, NR_ODCINKA NUMBER(2, 0) NOT NULL 
, PRZYSTANEK1 NUMBER(3, 0) NOT NULL 
, PRZYSTANEK2 NUMBER(3, 0) NOT NULL 
, CONSTRAINT TRASY_PK PRIMARY KEY 
  (
    NUMER_LINII 
  , NR_ODCINKA 
  )
  ENABLE 
);

CREATE INDEX KIEROWCY_FK ON KIEROWCY (NUMER_LINII ASC);

CREATE INDEX ODCINKI_PRZYSTANKOW_FK ON ODCINKI_PRZYSTANKOW (PRZYSTANEK2 ASC);

CREATE INDEX TRASY_LINIE_FK ON TRASY (NUMER_LINII ASC);

CREATE INDEX TRASY_ODCINKI_FK ON TRASY (PRZYSTANEK1 ASC, PRZYSTANEK2 ASC);

ALTER TABLE KIEROWCY
ADD CONSTRAINT KIEROWCY_FK1 FOREIGN KEY
(
  NUMER_LINII 
)
REFERENCES LINIE
(
  NUMER_LINII 
)
ENABLE;

ALTER TABLE ODCINKI_PRZYSTANKOW
ADD CONSTRAINT ODCINKI_PRZYSTANKOW_FK1 FOREIGN KEY
(
  PRZYSTANEK1 
)
REFERENCES PRZYSTANKI
(
  NR_PRZYSTANKU 
)
ENABLE;

ALTER TABLE ODCINKI_PRZYSTANKOW
ADD CONSTRAINT ODCINKI_PRZYSTANKOW_FK2 FOREIGN KEY
(
  PRZYSTANEK2 
)
REFERENCES PRZYSTANKI
(
  NR_PRZYSTANKU 
)
ENABLE;

ALTER TABLE TRASY
ADD CONSTRAINT TRASY_FK1 FOREIGN KEY
(
  PRZYSTANEK1 
, PRZYSTANEK2 
)
REFERENCES ODCINKI_PRZYSTANKOW
(
  PRZYSTANEK1 
, PRZYSTANEK2 
)
ENABLE;

ALTER TABLE TRASY
ADD CONSTRAINT TRASY_FK2 FOREIGN KEY
(
  NUMER_LINII 
)
REFERENCES LINIE
(
  NUMER_LINII 
)
ENABLE;

ALTER TABLE LINIE
ADD CONSTRAINT LINIE_CHK1 CHECK 
(TYP IN ('Z', 'P', 'O', 'E', 'S', 'U', 'N'))
ENABLE;

ALTER TABLE ODCINKI_PRZYSTANKOW
ADD CONSTRAINT ODCINKI_PRZYSTANKOW_CHK1 CHECK 
(PRZYSTANEK1 <> PRZYSTANEK2)
ENABLE;

ALTER TABLE PRZYSTANKI
ADD CONSTRAINT PRZYSTANKI_CHK1 CHECK 
(CZY_NA_ZADANIE IN ('T', 'N'))
ENABLE;

CREATE SEQUENCE nr_kierow START WITH 1 MINVALUE 1 MAXVALUE 999;
CREATE SEQUENCE nr_przyst START WITH 1 MINVALUE 1 MAXVALUE 999;

INSERT INTO LINIE VALUES (505, 'Z');
INSERT INTO LINIE VALUES (410, 'Z');
INSERT INTO LINIE VALUES (300, 'P');
INSERT INTO LINIE VALUES (802, 'Z');
INSERT INTO LINIE VALUES (190, 'Z');
INSERT INTO LINIE VALUES (208, 'E');
INSERT INTO LINIE VALUES (999, 'E');
INSERT INTO LINIE VALUES (777, 'Z');
INSERT INTO LINIE VALUES (678, 'Z');
INSERT INTO LINIE VALUES (120, 'N');

INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'ARTUR', 'WOèNIAK', '83120425849', 505);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'MARCIN', 'KAMI—SKI', '73080915847', 410);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'KAMIL', 'WOLNY', '56010134789', 300);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'IRENEUSZ', 'KOWALSKI', '90030511849', 802);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'ADAM', 'HOJNY', '45041025849', 190);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'W£ODZIMIERZ', 'LEåNY', '77090202859', 208);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'MICHA£', 'SZATAN', '66060634867', 999);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'KONRAD', 'WOLNY', '83120425849', 777);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'PAWE£', 'CHOJECKI', '57090425584', 678);
INSERT INTO KIEROWCY VALUES (NR_KIEROW.NEXTVAL, 'PIOTR', 'NIEWIERNY', '60022900123', 120);

INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Plaskowicka', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Historyczna', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Lisicka', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Laskowa', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Gwiazdowa', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Al.Ujazdowskie', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Frankiewiczow', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Politechnika', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Okopy', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Polarna', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Morska', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Naroska', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Kazury', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Biegocka', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Huta', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Polna', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Uniwersytet', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Ubriecka', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Pokutna', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Klasztor', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Plac Trzech Krzyzy', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Pilecka', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Ursynow', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Biblioteka Narodowa', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Teatr', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Aktorska', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Metro Imielin', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Krolikarnia', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Bukowinska', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Ksiegarnia', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Rondo Daszynskiego', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Mokotow Poludniowy', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Konski Jar', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Sobotnia', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Szwecka', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Jar', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Lesna', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Bazowa', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Literacka', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Pokorna', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Bazylika', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Szkolna', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Przedszkolna', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Metro Kabaty', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Metro Natolin', 'T');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Metro Stoklosy', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Basen', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Sportowa', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Konca Swiata', 'N');
INSERT INTO PRZYSTANKI VALUES (NR_PRZYST.NEXTVAL, 'Baza Wojskowa', 'T');

CREATE OR REPLACE PROCEDURE odcinki_przystankow_generator
/* Procedura do generowania danych testowych do tabeli ODCINKI_PRZYSTANKOW */
IS
    /* IloúÊ krotek w tabeli PRZYSTANKI */
    ile INT;
    /* DugoúÊ odcinka */
    odl INT;
    /* Indeks w tablicy, ktÛry pokazuje na drugi przystanek w odcinku */
    nastepny INT;
    TYPE tablica IS TABLE OF PRZYSTANKI.NR_PRZYSTANKU%type;
    /* Tablica do przechowywania danych kolumny z tabeli PRZYSTANKI */
    x tablica;
BEGIN
    x := tablica();
    /* Wpisanie danych do tabeli x */
    SELECT COUNT(*) INTO ile FROM przystanki;
    x.extend(ile);
    SELECT nr_przystanku BULK COLLECT INTO x FROM przystanki;
    /* Wpisanie do tabeli ODCINKI_PRZYSTANKOW przystankÛw o indeksie w tabeli rÛønym o 1 */
    FOR I IN 1..ile LOOP
        /* Losowa odlegoúÊ miÍdzy przystankami */
        odl := dbms_random.VALUE(5, 20);
        odl := odl * 10;
        nastepny := I + 1;
        IF I = ile THEN nastepny := 1; END IF;
        INSERT INTO odcinki_przystankow VALUES(x(I), x(nastepny), odl);
    END LOOP;
    /* Wpisanie do tabeli ODCINKI_PRZYSTANKOW przystankÛw o indeksie w tabeli rÛønym o 2 */
    FOR I IN 1..ile LOOP
        /* Losowa odlegoúÊ miÍdzy przystankami */
        odl := dbms_random.VALUE(5, 20);
        odl := odl * 10;
        nastepny := I + 2;
        IF I = ile THEN nastepny := 2; END IF;
        IF I = ile - 1 THEN nastepny := 1; END IF;
        INSERT INTO odcinki_przystankow VALUES(x(I), x(nastepny), odl);
    END LOOP;
END;

EXEC ODCINKI_PRZYSTANKOW_GENERATOR;

CREATE OR REPLACE PROCEDURE trasy_generator
/* Procedura do generowania danych testowych do tabeli TRASY */
IS
    /* IloúÊ krotek w tabeli LINIE */
    ile_linii INT;
    /* IloúÊ krotek w tabeli ODCINKI_PRZYSTANKOW */
    ile_odcinkow INT;
    /* DlugoúÊ trasy linii w odcinkach 8 - 15 */
    dlugosc INT;
    TYPE tablica IS TABLE OF ODCINKI_PRZYSTANKOW%ROWTYPE;
    TYPE tablica_num IS TABLE OF LINIE.NUMER_LINII%TYPE;
    TYPE tablica_num2 IS TABLE OF ODCINKI_PRZYSTANKOW.PRZYSTANEK2%TYPE;
    /* Tablica do przechowywania krotek z tabeli ODCINKI_PRZYSTANKOW */
    x tablica;
    /* Tablica do przechowywania krotek z tabeli ODCINKI_PRZYSTANKOW */
    y tablica_num;
    /* Numer przystanku koÒcowego poprzedniego odcinka */
    poprzedni ODCINKI_PRZYSTANKOW.PRZYSTANEK2%TYPE;
    /* Tablica do przechowywania wszystkich moøliwych przystankÛw ktÛre laczy odcinek z poprzednim przystankiem w trasie */
    mozliwe tablica_num2;
    /* IloúÊ elementow w tablicy mozliwe */
    ile_m INT;
    /* Wybor elementu z tablicy mozliwe */
    wybor INT;
BEGIN
    x := tablica();
    y := tablica_num();
    mozliwe := tablica_num2();
    /* Zapis danych z tabeli LINIE */
    SELECT COUNT(*) INTO ile_linii FROM linie;
    y.extend(ile_linii);
    SELECT NUMER_LINII BULK COLLECT INTO y FROM linie;
    /* Zapis danych z tabeli ODCINKI_PRZYSTANKOW */
    SELECT COUNT(*) INTO ile_odcinkow FROM ODCINKI_PRZYSTANKOW;
    x.extend(ile_odcinkow);
    SELECT * BULK COLLECT INTO x FROM ODCINKI_PRZYSTANKOW;
    FOR I IN 1..ile_linii LOOP
        /* Wylosowanie liczby odcinkow z ktorych bÍdzie siÍ skadaÊ kaøda trasa */
        dlugosc := dbms_random.VALUE(8, 15);
        /* Pierwszy odcinek trasy. Kaøda trasa zaczyna siÍ innym odcinkiem */
        INSERT INTO TRASY VALUES(y(I), 1, x(I).PRZYSTANEK1, x(I).PRZYSTANEK2);
        poprzedni := x(I).PRZYSTANEK2;
        /* Dolaczenie pozostalych odcinkÛw do trasy */
        FOR J IN 2..dlugosc LOOP
            /* Zebranie wszystkich przystankÛw ktÛre moga byÊ nastÍpne na trasie */
            SELECT COUNT(*) INTO ile_m FROM ODCINKI_PRZYSTANKOW WHERE PRZYSTANEK1 = poprzedni;
            mozliwe.extend(ile_m);
            SELECT PRZYSTANEK2 BULK COLLECT INTO mozliwe FROM ODCINKI_PRZYSTANKOW WHERE PRZYSTANEK1 = poprzedni;
            /* Wybranie jednej z moøliwoúci */
            wybor := dbms_random.VALUE(1, ile_m);
            INSERT INTO TRASY VALUES(y(I), J, poprzedni, mozliwe(wybor));
            /* Przygotowanie wartoúci poprzedni do nastÍpnej iteracji */
            poprzedni := mozliwe(wybor);
        END LOOP;
    END LOOP;
END;

EXEC TRASY_GENERATOR;

COMMENT ON TABLE PRZYSTANKI IS 'Tablica przystankow';
COMMENT ON TABLE ODCINKI_PRZYSTANKOW IS 'Tablica odcinkow przystankow';
COMMENT ON TABLE TRASY IS 'Tablica zawierajaca informacje o trasie pojedynczej linii';
COMMENT ON TABLE KIEROWCY IS 'Tablica kierowcow autobusowych';
COMMENT ON TABLE LINIE IS 'Tablica linii autobusowych';
COMMENT ON COLUMN PRZYSTANKI.NR_PRZYSTANKU IS 'Numer przystanku';
COMMENT ON COLUMN PRZYSTANKI.NAZWA IS 'Nazwa przystanku';
COMMENT ON COLUMN PRZYSTANKI.CZY_NA_ZADANIE IS 'Informacja o tym, czy jest to przystanek na zadanie(T) czy nie(N)';
COMMENT ON COLUMN LINIE.NUMER_LINII IS 'Numer linii autobusowej';
COMMENT ON COLUMN LINIE.TYP IS 'Typ linii: zwykla(Z), pospieszna(P), ekspresowa(E), nocna(N)';
COMMENT ON COLUMN KIEROWCY.NR_KIEROWCY IS 'Numer kierowcy';
COMMENT ON COLUMN KIEROWCY.IMIE IS 'Imie kierowcy';
COMMENT ON COLUMN KIEROWCY.NAZWISKO IS 'Nazwisko kierowcy';
COMMENT ON COLUMN KIEROWCY.PESEL IS 'Pesel kierowcy';
COMMENT ON COLUMN KIEROWCY.NUMER_LINII IS 'Numer linii autobusowej do ktorej przypisany jest kierowca';
COMMENT ON COLUMN ODCINKI_PRZYSTANKOW.PRZYSTANEK1 IS 'Poczatkowy przystanek odcinka';
COMMENT ON COLUMN ODCINKI_PRZYSTANKOW.PRZYSTANEK2 IS 'Koncowy przystanek odcinka';
COMMENT ON COLUMN ODCINKI_PRZYSTANKOW.ODLEGLOSC IS 'Odleglosc miedzy przystankami';
COMMENT ON COLUMN TRASY.PRZYSTANEK1 IS 'Poczatkowy przystanek odcinka';
COMMENT ON COLUMN TRASY.PRZYSTANEK2 IS 'Koncowy przystanek odcinka';
COMMENT ON COLUMN TRASY.NUMER_LINII IS 'Numer linii autobusowej';
COMMENT ON COLUMN TRASY.NR_ODCINKA IS 'Numer odcinka na trasie okreslonej linii';

CREATE OR REPLACE TRIGGER TRASY_TEST
AFTER INSERT OR UPDATE OR DELETE ON TRASY
/* Trigger sprawdza, czy trasa sklada siÍ z polaczonych odcinkÛw. To znaczy, czy wartoúÊ PRZYSTANEK1 w danym odcinku 
   jest taka sama jak wartoúÊ PRZYSTANEK2 w poprzedzajacym odcinku */
DECLARE
    /* Kod blÍdu */
    my_error CONSTANT number := -20000;
    /* Typy do przechowywania tablic o danych typach */
    TYPE tablica IS TABLE OF TRASY%ROWTYPE;
    TYPE tablica_linii IS TABLE OF LINIE.NUMER_LINII%TYPE;
    /* IloúÊ odcinkÛw dla okreúlonej linii */
    ile INT;
    /* IloúÊ linii autobusowych */
    ile_linii INT;
    /* Tablice do pobrania danych z tabel: TRASY, LINIE */
    tab_trasy tablica;
    tab_linie tablica_linii;
    /* WartoúÊ ostatniego przystanku na sprawdzanej trasie */
    poprzedni TRASY.PRZYSTANEK2%TYPE;
BEGIN
    /* Pobranie danych z tabel LINIE */
    tab_linie := tablica_linii();
    SELECT COUNT(*) INTO ile_linii FROM linie;
    tab_linie.extend(ile_linii);
    SELECT NUMER_LINII BULK COLLECT INTO tab_linie FROM linie;
    /* Dla kaødej linii sprawdzany jest warunek */
    FOR I IN 1..ile_linii LOOP
        /* Pobranie danych dotyczacych trasy aktualnie sprawdzanej linii */
        tab_trasy := tablica();
        SELECT COUNT(*) INTO ile FROM TRASY WHERE NUMER_LINII = tab_linie(I) ORDER BY NR_ODCINKA ASC;
        tab_trasy.extend(ile);
        SELECT * BULK COLLECT INTO tab_trasy FROM TRASY WHERE NUMER_LINII = tab_linie(I) ORDER BY NR_ODCINKA ASC;
        /* Dla pierwszego odcinka nie sprawdzamy warunku, bo nie ma poprzedniego odcinka. Ustawiamy wartoúÊ poprzedni w celu
           sprawdzania warunku w nastÍpnym odcinku */
        poprzedni := tab_trasy(1).PRZYSTANEK2;
        /* Sprawdzamy warunek <AKTUALNY ODCINEK>.PRZYSTANEK1 != <POPRZEDNI ODCINEK>.PRZYSTANEK2 dla wszystkich pozostalych odcinkÛw */
        FOR J IN 2..ile LOOP
            IF tab_trasy(J).PRZYSTANEK1 != poprzedni THEN
                /* Jeúli warunek nie spelniony, to blad */
                RAISE_APPLICATION_ERROR( my_error, 'Trasa musi byÊ ciagiem polaczonych odcinkÛw!' );
            END IF;
            /* Ustawiamy poprzedni do nastÍpnej iteracji */
            poprzedni := tab_trasy(J).PRZYSTANEK2;
        END LOOP;
    END LOOP;
END;

CREATE OR REPLACE PROCEDURE startWWW(line in number) IS
-- Procedura wyúwietla liste przystankÛw na ktÛrych zatrzymuje siÍ linia podana w argumencie wejúciowym
BEGIN
-- Poczatkowe elementy dodane do dokumentu HTML
  HTP.HTMLOPEN;
  HTP.HEADOPEN;
  HTP.TITLE('Lista przystankow');
  HTP.HEADCLOSE;

  HTP.HEADER(1, 'Lista przystankÛw dla linii: ' || line);

  -- Wyúwietlenie wyniku w tabeli HTML
  HTP.TABLEOPEN;
  OWA_UTIL.CELLSPRINT('select nr_odcinka, nazwa from trasy, przystanki where numer_linii = ' || line || ' AND przystanki.NR_PRZYSTANKU = trasy.PRZYSTANEK1');
  HTP.TABLECLOSE;
-- KoÒcowe elementy dodane do dokumentu HTML
  HTP.BODYCLOSE;
  HTP.HTMLCLOSE;
END;


select
    XMLElement("linia",
        XMLAttributes(l.typ as "typ"),
        XMLElement("numer", numer_linii),
        XMLElement("przystanki",
            (select
                XMLAgg(
                    XMLElement("przystanek", nazwa )
                )
            from PRZYSTANKI p, TRASY t, ODCINKI_PRZYSTANKOW o
            where
            t.numer_linii=l.numer_linii AND t.PRZYSTANEK1 = o.PRZYSTANEK1 AND o.przystanek1 = P.NR_PRZYSTANKU)
        )
    ).getClobVal()
from linie l;