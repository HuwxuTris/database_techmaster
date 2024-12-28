# Phần A: 10 Câu Hỏi Truy Vấn (SELECT)

**Câu 1**
Đề bài:
Liệt kê danh sách Users kèm thông tin ProfileInfo (nếu có).

Các cột cần hiển thị:
Users.id, Users.username, Users.email,
ProfileInfo.bio, ProfileInfo.avatar_url, ProfileInfo.payment (nếu có).
Sắp xếp theo Users.created_at (mới nhất trước).

SELECT
u.id,
u.username,
u.email,
p.bio,
p.avatar_url,
p.payment,
u.created_at
FROM
Users u
LEFT JOIN
ProfileInfo p
ON
u.id = p.user_id
ORDER BY
u.created_at DESC;

**Câu 2**  
Đề bài:
Lấy danh sách Feeds kèm số lượng Likes và số lượng Comments của mỗi feed.

Các cột hiển thị:
Feeds.id, Feeds.content, Feeds.created_at,
TotalLikes (số lượt like),
TotalComments (số lượt bình luận).
Sắp xếp theo TotalLikes giảm dần.

SELECT f.id,
f.content,
f.created_at,
count(l.feed_id) as TotalLikes,
count(c.feed_id) as TotalComments
FROM feeds f
LEFT JOIN webtoons.comments c on f.id = c.feed_id
LEFT JOIN webtoons.likes l on f.id = l.feed_id
GROUP BY f.id, f.content, f.created_at
ORDER BY TotalLikes desc

**Câu 3**
Đề bài:
Liệt kê danh sách Comments kèm tên Users (người bình luận), nội dung Feed và thời gian tạo comment.

Các cột hiển thị:
Comments.id, Comments.content (nội dung bình luận), Comments.created_at,
Users.username (người viết bình luận),
Feeds.content (nội dung feed, có thể rút gọn nếu cần).
Sắp xếp mới nhất trước (theo Comments.created_at DESC).

SELECT
c.id ,
c.content as comment_content,
c.created_at,
u.username ,
LEFT(f.content, 20) as feed_content
FROM
Comments c
JOIN
Users u ON c.user_id = u.id
JOIN
Feeds f ON c.feed_id = f.id
ORDER BY
c.created_at DESC;

**Câu 4**
Đề bài:
Tìm các Series mà mỗi User đã yêu thích (thông qua bảng FavoriteSeries).

Các cột hiển thị:
Users.username,
Series.id, Series.description,
Thời gian Series.created_at.
Chỉ lấy những series được user đánh dấu yêu thích (tức có bản ghi trong FavoriteSeries).

SELECT
u.username AS Username,
s.id AS SeriesID,
s.description AS SeriesDescription,
s.created_at AS SeriesCreatedAt
FROM
FavoriteSeries fs
JOIN
Users u ON fs.user_id = u.id
JOIN
Series s ON fs.series_id = s.id
ORDER BY
u.username, s.created_at;

**Câu 5**
Đề bài:
Liệt kê các Chapters thuộc từng Series, kèm tên người tạo (User).

Các cột hiển thị:
Chapters.id, Chapters.title, Chapters.created_at,
Series.id, Series.description,
Users.username (chủ sở hữu Series).
Sắp xếp theo Chapters.created_at tăng dần (cũ nhất trước).

ở đây em thêm order theo series để dễ nhìn

SELECT
s.id AS SeriesID,
c.id AS ChapterID,
c.title AS ChapterTitle,
c.created_at AS ChapterCreatedAt,
s.description AS SeriesDescription,
u.username AS CreatorUsername
FROM
Chapters c
JOIN
Series s ON c.series_id = s.id
JOIN
Users u ON s.user_id = u.id
ORDER BY
c.series_id ASC,
c.created_at ASC;

**Câu 6**
Đề bài:
Liệt kê Notifications của mỗi User, chỉ lấy thông báo chưa đọc (is_read = FALSE).

