CREATE TABLE Stanowisko (
    ID NUMBER PRIMARY KEY,
    Nazwa VARCHAR2(50) NOT NULL);
CREATE TABLE StatusRezerwacji (
    ID NUMBER PRIMARY KEY,
    Nazwa VARCHAR2(50) NOT NULL);
CREATE TABLE Dostawca (
    ID NUMBER PRIMARY KEY,
    Nazwa VARCHAR2(50) NOT NULL);
CREATE TABLE Adres (
    ID NUMBER PRIMARY KEY,
    Nazwa VARCHAR2(100) NOT NULL);
CREATE TABLE Usluga (
    ID NUMBER PRIMARY KEY,
    Nazwa VARCHAR2(100) NOT NULL,
    Czas_Trwania_min NUMBER NOT NULL);
CREATE TABLE Pracownik (
    ID NUMBER PRIMARY KEY,
    Imie VARCHAR2(50) NOT NULL,
    Nazwisko VARCHAR2(50) NOT NULL,
    Stanowisko_ID NUMBER NOT NULL,
    FOREIGN KEY (Stanowisko_ID) REFERENCES Stanowisko(ID));
CREATE TABLE Klient (
    ID NUMBER PRIMARY KEY,
    Imie VARCHAR2(50) NOT NULL,
    Nazwisko VARCHAR2(50) NOT NULL,
    Telefon VARCHAR2(15) UNIQUE,
    Adres_ID NUMBER NOT NULL,
    FOREIGN KEY (Adres_ID) REFERENCES Adres(ID));
CREATE TABLE Produkt (
    ID NUMBER PRIMARY KEY,
    Nazwa VARCHAR2(100) NOT NULL,
    StanMagazynowy NUMBER NOT NULL,
    Dostawca_ID NUMBER NOT NULL,
    FOREIGN KEY (Dostawca_ID) REFERENCES Dostawca(ID));
CREATE TABLE Cennik (
    ID NUMBER PRIMARY KEY,
    Cena NUMBER(6,2) NOT NULL,
    Pracownik_ID NUMBER NOT NULL,
    Usluga_ID NUMBER NOT NULL,
    FOREIGN KEY (Pracownik_ID) REFERENCES Pracownik(ID),
    FOREIGN KEY (Usluga_ID) REFERENCES Usluga(ID));
CREATE TABLE Rezerwacja (
    ID NUMBER PRIMARY KEY,
    Data DATE NOT NULL,
    Godzina NUMBER NOT NULL,
    Klient_ID NUMBER NOT NULL,
    StatusRezerwacji_ID NUMBER NOT NULL,
    FOREIGN KEY (Klient_ID) REFERENCES Klient(ID),
    FOREIGN KEY (StatusRezerwacji_ID) REFERENCES StatusRezerwacji(ID));
CREATE TABLE Rezerwacja_Usluga (
    ID NUMBER PRIMARY KEY,
    Rezerwacja_ID NUMBER NOT NULL,
    Usluga_ID NUMBER NOT NULL,
    FOREIGN KEY (Rezerwacja_ID) REFERENCES Rezerwacja(ID),
    FOREIGN KEY (Usluga_ID) REFERENCES Usluga(ID));
CREATE TABLE Produkt_Rezerwacja (
    ID NUMBER PRIMARY KEY,
    Ilosc NUMBER NOT NULL,
    Produkt_ID NUMBER NOT NULL,
    Rezerwacja_ID NUMBER NOT NULL,
    FOREIGN KEY (Produkt_ID) REFERENCES Produkt(ID),
    FOREIGN KEY (Rezerwacja_ID) REFERENCES Rezerwacja(ID)
);
INSERT INTO Stanowisko (ID, Nazwa) VALUES (1, 'Fryzjer Stylista');
INSERT INTO Stanowisko (ID, Nazwa) VALUES (2, 'Kosmetyczka');
INSERT INTO Stanowisko (ID, Nazwa) VALUES (3, 'Manicurzystka');
INSERT INTO Stanowisko (ID, Nazwa) VALUES (4, 'Recepcjonista');
INSERT INTO Stanowisko (ID, Nazwa) VALUES (5, 'Masazysta');

