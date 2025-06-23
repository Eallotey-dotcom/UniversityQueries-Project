-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `university` ;

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8mb3 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`college` ;

CREATE TABLE IF NOT EXISTS `university`.`college` (
  `college_id` INT NOT NULL,
  `college` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`department` ;

CREATE TABLE IF NOT EXISTS `university`.`department` (
  `department_id` INT NOT NULL,
  `department` VARCHAR(100) NOT NULL,
  `department_code` VARCHAR(6) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`department_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `university`.`college` (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`course` ;

CREATE TABLE IF NOT EXISTS `university`.`course` (
  `course_id` INT NOT NULL,
  `course_title` VARCHAR(45) NOT NULL,
  `course_num` VARCHAR(3) NOT NULL,
  `credit` INT NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`course_id`),
  INDEX `fk_course_department1_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `university`.`department` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`faculty` ;

CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `faculty_id` INT NOT NULL,
  `faculty_fname` VARCHAR(10) NOT NULL,
  `faculty_lname` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`term`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`term` ;

CREATE TABLE IF NOT EXISTS `university`.`term` (
  `term_id` INT NOT NULL,
  `year` INT NOT NULL,
  `term` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`term_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`section` ;

CREATE TABLE IF NOT EXISTS `university`.`section` (
  `section_id` INT NOT NULL,
  `section` INT NOT NULL,
  `capacity` INT NOT NULL,
  `faculty_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `term_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  INDEX `fk_section_course1_idx` (`course_id` ASC) VISIBLE,
  INDEX `fk_section_term1_idx` (`term_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `university`.`course` (`course_id`),
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `university`.`faculty` (`faculty_id`),
  CONSTRAINT `fk_section_term1`
    FOREIGN KEY (`term_id`)
    REFERENCES `university`.`term` (`term_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`student` ;

CREATE TABLE IF NOT EXISTS `university`.`student` (
  `student_id` INT NOT NULL,
  `first_name` VARCHAR(25) NOT NULL,
  `last_name` VARCHAR(25) NOT NULL,
  `gender` ENUM('F', 'M') NOT NULL,
  `city` VARCHAR(25) NOT NULL,
  `state` VARCHAR(5) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `university`.`enrollment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `university`.`enrollment` ;

CREATE TABLE IF NOT EXISTS `university`.`enrollment` (
  `student_id` INT NOT NULL,
  `section_id` INT NOT NULL,
  PRIMARY KEY (`student_id`, `section_id`),
  INDEX `fk_student_has_section_section1_idx` (`section_id` ASC) VISIBLE,
  INDEX `fk_student_has_section_student_idx` (`student_id` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_section_section1`
    FOREIGN KEY (`section_id`)
    REFERENCES `university`.`section` (`section_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_student_has_section_student`
    FOREIGN KEY (`student_id`)
    REFERENCES `university`.`student` (`student_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;



USE university;
----------------- INSERT STATEMENTS --------------------


---- 1. Inserting values into student table
INSERT INTO student VALUES
(1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22'),
(2, 'Katie', 'Smith', 'F', 'Provo', 'UT', '1995-07-22'),
(3, 'Kelly', 'Jones', 'F', 'Provo', 'UT', '1998-07-22'),
(4, 'Devon', 'Merrill', 'M', 'Mesa', 'AZ', '2000-07-22'),
(5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22'),
(6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22'),
(7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22'),
(8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22'),
(9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22'),
(10, 'Susan', 'Sorensen', 'F', 'Mesa', 'AZ', '1998-08-09');


---- 2. Inserting values into Term

INSERT INTO term VALUES
(1, 2019, 'Fall'),
(2, 2018, 'Winter');


---- 3. Inserting values into faculty
INSERT INTO faculty VALUES
(1, 'Marty', 'Morring'),
(2, 'Nate', 'Nathan'),
(3, 'Ben', 'Barrus'),
(4, 'John', 'Jensen'),
(5, 'Bill', 'Barney');


---- 4. Inserting values into college
INSERT INTO college VALUES
(1, 'College of Physical Science and Engineering'),
(2, 'College of Business and Communication'),
(3, 'College of Business and Communication'),
(4, 'College of Language and Letters');


---- 5. Inserting values into department
INSERT INTO department VALUES
(1, 'Computer Information Technology', 'CIT', 1),
(2, 'Economics', 'ECON', 2),
(3, 'Economics', 'ECON', 3),
(4, 'Humanities and Philosophy', 'HUM', 4);


---- 6. Inserting values into courses
INSERT INTO course VALUES
(1, 'Intro to Databses', '111', 3, 1),
(2, 'Econometrics', '388', 4, 2),
(3, 'Micro Economics', '150', 3, 3),
(4, 'Classical Heritage', '376', 2, 4);


---- 7. Inserting values into section
INSERT INTO section VALUES
(1, 1, 30, 1, 1, 1), -- CIT 111 1 Fall
(2, 1, 50, 2, 3, 1), -- ECON 150 1 Fall
(3, 2, 50, 2, 3, 1), -- ECON 150 2 Fall
(4, 1, 35, 3, 2, 1), -- ECON 388 1 Fall
(5, 1, 30, 4, 4, 1), -- HUM 376 1 Fall
(6, 2, 30, 1, 1, 2), -- CIT 111 2 Winter
(7, 3, 35, 5, 1, 2), -- CIT 111 3 Winter
(8, 1, 50, 2, 3, 2), -- ECON 150 1 Winter
(9, 2, 50, 2, 3, 2), -- ECON 150 2 Winter
(10, 1, 30, 4, 4, 2); -- HUM 376 1 Winter

DELETE FROM section WHERE faculty_id = 5;
---- 8. Inserting values into enrollment
INSERT INTO enrollment VALUES
(1, 1),
(1, 3),
(2, 4),
(3, 4),
(4, 5),
(5, 4),
(5, 5),
(6, 7),
(7, 6),
(7, 8),
(7, 10),
(8, 9),
(9, 9),
(10, 6);


USE university;
---------------- QUERIES ------------------

---- Query 1: Format students birthdates
SELECT first_name AS fname, last_name AS lname, DATE_FORMAT(birthdate,'%M %d, %Y') AS 'Sept Birthdays'
FROM student
WHERE MONTH(birthdate) = 09;

---- Query 2: 
SELECT last_name AS lname, first_name AS fname, FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS 'Years',
    MOD(DATEDIFF('2017-01-05', birthdate), 365) AS 'Days',
    CONCAT(FLOOR(DATEDIFF('2017-01-05', birthdate) / 365),' ','-',' ','Yrs', ',', ' ' , MOD(DATEDIFF('2017-01-05', birthdate), 365), ' ','-',' Days') AS 'Years and Days'
FROM student
ORDER BY years DESC, days DESC;


---- Query 3
SELECT s.first_name AS fname, s.last_name AS lname
From enrollment e
JOIN student s
ON e.student_id = s.student_id
	JOIN section se
	ON e.section_id = se.section_id
		JOIN faculty f
        ON se.faculty_id = f.faculty_id
WHERE faculty_fname = 'John' AND faculty_lname = 'Jensen'
ORDER BY s.last_name; 


---- Query 4
SELECT f.faculty_fname AS fname, f.faculty_lname AS 'lname'
FROM enrollment e
JOIN student s
ON e.student_id = s.student_id
	JOIN section se
	ON e.section_id = se.section_id
		JOIN faculty f
        ON se.faculty_id = f.faculty_id
			JOIN term t
			ON t.term_id = se.term_id
WHERE s.first_name = 'Bryce' AND t.term = 'Winter' AND t.year = 2018
ORDER BY f.faculty_lname ASC;


---- Query 5
Select s.first_name AS fname, s.last_name AS lname
FROM student s
JOIN enrollment e
ON s.student_id = e.student_id
	JOIN section se
    ON e.section_id = se.section_id
		JOIN course c
        ON se.course_id = c.course_id
			JOIN term t
            ON se.term_id = t.term_id
WHERE c.course_title = 'Econometrics' AND t.term = 'Fall' AND t.year = 2019
ORDER BY s.last_name ASC;


----- Query 6
SELECT department_code, course_num, course_title AS 'name'
FROM enrollment e
JOIN section se
ON e.section_id = se.section_id
	JOIN course c
    ON c.course_id = se.course_id
		JOIN department d
		ON c.department_id = d.department_id
			JOIN term t
            ON se.term_id = t.term_id
				JOIN student s
				ON e.student_id = s.student_id
WHERE s.first_name = 'Bryce' AND s.last_name = 'Carlson' AND t.term = 'Winter' AND t.year = 2018
ORDER BY course_title ASC;

    
---- Query 7
SELECT term, year, COUNT(*) As 'Enrollment'
FROM enrollment e
JOIN section se
ON e.section_id = se.section_id
	JOIN term t
    ON se.term_id = t.term_id
WHERE t.term = 'Fall' AND t.year = 2019;


---- Query 8
SELECT co.college AS 'Colleges', COUNT(DISTINCT c.course_id) AS 'Courses'
FROM section se
LEFT JOIN course c
ON se.course_id = c.course_id
	LEFT JOIN department d
    ON d.department_id = c.department_id
		LEFT JOIN college co
        ON co.college_id = d.college_id
GROUP BY college
ORDER BY COUNT(c.course_id) DESC;

---- Query 9
SELECT f.faculty_fname AS 'fname', f.faculty_lname AS 'lname', SUM(se.capacity) AS 'TeachingCapacity'
FROM faculty f
LEFT JOIN section se 
ON se.faculty_id = f.faculty_id
	JOIN term t 
    ON se.term_id = t.term_id
WHERE t.term = 'Winter' AND t.year = 2018
GROUP BY f.faculty_fname, f.faculty_lname
ORDER BY SUM(se.capacity) ASC;


---- Query 10
SELECT last_name AS 'lname', first_name AS 'fname', SUM(c.credit) AS 'Credits'
FROM enrollment e
JOIN student s
ON e.student_id = s.student_id
	JOIN section se
    ON e.section_id = se.section_id
		JOIN course c
        ON se.course_id = c.course_id
			JOIN term t
            ON se.term_id = t.term_id
WHERE t.term = 'Fall' AND t.year = 2019
Group BY s.last_name, s.first_name
HAVING  SUM(c.credit) > 3
ORDER BY SUM(c.credit) DESC;






