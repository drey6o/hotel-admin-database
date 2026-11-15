SELECT
   p.Nazwa AS Produkt,
   p.StanMagazynowy AS Zostalo_sztuk,
   d.Nazwa AS Dostawca
FROM Produkt p
JOIN Dostawca d ON p.Dostawca_ID = d.ID
WHERE p.StanMagazynowy < 15;

SELECT
   r.Data,
   r.Godzina || ':00' AS Czas,
   k.Imie || ' ' || k.Nazwisko AS Klient,
   s.Nazwa AS Status
FROM Rezerwacja r
JOIN Klient k ON r.Klient_ID = k.ID
JOIN StatusRezerwacji s ON r.StatusRezerwacji_ID = s.ID
ORDER BY r.Data, r.Godzina;

SELECT
   k.Imie,
   k.Nazwisko,
   COUNT(r.ID) AS Liczba_Rezerwacji
FROM Klient k
JOIN Rezerwacja r ON k.ID = r.Klient_ID
GROUP BY k.Imie, k.Nazwisko
HAVING COUNT(r.ID) > 1
ORDER BY Liczba_Rezerwacji DESC;

SELECT
   r.Data,
   SUM(u.Czas_Trwania_min) AS Laczny_Czas_Pracy_min
FROM Rezerwacja r
JOIN Rezerwacja_Usluga ru ON r.ID = ru.Rezerwacja_ID
JOIN Usluga u ON ru.Usluga_ID = u.ID
GROUP BY r.Data
HAVING SUM(u.Czas_Trwania_min) > 60
ORDER BY r.Data;

SELECT
   Nazwa,
   Czas_Trwania_min
FROM Usluga
WHERE Czas_Trwania_min > (SELECT AVG(Czas_Trwania_min) FROM Usluga);

SELECT
   Imie,
   Nazwisko,
   Telefon
FROM Klient
WHERE ID IN (SELECT Klient_ID FROM Rezerwacja);

SELECT
   k.Imie,
   k.Nazwisko
FROM Klient k
WHERE EXISTS (
   SELECT 1
   FROM Rezerwacja r
   WHERE r.Klient_ID = k.ID
   AND r.StatusRezerwacji_ID = 1
);