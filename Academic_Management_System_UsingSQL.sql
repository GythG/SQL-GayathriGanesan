SELECT('Academic Management System - Using SQL');

SELECT('    ');

CREATE TABLE STUDENT_INFO (
STU_ID INT PRIMARY KEY,
STU_NAME VARCHAR(100),
DOB DATE,
PHONE_NO VARCHAR(15),
EMAIL_ID VARCHAR(100),
ADDRESS VARCHAR(255)
);

INSERT INTO STUDENT_INFO (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES 
(1, 'Praveen Kumar', '2004-03-22', '0011223344', 'praveenk@example.com', '143 Gandhi St, SomeArea, INDIA'),
(2, 'Kayalvizhi', '2000-02-20', '9988776655', 'kayal@example.com', '223 T Nagar, Guindy, INDIA'),
(3, 'Malar Mozhi', '2010-04-12', '8877665544', 'mozhi@example.com', '901 Nungambakkam, Choolaimedu, INDIA'),
(4, 'Murugan Mani', '1991-08-25', '7766554433', 'mmani@example.com', '63 Local street, Besant Nagar, INDIA');

SELECT * FROM STUDENT_INFO;

SELECT('    ');


CREATE TABLE CoursesInfo (
COURSE_ID INT PRIMARY KEY,
COURSE_NAME VARCHAR(100),
COURSE_INSTRUCTOR_NAME VARCHAR(100)
);

INSERT INTO CoursesInfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR_NAME)
VALUES 
(101, 'Introduction to Computer Science', 'Martha Mary'),
(102, 'Data Structures and Algorithms', 'Kokila Ben'),
(103, 'Database Management Systems', 'Rage Roy'),
(104, 'Operating Systems', 'Mark Wilson');

SELECT * FROM CoursesInfo;

SELECT('    ');


CREATE TABLE EnrollmentInfo (
ENROLLMENT_ID INT PRIMARY KEY,
STU_ID INT,
COURSE_ID INT,
ENROLL_STATUS VARCHAR(20),
FOREIGN KEY (STU_ID) REFERENCES StudentInfo (STU_ID),
FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo (COURSE_ID)
);

INSERT INTO EnrollmentInfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES 
(1, 1, 101, 'Enrolled'),
(2, 2, 102, 'Enrolled'),
(3, 3, 103, 'Not Enrolled'),
(4, 4, 104, 'Enrolled'),
(5, 1, 102, 'Enrolled'),
(6, 2, 103, 'Not Enrolled'),
(7, 3, 104, 'Enrolled'),
(8, 4, 102, 'Enrolled');

SELECT * FROM EnrollmentInfo;

SELECT('    ');



/*a*/

SELECT 
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    e.ENROLL_STATUS
FROM 
    STUDENT_INFO s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID;
    
    SELECT('    ');


/*b*/

SELECT 
    c.COURSE_ID,
    c.COURSE_NAME,
    c.COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo c
JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.STU_ID = 1
AND 
    e.ENROLL_STATUS = 'Enrolled';
    
    SELECT('    ');

/*c*/

SELECT 
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo;
    
    SELECT('    ');

/*d*/

SELECT 
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo
WHERE 
    COURSE_ID = 103;
    
    SELECT('    ');

/*e*/

SELECT 
    COURSE_ID,
    COURSE_NAME,
    COURSE_INSTRUCTOR_NAME
FROM 
    CoursesInfo
WHERE 
    COURSE_ID IN (101, 102, 103);
    
    SELECT('    ');
    
/*Reporting - a*/

SELECT 
    c.COURSE_ID,
    c.COURSE_NAME,
    COUNT(e.STU_ID) AS NUM_ENROLLED
FROM 
    CoursesInfo c
LEFT JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_ID, c.COURSE_NAME;
    
    SELECT('    ');

/*Reporting - b*/

SELECT 
    s.STU_ID,
    s.STU_NAME,
    s.PHONE_NO,
    s.EMAIL_ID,
    s.ADDRESS
FROM 
    STUDENT_INFO s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
WHERE 
    e.COURSE_ID = 101
AND 
    e.ENROLL_STATUS = 'Enrolled';
    
    SELECT('    ');

/*Reporting - c*/

SELECT 
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(DISTINCT e.STU_ID) AS NUM_ENROLLED_STUDENTS
FROM 
    CoursesInfo c
JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
JOIN 
    STUDENT_INFO s ON e.STU_ID = s.STU_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_INSTRUCTOR_NAME;
    
SELECT('    ');

/*Reporting - d*/

SELECT 
    s.STU_ID,
    s.STU_NAME,
    COUNT(e.COURSE_ID) AS NUM_COURSES_ENROLLED
FROM 
    STUDENT_INFO s
JOIN 
    EnrollmentInfo e ON s.STU_ID = e.STU_ID
GROUP BY 
    s.STU_ID, s.STU_NAME
HAVING 
    COUNT(e.COURSE_ID) > 1;
    
SELECT('    ');


/*Reporting - e*/

SELECT 
    c.COURSE_ID,
    c.COURSE_NAME,
    c.COURSE_INSTRUCTOR_NAME,
    COUNT(e.STU_ID) AS NUM_ENROLLED_STUDENTS
FROM 
    CoursesInfo c
JOIN 
    EnrollmentInfo e ON c.COURSE_ID = e.COURSE_ID
WHERE 
    e.ENROLL_STATUS = 'Enrolled'
GROUP BY 
    c.COURSE_ID, c.COURSE_NAME, c.COURSE_INSTRUCTOR_NAME
ORDER BY 
    NUM_ENROLLED_STUDENTS DESC;
