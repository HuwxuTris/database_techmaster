CREATE TABLE `JobSeeker` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(20),
  `email` varchar(50),
  `phone` varchar(10),
  `location_id` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `Employer` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(20),
  `email` varchar(50),
  `phone` varchar(10),
  `subscription_id` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `Job` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `description` text,
  `employer_id` int,
  `location_id` int,
  `experience_level_id` int,
  `education_id` int,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `Application` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `job_seeker_id` int,
  `job_id` int,
  `status` enum(pending,accepted,rejected,requested_info),
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `Notification` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `job_seeker_id` int,
  `message` text,
  `created_at` datetime,
  `updated_at` datetime
);

CREATE TABLE `Skill` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255)
);

CREATE TABLE `JobSkill` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `job_id` int,
  `skill_id` int
);

CREATE TABLE `JobSeekerSkill` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `job_seeker_id` int,
  `skill_id` int
);

CREATE TABLE `Favorite` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `job_seeker_id` int,
  `job_id` int,
  `created_at` datetime
);

CREATE TABLE `Feedback` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `job_seeker_id` int,
  `employer_id` int,
  `job_id` int,
  `content` text,
  `created_at` datetime
);

ALTER TABLE `Job` ADD FOREIGN KEY (`employer_id`) REFERENCES `Employer` (`id`);

ALTER TABLE `Application` ADD FOREIGN KEY (`job_seeker_id`) REFERENCES `JobSeeker` (`id`);

ALTER TABLE `Application` ADD FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`);

ALTER TABLE `Notification` ADD FOREIGN KEY (`job_seeker_id`) REFERENCES `JobSeeker` (`id`);

ALTER TABLE `JobSkill` ADD FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`);

ALTER TABLE `JobSkill` ADD FOREIGN KEY (`skill_id`) REFERENCES `Skill` (`id`);

ALTER TABLE `JobSeekerSkill` ADD FOREIGN KEY (`job_seeker_id`) REFERENCES `JobSeeker` (`id`);

ALTER TABLE `JobSeekerSkill` ADD FOREIGN KEY (`skill_id`) REFERENCES `Skill` (`id`);

ALTER TABLE `Favorite` ADD FOREIGN KEY (`job_seeker_id`) REFERENCES `JobSeeker` (`id`);

ALTER TABLE `Favorite` ADD FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`);

ALTER TABLE `Feedback` ADD FOREIGN KEY (`job_seeker_id`) REFERENCES `JobSeeker` (`id`);

ALTER TABLE `Feedback` ADD FOREIGN KEY (`employer_id`) REFERENCES `Employer` (`id`);

ALTER TABLE `Feedback` ADD FOREIGN KEY (`job_id`) REFERENCES `Job` (`id`);
