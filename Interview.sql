CREATE DATABASE Research;

USE Research;

DROP DATABASE Research;

Select * from Employees;
Select * from Projects;
Select * from Departments;


CREATE TABLE Departments (
department_id INT PRIMARY KEY,
department_name VARCHAR (50));

INSERT INTO Departments (department_id, department_name) VALUES
(101, 'Engineering'),
(102, 'Data Science'),
(103,'Human Resources');

CREATE TABLE Employees (
	employee_id INT PRIMARY KEY,
	first_name VARCHAR (50),
	last_name VARCHAR (50),
	department_id INT, hire_date DATE,
	job_title VARCHAR (50),
	salary DECIMAL (10,2),
	manager_id INT NULL,
	FOREIGN KEY (department_id) REFERENCES Departments (department_id)
);


INSERT INTO Employees VALUES
(1, 'John', 'Smith', 101, '2018-03-15', 'Software Engineer', 60000, 5),
(2, 'Sarah', 'Johnson', 102, '2019-07-01', 'Data Analyst', 55000, 6),
(3, 'Michael', 'Brown', 101, '2017-11-20', 'Senior Engineer', 80000, 5),
(4, 'Emily', 'Davis', 103, '2020-05-18', 'HR Specialist', 50000, 7),
(5, 'David', 'Wilson', 102, '2016-02-25', 'Engineering Mgr', 105000, NULL),
(6, 'Linda', 'Martinez', 101, '2015-01-10', 'Data Science Mgr', 95000, NULL),
(7, 'James', 'Anderson', 103, '2014-09-12', 'HR Manager', 90000, NULL),
(8, 'Robert', 'Taylor', 101, '2021-08-09', 'Intern', 30000, 5);





CREATE TABLE Projects (
	project_id INT PRIMARY KEY,
    project_name VARCHAR (100),
    department_id INT,
    budget DECIMAL (10,2),
    start_date DATE,
    end_date DATE,
	FOREIGN KEY (department_id) REFERENCES Departments (department_id)
);



INSERT INTO Projects VALUES
(201, 'AI Chatbot', 102, 200000, '2021-01-01', '2021-12-31'),
(202, 'Mobile App', 101, 150000, '2020-06-01', '2021-06-01'),
(203, 'Recruitment Drive', 103, 80000, '2021-03-01', '2021-09-01'),
(204, 'Cloud Migration', 101, 300000, '2019-04-01', '2022-04-01');








