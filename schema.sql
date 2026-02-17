CREATE TABLE `users` (
  `user_id` integer PRIMARY KEY AUTO_INCREMENT,
  `full_name` varchar(255),
  `email` varchar(255) UNIQUE,
  `role` varchar(255),
  `created_at` timestamp DEFAULT (now())
);

CREATE TABLE `categories` (
  `category_id` integer PRIMARY KEY AUTO_INCREMENT,
  `name` varchar(255) UNIQUE
);

CREATE TABLE `courses` (
  `course_id` integer PRIMARY KEY AUTO_INCREMENT,
  `title` varchar(255),
  `description` text,
  `price` decimal,
  `instructor_id` integer,
  `category_id` integer
);

CREATE TABLE `lessons` (
  `lesson_id` integer PRIMARY KEY AUTO_INCREMENT,
  `course_id` integer,
  `title` varchar(255),
  `duration_mins` integer
);

CREATE TABLE `enrollments` (
  `enrollment_id` integer PRIMARY KEY AUTO_INCREMENT,
  `student_id` integer,
  `course_id` integer,
  `enroll_date` timestamp DEFAULT (now()),
  `progress_percent` integer DEFAULT 0
);

CREATE TABLE `reviews` (
  `review_id` integer PRIMARY KEY AUTO_INCREMENT,
  `course_id` integer,
  `student_id` integer,
  `rating` integer,
  `comment` text
);

CREATE TABLE `payments` (
  `payment_id` integer PRIMARY KEY AUTO_INCREMENT,
  `student_id` integer,
  `course_id` integer,
  `amount` decimal,
  `payment_status` varchar(255),
  `transaction_id` varchar(255) UNIQUE,
  `payment_date` timestamp DEFAULT (now())
);

CREATE TABLE `certificates` (
  `certificate_id` integer PRIMARY KEY AUTO_INCREMENT,
  `enrollment_id` integer,
  `issue_date` timestamp DEFAULT (now()),
  `certificate_code` varchar(255) UNIQUE
);

ALTER TABLE `courses` ADD FOREIGN KEY (`instructor_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `courses` ADD FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

ALTER TABLE `lessons` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `enrollments` ADD FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `enrollments` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `reviews` ADD FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`);

ALTER TABLE `payments` ADD FOREIGN KEY (`course_id`) REFERENCES `courses` (`course_id`);

ALTER TABLE `certificates` ADD FOREIGN KEY (`enrollment_id`) REFERENCES `enrollments` (`enrollment_id`);
