# 584. Find Customer Referee
select name from customer
where referee_id != 2 or referee_id is null;
# 1757. Recyclable and Low Fat Products
select product_id from Products
where low_fats = 'Y' and recyclable = 'Y';
# 1683. Invalid Tweets
SELECT tweet_id FROM Tweets
WHERE LENGTH(content) > 15;
# 627. Swap Salary
update salary
set sex = CASE 
        when sex = 'm' then 'f'
        when sex = 'f' then 'm'
        end;
# 1068.Product sales analysis
SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id;
# 1148.Article View
select distinct author_id as id from Views
where author_id = viewer_id
order by id