Các cột hiển thị:
Notifications.id, Notifications.message, Notifications.created_at,
Users.username.
Sắp xếp theo Notifications.created_at giảm dần.

SELECT
n.id AS NotificationID,
n.message AS NotificationMessage,
n.created_at AS NotificationCreatedAt,
u.username AS Username
FROM
Notifications n
JOIN
Users u ON n.user_id = u.id
WHERE
n.is_read = FALSE
ORDER BY
n.created_at DESC;

**Câu 7**
Đề bài:
Thống kê SeriesRevenue của từng Series, kèm tên User sở hữu.

Các cột hiển thị:
Series.id, Series.description,
SeriesRevenue.total_donations, SeriesRevenue.view_revenu, SeriesRevenue.ads_revenu,
SeriesRevenue.last_updated,
Users.username.
Sắp xếp giảm dần theo total_donations.

SELECT
s.id,
s.description,
sr.total_donations,
sr.view_revenu,
sr.ads_revenu,
sr.last_updated,
u.username
FROM
SeriesRevenue sr
JOIN
series s on s.id = sr.series_id
JOIN
users u on u.id = s.user_id
ORDER BY
sr.total_donations;

**Câu 8**
Đề bài:
Danh sách Donate (ủng hộ), kèm thông tin User (người ủng hộ) và Series được ủng hộ.

Các cột hiển thị:
Donate.id, Donate.amount, Donate.created_at,
Users.username (người ủng hộ),
Series.description (series được ủng hộ).
Sắp xếp mới nhất trước (theo Donate.created_at DESC).

SELECT
d.id AS DonateID,
d.series_id as SeriesID,
d.amount AS DonateAmount,
d.created_at AS DonateCreatedAt,
u.username AS DonorUsername,
s.description AS SeriesDescription
FROM
Donate d
JOIN
Users u ON d.user_id = u.id
JOIN
Series s ON d.series_id = s.id
ORDER BY
d.series_id ASC,
d.created_at DESC;

**Câu 9**
Đề bài:
Liệt kê ProfilePages kèm page_title, description, và danh sách Feeds (nếu feeds_ids tham chiếu chính xác).

Ở đây, cột feeds_ids gây mơ hồ (dường như mỗi ProfilePage chỉ tham chiếu 1 feed?).
Yêu cầu: Lấy ProfilePages.id, ProfilePages.page_title, ProfilePages.description,
Tên user (Users.username) sở hữu page,
Feeds.content (nếu feeds_ids != NULL).
Sắp xếp tăng dần theo ProfilePages.id.

Ở đây em có update thêm bảng ProfilePageFeeds để profilepage có nhiều feed

SELECT
pp.id AS ProfilePageID,
u.username AS OwnerUsername,
pp.page_title AS PageTitle,
pp.description AS PageDescription,
f.content AS FeedContent
FROM
ProfilePages pp
JOIN
Users u ON pp.user_id = u.id
LEFT JOIN
ProfilePageFeeds ppf ON pp.id = ppf.profile_page_id
LEFT JOIN
Feeds f ON ppf.feed_id = f.id
ORDER BY
pp.id ASC;

**Câu 10**
Đề bài:
Liệt kê bảng Follows, kèm tên người follow và tên người được follow.

Giả sử: Follows.follower_id và Follows.following_id đều là Users.id.
Các cột hiển thị:
Follows.users_id, Follows.follower_id, Follows.following_id,
Tên user follower (Users.username) và tên user following.
Sắp xếp Follows.users_id tăng dần.

Em có chỉnh sửa bảng follows

SELECT
f.id AS FollowID,
f.user_id AS FollowerID,
f.following_id AS FollowingID,
u1.username AS FollowerUsername,
u2.username AS FollowingUsername
FROM
Follows f
JOIN
Users u1 ON f.user_id = u1.id
JOIN
Users u2 ON f.following_id = u2.id
ORDER BY
f.id ASC;

