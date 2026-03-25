CREATE TABLE student (
    student_id    NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR2(255) NOT NULL,
    email         VARCHAR2(255) NOT NULL UNIQUE,
    password_hash VARCHAR2(255) NOT NULL,
    registered_on DATE DEFAULT SYSDATE NOT NULL
);

CREATE TABLE instructor (
    instructor_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR2(255) NOT NULL,
    email         VARCHAR2(255) NOT NULL UNIQUE,
    password_hash VARCHAR2(255) NOT NULL,
    bio           CLOB
);

CREATE TABLE admin (
    admin_id      NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name          VARCHAR2(255) NOT NULL,
    email         VARCHAR2(255) NOT NULL UNIQUE,
    password_hash VARCHAR2(255) NOT NULL
);

CREATE TABLE course (
    course_id     NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    instructor_id NUMBER NOT NULL,
    title         VARCHAR2(255) NOT NULL,
    description   CLOB,
    created_on    DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_course_instructor FOREIGN KEY (instructor_id)
        REFERENCES instructor(instructor_id) ON DELETE CASCADE
);

CREATE TABLE lesson (
    lesson_id   NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    course_id   NUMBER NOT NULL,
    title       VARCHAR2(255) NOT NULL,
    content_url VARCHAR2(255),
    order_index NUMBER NOT NULL,
    CONSTRAINT fk_lesson_course FOREIGN KEY (course_id)
        REFERENCES course(course_id) ON DELETE CASCADE
);

CREATE TABLE enrollment (
    enrollment_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id    NUMBER NOT NULL,
    course_id     NUMBER NOT NULL,
    enrolled_on   DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT fk_enrollment_student FOREIGN KEY (student_id)
        REFERENCES student(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_enrollment_course FOREIGN KEY (course_id)
        REFERENCES course(course_id) ON DELETE CASCADE,
    CONSTRAINT uq_enrollment UNIQUE (student_id, course_id)
);

CREATE TABLE progress (
    progress_id  NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id   NUMBER NOT NULL,
    lesson_id    NUMBER NOT NULL,
    is_completed NUMBER(1) DEFAULT 0 NOT NULL,
    completed_on DATE,
    CONSTRAINT fk_progress_student FOREIGN KEY (student_id)
        REFERENCES student(student_id) ON DELETE CASCADE,
    CONSTRAINT fk_progress_lesson FOREIGN KEY (lesson_id)
        REFERENCES lesson(lesson_id) ON DELETE CASCADE,
    CONSTRAINT uq_progress UNIQUE (student_id, lesson_id)
);