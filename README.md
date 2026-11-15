# Hotel Admin: Relational Database (Oracle PL/SQL)

Academic project (PJATK): design and implementation of a relational database for a hotel administration system.

## What is inside
| File | Description |
|---|---|
| `Diagram_encji.png` | Entity-relationship diagram |
| `baza.sql` | Table definitions, keys and constraints |
| `joins.sql` | 4 triggers (INSERT / UPDATE / DELETE) |
| `triggers 2.sql` | Advanced SELECT queries |
| `opis_bazy 1.docx` | Full description of the database (in Polish) |

## Highlights
- Schema normalised to **3NF / BCNF** (candidate keys, functional dependencies, decomposition).
- **4 triggers** covering INSERT, UPDATE and DELETE: data validation and integrity protection (e.g. `walidacja_pozycji`, `ochrona_pracownika`).
- Queries using complex **JOINs**, aggregate functions, **GROUP BY / HAVING**, nested and **correlated subqueries**.

## Tech
Oracle Database, SQL, PL/SQL, DataGrip.

## How to run
1. Run `schema.sql` in an Oracle schema.
2. Run `triggers.sql`.
3. (Optional) Load sample data and run `queries.sql`.

## Domain description
[The database models the operations of a hotel: [rooms, guests, reservations, staff, services, payments].
It supports [booking and check-in, staff management, billing].
Business rules such as [rule 1] and [rule 2] are enforced by triggers.
The schema contains [N] tables and is normalised to 3NF/BCNF.]
