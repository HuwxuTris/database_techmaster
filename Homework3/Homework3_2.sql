# Hiển thị các bài viết của Person làm nghề Programmer được tạo sau ngày 01/01/2023
SELECT
p.fullname,
po.title,
po.content,
po.createdAt
FROM
Person p
JOIN
Post po
ON
p.id = po.authorId
WHERE
p.job = 'Programmer'
AND po.createdAt > '2023-01-01';
# Tính tổng số lượng bài Post trong năm 2022
SELECT
COUNT(*) AS total_posts_2022
FROM
Post
WHERE
YEAR(createdAt) = 2022;

# Hiển thị thông tin người dùng có bài Post trong năm 2022
SELECT DISTINCT
p.*
FROM
Person p
JOIN
Post po
ON
p.id = po.authorId
WHERE
YEAR(po.createdAt) = 2022;
# Hiển thị thông tin người dùng và title bài Post của 3 bài post mới nhất
SELECT
p.*,
po.title,
po.createdAt
FROM
Person p
JOIN
Post po
ON
p.id = po.authorId
ORDER BY
po.createdAt DESC
LIMIT 3;

# Thống kê số lượng bài Post của từng người
SELECT
p.fullname,
COUNT(po.id) AS post_count
FROM
Person p
LEFT JOIN
Post po
ON
p.id = po.authorId
GROUP BY
p.id, p.fullname;

# Thống kê số lượng bài Post của những người ở China
SELECT
p.fullname,
COUNT(po.id) AS post_count
FROM
Person p
JOIN
Post po
ON
p.id = po.authorId
WHERE
p.country = 'China'
GROUP BY
p.id, p.fullname;

# Thống kê số lượng bài Post của những người có sở thích Swimming trong năm 2023
SELECT
p.fullname,
COUNT(po.id) AS post_count
FROM
Person p
JOIN
Post po
ON
p.id = po.authorId
WHERE
p.hobbies LIKE '%Swimming%'
AND YEAR(po.createdAt) = 2023
GROUP BY
p.id, p.fullname;

# Tìm kiếm tháng có nhiều bài post nhất trong năm 2023
SELECT
MONTH(createdAt) AS post_month,
COUNT(*) AS post_count
FROM
Post
WHERE
YEAR(createdAt) = 2023
GROUP BY
MONTH(createdAt)
ORDER BY
post_count DESC
LIMIT 1;

# Tìm kiếm năm có ít bài post nhất
SELECT
YEAR(createdAt) AS post_year,
COUNT(*) AS post_count
FROM
Post
GROUP BY
YEAR(createdAt)
ORDER BY
post_count ASC
LIMIT 1;

# Tìm kiếm năm có nhiều bài post nhất
SELECT
YEAR(createdAt) AS post_year,
COUNT(*) AS post_count
FROM
Post
GROUP BY
YEAR(createdAt)
ORDER BY
post_count DESC
LIMIT 1;

# Hiển thị thông tin người dùng có nhiều bài post nhất trong năm 2023
SELECT
p.*,
COUNT(po.id) AS post_count
FROM
Person p
JOIN
Post po
ON
p.id = po.authorId
WHERE
YEAR(po.createdAt) = 2023
GROUP BY
p.id
ORDER BY
post_count DESC
LIMIT 1;

# Hiển thị thông tin những người dùng có nhiều hơn 2 bài post trong năm 2022
SELECT
    p.*,
    COUNT(po.id) AS post_count
FROM
    Person p
JOIN
    Post po
ON
    p.id = po.authorId
WHERE
    YEAR(po.createdAt) = 2022
GROUP BY
    p.id
HAVING
    COUNT(po.id) > 2;
