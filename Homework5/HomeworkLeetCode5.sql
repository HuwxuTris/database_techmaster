# 1378. Replace Employee ID With The Unique Identifier
SELECT
EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI on Employees.id = EmployeeUNI.id
# 1795. Rearrange Products Table
select product_id,'store1' as store ,store1 as price from products where store1 is not null
union all
select product_id,'store2' as store, store2 as price from products where store2 is not null
union all
select product_id,'store3' as store, store3 as price from products where store3 is not null
# 1587. Bank Account Summary II
select a.name, sum(b.amount) as balance
from Users a join Transactions b
on a.account=b.account
group by a.account
having balance>10000;
# 1581. Customer Who Visited but Did Not Make Any Transactions
select customer_id, count(customer_id) as count_no_trans
from visits
where visit_id not in (select distinct visit_id from transactions)
group by customer_id;
#1251. Average Selling Price
SELECT p.product_id, IFNULL(ROUND(SUM(units*price)/SUM(units),2),0) AS average_price
FROM Prices p LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
and u.purchase_date BETWEEN start_date AND end_date
group by product_id
# 1303. Find the Team Size
use class4;
Create table Employee (
    employee_id int,
    team_id int
);

INSERT INTO Employee (employee_id, team_id)
VALUES (1, 8),
       (2, 8 ),
       (3, 8 ),
       (4, 7 ),
       (5, 9 ),
       (6, 9 );
SELECT
    e1.employee_id,
    COUNT(e2.employee_id) AS team_size
FROM
    Employee e1
JOIN
    Employee e2
ON
    e1.team_id = e2.team_id
GROUP BY
    e1.employee_id;

# 1571. Warehouse Manager
CREATE TABLE Warehouse (
    name VARCHAR(255),
    product_id INT,
    units INT,
    PRIMARY KEY (name, product_id)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    Width INT,
    Length INT,
    Height INT
);

INSERT INTO Warehouse (name, product_id, units) VALUES
('LCHouse1', 1, 1),
('LCHouse1', 2, 10),
('LCHouse1', 3, 5),
('LCHouse2', 1, 2),
('LCHouse2', 2, 2),
('LCHouse3', 4, 1);

INSERT INTO Products (product_id, product_name, Width, Length, Height) VALUES
(1, 'LC-TV', 5, 50, 40),
(2, 'LC-KeyChain', 5, 5, 5),
(3, 'LC-Phone', 2, 10, 10),
(4, 'LC-T-Shirt', 4, 10, 20);

SELECT
    w.name AS warehouse_name,
    SUM(w.units * p.Width * p.Length * p.Height) AS volume
FROM
    Warehouse w
JOIN
    Products p
ON
    w.product_id = p.product_id
GROUP BY
    w.name;
# 2339. All the Matches of the League
Create table If Not Exists Teams (team_name varchar(50));
Truncate table Teams;
insert into Teams (team_name) values ('Leetcode FC');
insert into Teams (team_name) values ('Ahly SC');
insert into Teams (team_name) values ('Real Madrid');

SELECT
    t1.team_name AS home_team,
    t2.team_name AS away_team
FROM
    Teams t1
JOIN
    Teams t2
ON
    t1.team_name != t2.team_name;
# 1421. NPV Queries
CREATE TABLE IF NOT EXISTS NPV (
    id INT,
    year INT,
    npv INT,
    PRIMARY KEY (id, year)
);
CREATE TABLE IF NOT EXISTS Queries (
    id INT,
    year INT,
    PRIMARY KEY (id, year)
);
TRUNCATE TABLE NPV;

INSERT INTO NPV (id, year, npv) VALUES
('1', '2018', '100'),
('7', '2020', '30'),
('13', '2019', '40'),
('1', '2019', '113'),
('2', '2008', '121'),
('3', '2009', '21'),
('11', '2020', '99'),
('7', '2019', '0');

TRUNCATE TABLE Queries;

INSERT INTO Queries (id, year) VALUES
('1', '2019'),
('2', '2008'),
('3', '2009'),
('7', '2018'),
('7', '2019'),
('7', '2020'),
('13', '2019');

SELECT
    q.id,
    q.year,
    COALESCE(n.npv, 0) AS npv
FROM
    Queries q
LEFT JOIN
    NPV n
ON
    q.id = n.id AND q.year = n.year;
