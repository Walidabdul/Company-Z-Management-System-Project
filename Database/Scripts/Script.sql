CREATE DATABASE employeeData;


USE employeeData;

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    date_of_birth DATETIME NOT NULL,
    gender ENUM('M', 'F', 'X') DEFAULT 'X',
    contact_number VARCHAR(20),
    email_address VARCHAR(255),
    admission_year INT,
    department_id INT
);

CREATE TABLE Departments (
    department_id INT NOT NULL PRIMARY KEY,
    department_name VARCHAR(255),
    college_id INT
);


CREATE TABLE Enrollments (
    enrollment_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester INT,
    year INT,
    grade VARCHAR(3)
);


CREATE TABLE Courses (
    course_id INT NOT NULL PRIMARY KEY,
    course_name VARCHAR(255),
    course_code VARCHAR(20),
    department_id INT,
    credit_hours INT
);


CREATE TABLE employees (
  empid INT NOT NULL AUTO_INCREMENT,
  Fname VARCHAR(65) NOT NULL,
  Lname VARCHAR(65) NOT NULL,
  email VARCHAR(65) NOT NULL,
  HireDate DATE,
  Salary DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (empid)
);

/***********************************************************************/

CREATE TABLE payroll (
  payID INT,
  pay_date DATE,
  earnings DECIMAL(8,2),
  fed_tax DECIMAL(7,2),
  fed_med DECIMAL(7,2),
  fed_SS DECIMAL(7,2),
  state_tax DECIMAL(7,2),
  retire_401k DECIMAL(7,2),
  health_care DECIMAL(7,2),
  empid INT,
  INDEX payID_IDX (payID),
  INDEX emp_indx (empid),
  FOREIGN KEY (empid) REFERENCES employees(empid)
);

/***********************************************************************/ 

CREATE TABLE employee_job_titles (
  empid INT NOT NULL,
  job_title_id INT NOT NULL,
  PRIMARY KEY (empid),
  INDEX job_title_IDX (job_title_id),
  FOREIGN KEY (empid) REFERENCES employees(empid)
);

/***********************************************************************/ 

CREATE TABLE job_titles (
  job_title_id INT,
  job_title VARCHAR(125) NOT NULL,
  PRIMARY KEY (job_title_id),
  FOREIGN KEY (job_title_id) REFERENCES employee_job_titles(job_title_id)
);

/***********************************************************************/ 

CREATE TABLE employee_division (
  empid int NOT NULL,
  div_ID int NOT NULL,
  PRIMARY KEY (empid),
  INDEX div_ID_IDX (div_ID),
  FOREIGN KEY (empid) REFERENCES employees(empid)
) COMMENT='links employee to a division';

/***********************************************************************/


CREATE TABLE division (
  ID int NOT NULL,
  Name varchar(100) DEFAULT NULL,
  city varchar(50) NOT NULL,
  addressLine1 varchar(50) NOT NULL,
  addressLine2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postalCode varchar(15) NOT NULL,
  INDEX ID_IDX (ID),
  FOREIGN KEY (ID) REFERENCES employee_division(div_ID)
) COMMENT='company divisions';

/***********************************************************************/

create table address(
	empid INT not null,
	primary key (empid),
	addressLine1 varchar(50) not null,
	addressLine2 varchar(50) default null,
	city varchar(50) not null,
	state varchar(50) default null,
	index city_IDX (city),
	index state_IDX (state),
	foreign key (empid) references employees(empid)
);
create table demographics (
	gender ENUM('M', 'F', 'X') not null default 'x',
	pronouns varchar(6)not null, 
	race varchar(100) not null,
	dateOfBirth int not null,
	phoneNum int not null
);


SET FOREIGN_KEY_CHECKS=0;