INSERT INTO StatusRezerwacji (ID, Nazwa) VALUES (1, 'Oczekujaca');
INSERT INTO StatusRezerwacji (ID, Nazwa) VALUES (2, 'Zrealizowana');
INSERT INTO StatusRezerwacji (ID, Nazwa) VALUES (3, 'Anulowana');
INSERT INTO StatusRezerwacji (ID, Nazwa) VALUES (4, 'W trakcie');
INSERT INTO StatusRezerwacji (ID, Nazwa) VALUES (5, 'Nieobecnosc');

INSERT INTO Dostawca (ID, Nazwa) VALUES (1, 'Loreal Hurtownia');
INSERT INTO Dostawca (ID, Nazwa) VALUES (2, 'Neonail Supplies');
INSERT INTO Dostawca (ID, Nazwa) VALUES (3, 'SkinCare Pro');
INSERT INTO Dostawca (ID, Nazwa) VALUES (4, 'Wella Professionals');
INSERT INTO Dostawca (ID, Nazwa) VALUES (5, 'Ziaja Med');

INSERT INTO Adres (ID, Nazwa) VALUES (1, 'Warszawa, ul. Zlota 44');
INSERT INTO Adres (ID, Nazwa) VALUES (2, 'Warszawa, ul. Koszykowa 86');
INSERT INTO Adres (ID, Nazwa) VALUES (3, 'Krakow, ul. Florianska 12');
INSERT INTO Adres (ID, Nazwa) VALUES (4, 'Warszawa, ul. Marszalkowska 10');
INSERT INTO Adres (ID, Nazwa) VALUES (5, 'Wroclaw, ul. Rynek 5');

INSERT INTO Usluga (ID, Nazwa, Czas_Trwania_min) VALUES (1, 'Strzyzenie meskie', 45);
INSERT INTO Usluga (ID, Nazwa, Czas_Trwania_min) VALUES (2, 'Manicure hybrydowy', 90);
INSERT INTO Usluga (ID, Nazwa, Czas_Trwania_min) VALUES (3, 'Oczyszczanie twarzy', 60);
INSERT INTO Usluga (ID, Nazwa, Czas_Trwania_min) VALUES (4, 'Masaz relaksacyjny', 60);
INSERT INTO Usluga (ID, Nazwa, Czas_Trwania_min) VALUES (5, 'Koloryzacja wlosow', 120);

INSERT INTO Pracownik (ID, Imie, Nazwisko, Stanowisko_ID) VALUES (1, 'Anna', 'Kowalska', 1);
INSERT INTO Pracownik (ID, Imie, Nazwisko, Stanowisko_ID) VALUES (2, 'Piotr', 'Nowak', 2);
INSERT INTO Pracownik (ID, Imie, Nazwisko, Stanowisko_ID) VALUES (3, 'Katarzyna', 'Wisniewska', 3);
INSERT INTO Pracownik (ID, Imie, Nazwisko, Stanowisko_ID) VALUES (4, 'Marek', 'Kaminski', 4);
INSERT INTO Pracownik (ID, Imie, Nazwisko, Stanowisko_ID) VALUES (5, 'Julia', 'Wojcik', 5);

INSERT INTO Klient (ID, Imie, Nazwisko, Telefon, Adres_ID) VALUES (1, 'Jan', 'Kowalski', '48111222333', 1);
INSERT INTO Klient (ID, Imie, Nazwisko, Telefon, Adres_ID) VALUES (2, 'Maria', 'Dabrowska', '48999888777', 2);
INSERT INTO Klient (ID, Imie, Nazwisko, Telefon, Adres_ID) VALUES (3, 'Adam', 'Zielinski', '48555444333', 3);
INSERT INTO Klient (ID, Imie, Nazwisko, Telefon, Adres_ID) VALUES (4, 'Ewa', 'Szymanska', '48777666555', 4);
INSERT INTO Klient (ID, Imie, Nazwisko, Telefon, Adres_ID) VALUES (5, 'Michal', 'Lewandowski', '48123123123', 5);

