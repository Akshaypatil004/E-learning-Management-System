CREATE DATABASE IF NOT EXISTS lmsdb;
USE lmsdb;

CREATE TABLE student (
    student_id    INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    registered_on DATE NOT NULL DEFAULT (CURDATE())
);

CREATE TABLE instructor (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    bio           TEXT
);

CREATE TABLE admin (
    admin_id      INT AUTO_INCREMENT PRIMARY KEY,
    name          VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL
);

CREATE TABLE course (
    course_id     INT AUTO_INCREMENT PRIMARY KEY,
    instructor_id INT NOT NULL,
    title         VARCHAR(255) NOT NULL,
    description   TEXT,
    created_on    DATE NOT NULL DEFAULT (CURDATE()),
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id) ON DELETE CASCADE
);

CREATE TABLE lesson (
    lesson_id    INT AUTO_INCREMENT PRIMARY KEY,
    course_id    INT NOT NULL,
    title        VARCHAR(255) NOT NULL,
    content_url  VARCHAR(255),
    order_index  INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES course(course_id) ON DELETE CASCADE
);

CREATE TABLE enrollment (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id    INT NOT NULL,
    course_id     INT NOT NULL,
    enrolled_on   DATE NOT NULL DEFAULT (CURDATE()),
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)  REFERENCES course(course_id)  ON DELETE CASCADE,
    UNIQUE (student_id, course_id)
);

CREATE TABLE progress (
    progress_id  INT AUTO_INCREMENT PRIMARY KEY,
    student_id   INT NOT NULL,
    lesson_id    INT NOT NULL,
    is_completed TINYINT(1) NOT NULL DEFAULT 0,
    completed_on DATE,
    FOREIGN KEY (student_id) REFERENCES student(student_id) ON DELETE CASCADE,
    FOREIGN KEY (lesson_id)  REFERENCES lesson(lesson_id)   ON DELETE CASCADE,
    UNIQUE (student_id, lesson_id)
);