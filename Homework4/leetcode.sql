# 2356.Number of Unique Subjects Taught by Each Teacher
select teacher_id,
count(distinct subject_id) as cnt
from teacher
group by teacher_id

# 1378. Replace Employee ID With The Unique Identifier
SELECT
EmployeeUNI.unique_id, Employees.name
FROM Employees
LEFT JOIN EmployeeUNI on Employees.id = EmployeeUNI.id
# 1683. Invalid Tweets
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;
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
# 627. Swap Salary
update salary
set sex = CASE
        when sex = 'm' then 'f'
        when sex = 'f' then 'm'
        end;
# 1068. Product Sales Analysis I
SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id;
# 1581. Customer Who Visited but Did Not Make Any Transactions
select customer_id, count(customer_id) as count_no_trans
from visits
where visit_id not in (select distinct visit_id from transactions)
group by customer_id;

# 1179. Reformat Department Table
select id,
sum(case when month="Jan" then revenue else null end) as Jan_Revenue,
sum(case when month="Feb" then revenue else null end) as Feb_Revenue,
sum(case when month="Mar" then revenue else null end) as Mar_Revenue,
sum(case when month="Apr" then revenue else null end) as Apr_Revenue,
sum(case when month="May" then revenue else null end) as May_Revenue,
sum(case when month="Jun" then revenue else null end) as Jun_Revenue,
sum(case when month="Jul" then revenue else null end) as Jul_Revenue,
sum(case when month="Aug" then revenue else null end) as Aug_Revenue,
sum(case when month="Sep" then revenue else null end) as Sep_Revenue,
sum(case when month="Oct" then revenue else null end) as Oct_Revenue,
sum(case when month="Nov" then revenue else null end) as Nov_Revenue,
sum(case when month="Dec" then revenue else null end) as Dec_Revenue
from Department group by id order by id;
# 1484. Group Sold Products By The Date
select distinct sell_date, count(distinct product) as num_sold, group_concat(distinct product order by product SEPARATOR ',') as products
from Activities
group by sell_date
order by sell_date
# 1890. The Latest Login in 2020
select user_id, max(time_stamp) as last_stamp
from logins
where year(time_stamp) = 2020
group by user_id
# 1251. Average Selling Price
SELECT p.product_id, IFNULL(ROUND(SUM(units*price)/SUM(units),2),0) AS average_price
FROM Prices p LEFT JOIN UnitsSold u
ON p.product_id = u.product_id
and u.purchase_date BETWEEN start_date AND end_date
group by product_id
# 1789. Primary Department for Each Employee
SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(department_id) = 1
UNION
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'