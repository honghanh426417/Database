CREATE DATABASE SubQuery
USE SubQuery
CREATE TABLE Student(
    SID INT PRIMARY KEY,
    S_FName VARCHAR(20) NOT NULL,
    S_LName VARCHAR(30) NOT NULL
);
CREATE TABLE Course(
    CID INT PRIMARY KEY,
    C_Name VARCHAR(30) NOT NULL
);
CREATE TABLE Course_Grades(
    CGID INT PRIMARY KEY,
    Semester CHAR(4) NOT NULL,
    CID_CG INT NOT  NULL,
    SID_CG INT NOT NULL,
    Grade CHAR(2) NOT NULL,
    CONSTRAINT CID_CG_FK
      FOREIGN KEY(CID_CG)
      REFERENCES Course(CID)
      ON DELETE CASCADE,
    --   Xoá dây chuyền: xoá ở khoá chính => toàn bộ DL của pk bị xoá dây chuyền
    CONSTRAINT SID_CG_FK
      FOREIGN KEY(SID_CG)
      REFERENCES Student(SID)
      ON DELETE CASCADE
);
INSERT INTO Student (SID, S_FName, S_LName) VALUES (12345, 'Chris', 'Rock');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (23456, 'Chris', 'Farley');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (34567, 'David', 'Spad');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (45678, 'Liz', 'Lemon');
INSERT INTO Student (SID, S_FName, S_LName) VALUES (56789, 'Jack', 'Donaghy');

INSERT INTO Course (CID, C_Name) VALUES (101001, 'Intro to Computers');
INSERT INTO Course (CID, C_Name) VALUES (101002, 'Programming');
INSERT INTO Course (CID, C_Name) VALUES (101003, 'Databases');
INSERT INTO Course (CID, C_Name) VALUES (101004, 'Websites');
INSERT INTO Course (CID, C_Name) VALUES (101005, 'IS Management');

INSERT INTO Course_Grades (CGID, Semester, CID_CG, SID_CG, Grade) VALUES (2010101, 'SP10', 101005, 34567, 'D+');
INSERT INTO Course_Grades (CGID, Semester, CID_CG, SID_CG, Grade) VALUES (2010308, 'FA10', 101005, 34567, 'A-');
INSERT INTO Course_Grades (CGID, Semester, CID_CG, SID_CG, Grade) VALUES (2010309, 'FA10', 101001, 45678, 'B+');
INSERT INTO Course_Grades (CGID, Semester, CID_CG, SID_CG, Grade) VALUES (2011308, 'FA11', 101003, 23456, 'B-');
INSERT INTO Course_Grades (CGID, Semester, CID_CG, SID_CG, Grade) VALUES (2012206, 'SU12', 101002, 56789, 'A+');

ALTER TABLE Student
ALTER COLUMN  S_FName VARCHAR(30) NOT NULL;

ALTER TABLE Course 
ADD Faculty_LName VARCHAR(30) DEFAULT 'TBD' NOT NULL;

UPDATE Course
  SET Faculty_LName= 'Potter', C_Name= 'Intro to Wizardry'
  WHERE CID = 101001;

-- ALTER TABLE Course   
--     CHANGE C_Name Course_Name VARCHAR(30);
EXEC sp_rename 'Course.C_Name', 'CourseName'

DELETE FROM Course
   Where CID = 101004;
DELETE FROM Course
   Where CourseName = 'Website';

DROP TABLE  Student;

TRUNCATE TABLE Course;

ALTER TABLE Course_Grades DROP CONSTRAINT CID_CG_FK;
<<OR>>
ALTER TABLE Course_Grades DROP INDEX CID_CG_FK;
ALTER TABLE Course_Grades DROP CONSTRAINT SID_CG_FK;
<<OR>>
ALTER TABLE Course_Grades DROP INDEX SID_CG_FK;

SELECT * FROM Student JOIN Course_Grades on SID = SID_CG
WHERE Grade = (SELECT min(Grade) FROM Course_Grades);

SELECT * FROM Student JOIN Course_Grades on SID = SID_CG
WHERE Grade IN  (SELECT min(Grade) FROM Course_Grades)

SELECT * FROM Student JOIN Course_Grades on SID = SID_CG
WHERE Grade = ANY  (SELECT min(Grade) FROM Course_Grades)


SELECT S_FName, S_LName, CourseName, Grade, Semester
FROM Course_Grades JOIN Course on CID = CID_CG
                   JOIN Student on SID = SID_CG

SELECT * FROM Student JOIN Course_Grades on SID = SID_CG WHERE Semester = 'Semester'

SELECT * from Course_Grades JOIN Student on SID = SID_CG
                            JOIN Course on CID = CID_CG
     where CourseName = 'MKT'

SELECT * FROM Student JOIN Course_Grades on SID = SID_CG WHERE Grade >= 'C'

SELECT * FROM Student JOIN Course_Grades on SID = SID_CG WHERE Grade = (SELECT AVG(Grade) FROM Course_Grades);