INSERT INTO Produkt (ID, Nazwa, StanMagazynowy, Dostawca_ID) VALUES (1, 'Szampon Loreal 1L', 10, 1);
INSERT INTO Produkt (ID, Nazwa, StanMagazynowy, Dostawca_ID) VALUES (2, 'Lakier hybrydowy Red', 15, 2);
INSERT INTO Produkt (ID, Nazwa, StanMagazynowy, Dostawca_ID) VALUES (3, 'Maska algowa', 5, 3);
INSERT INTO Produkt (ID, Nazwa, StanMagazynowy, Dostawca_ID) VALUES (4, 'Farba Wella 8.0', 20, 4);
INSERT INTO Produkt (ID, Nazwa, StanMagazynowy, Dostawca_ID) VALUES (5, 'Krem do twarzy Ziaja', 12, 5);

INSERT INTO Cennik (ID, Cena, Pracownik_ID, Usluga_ID) VALUES (1, 80.00, 1, 1);
INSERT INTO Cennik (ID, Cena, Pracownik_ID, Usluga_ID) VALUES (2, 120.00, 3, 2);
INSERT INTO Cennik (ID, Cena, Pracownik_ID, Usluga_ID) VALUES (3, 150.00, 2, 3);
INSERT INTO Cennik (ID, Cena, Pracownik_ID, Usluga_ID) VALUES (4, 130.00, 5, 4);
INSERT INTO Cennik (ID, Cena, Pracownik_ID, Usluga_ID) VALUES (5, 250.00, 1, 5);

INSERT INTO Rezerwacja (ID, Data, Godzina, Klient_ID, StatusRezerwacji_ID) VALUES (1, TO_DATE('2026-06-10', 'YYYY-MM-DD'), 14, 1, 1);
INSERT INTO Rezerwacja (ID, Data, Godzina, Klient_ID, StatusRezerwacji_ID) VALUES (2, TO_DATE('2026-06-11', 'YYYY-MM-DD'), 10, 2, 2);
INSERT INTO Rezerwacja (ID, Data, Godzina, Klient_ID, StatusRezerwacji_ID) VALUES (3, TO_DATE('2026-06-12', 'YYYY-MM-DD'), 16, 3, 3);
INSERT INTO Rezerwacja (ID, Data, Godzina, Klient_ID, StatusRezerwacji_ID) VALUES (4, TO_DATE('2026-06-13', 'YYYY-MM-DD'), 11, 4, 1);
INSERT INTO Rezerwacja (ID, Data, Godzina, Klient_ID, StatusRezerwacji_ID) VALUES (5, TO_DATE('2026-06-14', 'YYYY-MM-DD'), 15, 5, 2);

INSERT INTO Rezerwacja_Usluga (ID, Rezerwacja_ID, Usluga_ID) VALUES (1, 1, 1);
INSERT INTO Rezerwacja_Usluga (ID, Rezerwacja_ID, Usluga_ID) VALUES (2, 2, 2);
INSERT INTO Rezerwacja_Usluga (ID, Rezerwacja_ID, Usluga_ID) VALUES (3, 3, 3);
INSERT INTO Rezerwacja_Usluga (ID, Rezerwacja_ID, Usluga_ID) VALUES (4, 4, 4);
INSERT INTO Rezerwacja_Usluga (ID, Rezerwacja_ID, Usluga_ID) VALUES (5, 5, 5);

INSERT INTO Produkt_Rezerwacja (ID, Ilosc, Produkt_ID, Rezerwacja_ID) VALUES (1, 1, 1, 1);
INSERT INTO Produkt_Rezerwacja (ID, Ilosc, Produkt_ID, Rezerwacja_ID) VALUES (2, 2, 2, 2);
INSERT INTO Produkt_Rezerwacja (ID, Ilosc, Produkt_ID, Rezerwacja_ID) VALUES (3, 1, 3, 3);
INSERT INTO Produkt_Rezerwacja (ID, Ilosc, Produkt_ID, Rezerwacja_ID) VALUES (4, 1, 5, 4);
INSERT INTO Produkt_Rezerwacja (ID, Ilosc, Produkt_ID, Rezerwacja_ID) VALUES (5, 2, 4, 5);

COMMIT;
