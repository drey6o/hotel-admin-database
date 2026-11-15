-- 1. Uzasadnienie: Walidacja danych przed zapisem i zapobieganie overbookingowi.
CREATE OR REPLACE TRIGGER trg_bef_ins_upd_rezerwacja
BEFORE INSERT OR UPDATE ON Rezerwacja
FOR EACH ROW
DECLARE
    v_konflikt NUMBER;
BEGIN
    IF :NEW.Data < TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Błąd: Nie można dodać rezerwacji na minioną datę!');
    END IF;

    IF :NEW.Godzina < 8 OR :NEW.Godzina > 20 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Błąd: Salon pracuje tylko w godzinach 8:00 - 20:00!');
    END IF;

    SELECT COUNT(*) INTO v_konflikt
    FROM Rezerwacja
    WHERE Klient_ID = :NEW.Klient_ID 
      AND Data = :NEW.Data 
      AND Godzina = :NEW.Godzina
      AND ID != NVL(:NEW.ID, 0);

    IF v_konflikt > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Błąd: Ten klient ma już rezerwację w tym terminie!');
    END IF;
END;
/

-- 2. Uzasadnienie: Ochrona przed usunięciem klienta, który ma aktywne wizyty lub długi.
CREATE OR REPLACE TRIGGER trg_bef_del_klient
BEFORE DELETE ON Klient
FOR EACH ROW
DECLARE
    v_przyszle_wizyty NUMBER;
    v_nieoplacone NUMBER;
BEGIN
    IF :OLD.ID = 1 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Błąd: Nie można usunąć głównego konta VIP (ID=1).');
    END IF;

    SELECT COUNT(*) INTO v_przyszle_wizyty
    FROM Rezerwacja
    WHERE Klient_ID = :OLD.ID AND Data >= TRUNC(SYSDATE);

    IF v_przyszle_wizyty > 0 THEN
        RAISE_APPLICATION_ERROR(-20005, 'Błąd: Klient ma zaplanowane przyszłe wizyty. Usuń je najpierw.');
    END IF;

    SELECT COUNT(*) INTO v_nieoplacone
    FROM Rezerwacja
    WHERE Klient_ID = :OLD.ID AND StatusRezerwacji_ID = 1;

    IF v_nieoplacone > 0 THEN
        RAISE_APPLICATION_ERROR(-20006, 'Błąd: Klient posiada nierozliczone wizyty.');
    END IF;
END;
/
-- 3. Uzasadnienie: Automatyczne zarządzanie stanem magazynowym (pobieranie i zwroty).
CREATE OR REPLACE TRIGGER trg_aft_ins_del_magazyn
AFTER INSERT OR DELETE ON Produkt_Rezerwacja
FOR EACH ROW
DECLARE
    v_stan_aktualny NUMBER;
    v_prod_id NUMBER;
BEGIN
    IF INSERTING THEN
        UPDATE Produkt 
        SET StanMagazynowy = StanMagazynowy - :NEW.Ilosc 
        WHERE ID = :NEW.Produkt_ID;
        v_prod_id := :NEW.Produkt_ID;
    ELSIF DELETING THEN
        UPDATE Produkt 
        SET StanMagazynowy = StanMagazynowy + :OLD.Ilosc 
        WHERE ID = :OLD.Produkt_ID;
        v_prod_id := :OLD.Produkt_ID;
    END IF;

    SELECT StanMagazynowy INTO v_stan_aktualny 
    FROM Produkt 
    WHERE ID = v_prod_id;

    IF v_stan_aktualny < 0 THEN
        RAISE_APPLICATION_ERROR(-20007, 'Błąd krytyczny: Brak wystarczającej ilości produktu na magazynie!');
    END IF;
END;
/

-- 4. Uzasadnienie: Ochrona cennika przed drastycznymi pomyłkami przy edycji.
CREATE OR REPLACE TRIGGER trg_aft_upd_cennik
AFTER UPDATE ON Cennik
FOR EACH ROW
BEGIN
    IF :NEW.Cena > (:OLD.Cena * 2) THEN
        RAISE_APPLICATION_ERROR(-20008, 'Ostrzeżenie: Podwyżka ceny o ponad 100% jest zablokowana.');
    END IF;

    IF :NEW.Cena < (:OLD.Cena * 0.5) THEN
        RAISE_APPLICATION_ERROR(-20009, 'Ostrzeżenie: Obniżka ceny o ponad 50% jest zablokowana.');
    END IF;

    IF :NEW.Pracownik_ID != :OLD.Pracownik_ID THEN
        RAISE_APPLICATION_ERROR(-20010, 'Błąd: Nie można zmienić pracownika w istniejącej cenie. Utwórz nowy rekord.');
    END IF;
END;
/
-- TEST 1: Próba zapisu na minioną datę
INSERT INTO Rezerwacja (ID, Data, Godzina, Klient_ID, StatusRezerwacji_ID)
VALUES (900, TO_DATE('2020-01-01', 'YYYY-MM-DD'), 14, 1, 1);

-- TEST 2: Próba usunięcia głównego klienta VIP 
DELETE FROM Klient WHERE ID = 1;

-- TEST 3: Próba pobrania 1000 sztuk produktu, którego nie ma na magazynie
INSERT INTO Produkt_Rezerwacja (ID, Ilosc, Produkt_ID, Rezerwacja_ID)
VALUES (900, 1000, 1, 1);

-- TEST 4: Próba drastycznej obniżki ceny z powodu błędu ludzkiego 
-- (Zakładamy, że pierwotna cena to np. 100.00 PLN)
UPDATE Cennik SET Cena = 10.00 WHERE ID = 1;