# Phần B: 5 Câu hỏi về Trigger

**Câu 1**
Trigger kiểm tra khi thêm Feeds
Yêu cầu: Chỉ cho phép tạo Feeds nếu Users.id tồn tại.  
Đề bài: Chỉ cho phép tạo Feeds nếu Users.id tồn tại.
Nếu user_id không tìm thấy trong bảng Users, hoặc user_id = NULL, báo lỗi.

DELIMITER //
CREATE TRIGGER before_insert_feeds
BEFORE INSERT ON Feeds
FOR EACH ROW
BEGIN
IF NEW.user_id IS NULL OR
NOT EXISTS (SELECT 1 FROM Users WHERE id = NEW.user_id) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Error: user_id does not exist in Users.';
END IF;
END;
//
DELIMITER ;

**Câu 2**
Trigger cấm user tự "like" feed của chính họ
Đề bài: BEFORE INSERT trên Likes. Nếu Likes.user_id trùng với Feeds.user_id thì báo lỗi.
Dùng JOIN hoặc subquery trong trigger để so sánh.

DELIMITER $$

CREATE TRIGGER prevent_self_like
BEFORE INSERT ON Likes
FOR EACH ROW
BEGIN
DECLARE feed_author_id INT;

    SELECT user_id INTO feed_author_id
    FROM Feeds
    WHERE id = NEW.feed_id;

    IF NEW.user_id = feed_author_id THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Users cannot like their own posts.';
    END IF;

END$$

DELIMITER ;

**Câu 3**
Trigger tự động đặt is_read = TRUE khi user xóa một Notifications (hoặc ngược lại, xóa notification => update? …).
Đề bài: Có thể minh họa logic “khi xóa Notification, ta ghi log” hoặc “khi update is_read = TRUE, set created_at = NOW()”.
DELIMITER $$

---

**Câu 4**
Trigger khi xóa một Series, xóa luôn các Chapters và SeriesRevenue liên quan.

Đề bài: AFTER DELETE trên Series.
Xóa Chapters có series_id = OLD.id.
Xóa SeriesRevenue có series_id = OLD.id.
Thay thế cho ON DELETE CASCADE (nếu DB không hỗ trợ hoặc muốn handle thủ công).

DELIMITER $$

CREATE TRIGGER delete_related_series_data
BEFORE DELETE ON Series
FOR EACH ROW
BEGIN
DELETE FROM Chapters
WHERE series_id = OLD.id;
DELETE FROM SeriesRevenue
WHERE series_id = OLD.id;
END$$

DELIMITER ;

**Câu 5**
Trigger tự động cập nhật SeriesRevenue.last_updated mỗi khi có Donate mới vào Series đó.

Đề bài: AFTER INSERT trên Donate.
Mỗi khi INSERT thành công, cập nhật SeriesRevenue.last_updated = NOW() cho series_id = NEW.series_id.

DELIMITER $$

CREATE TRIGGER update_total_donations
AFTER INSERT ON Donate
FOR EACH ROW
BEGIN
UPDATE SeriesRevenue
SET # total_donations = total_donations + NEW.amount,
seriesrevenue.last_updated = NOW()
WHERE series_id = NEW.series_id;
END$$

DELIMITER ;

# Phần C: 5 Câu hỏi Store Procedure

**Câu 1**
SP thêm mới Users kèm tự động mã hóa/mô phỏng password.

Đề bài: Tham số: p_username, p_email, p_raw_password, …
Lưu vào Users.password_hash dưới dạng SHA2(p_raw_password, 256) hoặc tương tự (tùy DB).
Tự động set created_at = NOW().

DELIMITER $$

CREATE PROCEDURE AddUser (
IN p_username VARCHAR(50),
IN p_email VARCHAR(100),
IN p_raw_password VARCHAR(255)
)
BEGIN
INSERT INTO Users (username, email, password_hash, created_at)
VALUES (
p_username,
p_email,
SHA2(p_raw_password, 256),
NOW()
);
END$$

