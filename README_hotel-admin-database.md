# Hotel Admin: Relational Database (Oracle PL/SQL)

Academic project (PJATK): design and implementation of a relational database for a hotel administration system.

## What is inside
| File | Description |
|---|---|
| `erd.png` | Entity-relationship diagram |
| `schema.sql` | Table definitions, keys and constraints |
| `triggers.sql` | 4 triggers (INSERT / UPDATE / DELETE) |
| `queries.sql` | Advanced SELECT queries |
| `docs/description.docx` | Full description of the database (in Polish) |

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
[2–4 sentences: what the system manages (rooms, guests, reservations, staff, ...), main entities and relationships.]