INSERT INTO job_titles (job_title_id,job_title)
VALUES 
(100,'software manager'),
(101,'software architect'),
(102,'software engineer'),
(103,'software developer'),
(200,'marketing manager'),
(201,'marketing associate'),
(202,'marketing assistant'),
(900,'Chief Exec. Officer'),
(901,'Chief Finn. Officer'),
(902,'Chief Info. Officer');

INSERT INTO employees (Fname, Lname, email, HireDate, Salary)
VALUES 
('Snoopy', 'Beagle', 	'Snoopy@example.com', 	'2022-08-01', 45000.00),
('Charlie', 'Brown', 	'Charlie@example.com', 	'2022-07-01', 48000.00),
('Lucy', 'Doctor', 		'Lucy@example.com', 	'2022-07-03', 55000.00),
('Pepermint', 'Patti', 	'Peppermint@example.com', '2022-08-02', 98000.00),
('Linus', 'Blanket', 	'Linus@example.com', 	'2022-09-01', 43000.00),
('PigPin', 'Dusty', 	'PigPin@example.com', 	'2022-10-01', 33000.00),
('Scooby', 'Doo', 		'Scooby@example.com', 	'1973-07-03', 78000.00),
('Shaggy', 'Rodgers', 	'Shaggy@example.com', 	'1973-07-11', 77000.00),
('Velma', 'Dinkley', 	'Velma@example.com', 	'1973-07-21', 82000.00),
('Daphne', 'Blake', 	'Daphne@example.com', 	'1973-07-30', 59000.00),
('Bugs', 'Bunny', 		'Bugs@example.com', 	'1934-07-01', 18000.00),
('Daffy', 'Duck', 		'Daffy@example.com', 	'1935-04-01', 16000.00),
('Porky', 'Pig', 		'Porky@example.com', 	'1935-08-12', 16550.00),
('Elmer', 'Fudd', 		'Elmer@example.com', 	'1934-08-01', 15500.00),
('Marvin', 'Martian', 	'Marvin@example.com', 	'1937-05-01', 28000.00);

INSERT INTO payroll (payID, pay_date, empid, earnings, fed_tax, fed_med, fed_SS, state_tax, retire_401k, health_care)
SELECT 
	1,
	'2023-11-30', 
	empid, 
	salary/52.0, 
	(salary/52.0)*0.32, 
	(salary/52.0)*0.0145,
	(salary/52.0)*0.062,
	(salary/52.0)*0.12,
	(salary/52.0)*0.004,
	(salary/52.0)*0.031
FROM employees;

INSERT INTO payroll (payID, pay_date, empid, earnings, fed_tax, fed_med, fed_SS, state_tax, retire_401k, health_care)
SELECT 
	2,
	'2023-12-31', 
	empid, 
	salary/52.0, 
	(salary/52.0)*0.32, 
	(salary/52.0)*0.0145, 
	(salary/52.0)*0.062,
	(salary/52.0)*0.12,
	(salary/52.0)*0.004,
	(salary/52.0)*0.031 
FROM employees;

INSERT INTO employee_division (empid, div_ID)
VALUES(1,999),
      (2,999),
      (3,999),
      (7,1),
      (10,1);

INSERT INTO division (ID, Name, city, addressLine1, addressLine2, state, country, postalCode) 
VALUES(1,'Technology Engineering', 'Atlanta', '200 17th Street NW', '', 'GA', 'USA', '30363'),
		(2,'Marketing', 'Atlanta', '200 17th Street NW', '', 'GA', 'USA', '30363'),
		(3,'Human Resources','New York', '45 West 57th Street', '', 'NY', 'USA', '00034'),
		(999,'HQ','New York', '45 West 57th Street', '', 'NY', 'USA', '00034');
			
INSERT INTO employee_job_titles (empid, job_title_id)
VALUES(1,902),
(2,900),
(3,901),
(4,102),
(5,101),
(6,201),
(7,100),
(8,102),
(9,102),
(10,102),
(11,200),
(12,201),
(13,202),
(14,103),
(15, 103);


