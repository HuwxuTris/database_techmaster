# 1741. Find Total Time Spent by Each Employee
select event_day as day, emp_id, 
sum(out_time - in_time) as total_time
from employees
group by event_day, emp_id
# 2356. Number of Unique Subjects Taught by Each Teacher
select teacher_id,
count(distinct subject_id) as cnt 
from teacher
group by teacher_id
# 1693. Daily Leads and Partners
select date_id, make_name,count(distinct lead_id) as unique_leads,
count(distinct partner_id) as unique_partners
from dailysales
group by date_id,make_name
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