DELIMITER ;

**Câu 2**
SP cập nhật ProfileInfo cho 1 user:

Đề bài: Tham số: p_user_id, p_bio, p_avatar_url, p_social_links, p_payment.
Nếu chưa có record trong ProfileInfo, thì INSERT. Nếu có rồi, thì UPDATE.
Cập nhật ProfileInfo tương ứng.

DELIMITER $$

CREATE PROCEDURE UpdateProfileInfo (
IN p_user_id INT,
IN p_bio TEXT,
IN p_avatar_url VARCHAR(255),
IN p_social_links TEXT,
IN p_payment TEXT
)
BEGIN
-- Kiểm tra xem ProfileInfo đã tồn tại cho user_id hay chưa
IF EXISTS (SELECT 1 FROM ProfileInfo WHERE user_id = p_user_id) THEN
-- Nếu đã tồn tại, thực hiện UPDATE
UPDATE ProfileInfo
SET bio = p_bio,
avatar_url = p_avatar_url,
social_links = p_social_links,
payment = p_payment
WHERE user_id = p_user_id;
ELSE
-- Nếu chưa tồn tại, thực hiện INSERT
INSERT INTO ProfileInfo (user_id, bio, avatar_url, social_links, payment)
VALUES (p_user_id, p_bio, p_avatar_url, p_social_links, p_payment);
END IF;
END$$

DELIMITER ;

**Câu 3** SP tạo mới Feeds và trả về id vừa chèn (nếu DBMS hỗ trợ).

Đề bài: Tham số: p_user_id, p_content.
Feeds.created_at = NOW(), Feeds.updated_at = NOW().
Sau khi INSERT, dùng LAST_INSERT_ID() (MySQL) hoặc RETURNING (PostgreSQL).

DELIMITER //
CREATE PROCEDURE sp_create_feed(
IN p_user_id INT,
IN p_content TEXT,
OUT p_feed_id INT
)
BEGIN
INSERT INTO Feeds (user_id, content, created_at, updated_at)
VALUES (p_user_id, p_content, NOW(), NOW());
SET p_feed_id = LAST_INSERT_ID();
END;
//
DELIMITER ;

**Câu 4**
SP thống kê tổng số lượt like và comment cho 1 Feed (theo p_feed_id).

Đề bài: Tham số: p_feed_id.
2 kết quả SELECT:
SELECT COUNT(_) FROM Likes WHERE feed_id = p_feed_id;
SELECT COUNT(_) FROM Comments WHERE feed_id = p_feed_id;

DELIMITER //
CREATE PROCEDURE sp_feed_statistics(
IN p_feed_id INT,
OUT p_total_likes INT,
OUT p_total_comments INT
)
BEGIN
SELECT COUNT(_) INTO p_total_likes
FROM Likes WHERE feed_id = p_feed_id;
SELECT COUNT(_) INTO p_total_comments
FROM Comments WHERE feed_id = p_feed_id;
END;
//
DELIMITER ;

**Câu 5** SP xử lý Donate:

Đề bài: Tham số: p_user_id, p_series_id, p_amount.
INSERT INTO Donate(...) với created_at = NOW().
Sau đó, tự động cộng số tiền vào SeriesRevenue.total_donations (hoặc + p_amount).
Tương tự, cập nhật SeriesRevenue.last_updated = NOW().

DELIMITER //
CREATE PROCEDURE sp_process_donate(
IN p_user_id INT,
IN p_series_id INT,
IN p_amount INT
)
BEGIN
INSERT INTO Donate (user_id, series_id, amount, created_at)
VALUES (p_user_id, p_series_id, p_amount, NOW());
UPDATE SeriesRevenue
SET total_donations = total_donations + p_amount, last_updated = NOW()
WHERE series_id = p_series_id;
END;
//
DELIMITER ;
