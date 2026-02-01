-- Questions 21–50


-- 21. Retrieve the total salary paid by each department.
SELECT d.department_name, SUM(e.salary) AS total_salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 22. Find employees hired in the year 2020.
SELECT first_name, last_name, hire_date
FROM Employees
WHERE YEAR(hire_date) = 2020;


-- 23. List employees whose name starts with 'J'.
SELECT first_name, last_name FROM Employees WHERE first_name LIKE 'J%';


-- 24. Get employees who earn between 50,000 and 90,000.
SELECT first_name, last_name, salary FROM Employees WHERE salary BETWEEN 50000 AND 90000;


-- 25. Show department name and number of projects handled by each.
SELECT d.department_name, COUNT(p.project_id) AS project_count
FROM Departments d
LEFT JOIN Projects p ON d.department_id = p.department_id
GROUP BY d.department_name;


-- 26. Find projects that ended before 2021.
SELECT project_name, end_date FROM Projects WHERE end_date < '2021-01-01';


-- 27. Show employees who joined before their manager.
SELECT e.first_name, e.last_name, e.hire_date, m.first_name AS manager, m.hire_date AS manager_hire
FROM Employees e
JOIN Employees m ON e.manager_id = m.employee_id
WHERE e.hire_date < m.hire_date;


-- 28. Find the minimum and maximum salary in each department.
SELECT d.department_name, MIN(e.salary) AS min_salary, MAX(e.salary) AS max_salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.department_name;


-- 29. Show employees with the same job title.
SELECT job_title, COUNT(*) AS count FROM Employees GROUP BY job_title HAVING COUNT(*) > 1;


-- 30. Retrieve employees hired in the last 3 years.
SELECT first_name, last_name, hire_date FROM Employees WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 3 YEAR);


-- 31. Find employees working on projects starting in 2021.
SELECT DISTINCT e.first_name, e.last_name, p.project_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
JOIN Projects p ON d.department_id = p.department_id
WHERE YEAR(p.start_date) = 2021;


-- 32. Show managers who earn less than some of their team members.
SELECT DISTINCT m.first_name, m.last_name, m.salary
FROM Employees m
JOIN Employees e ON m.employee_id = e.manager_id
WHERE m.salary < e.salary;


-- 33. Find departments that don’t have any projects.
SELECT d.department_name
FROM Departments d
LEFT JOIN Projects p ON d.department_id = p.department_id
WHERE p.project_id IS NULL;


-- 34. Show employees who work in more than one project (if project assignments were tracked by department).
SELECT e.first_name, e.last_name, COUNT(p.project_id) AS project_count
FROM Employees e
JOIN Projects p ON e.department_id = p.department_id
GROUP BY e.employee_id
HAVING COUNT(p.project_id) > 1;


-- 35. Get employees whose salary is equal to the department average.
SELECT e.first_name, e.last_name, e.salary, d.department_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT AVG(salary) FROM Employees WHERE department_id = e.department_id
);


-- 36. Find the project with the largest budget.
SELECT project_name, budget FROM Projects ORDER BY budget DESC LIMIT 1;


-- 37. Show departments and their highest paid employee.
SELECT d.department_name, e.first_name, e.last_name, e.salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE e.salary = (
    SELECT MAX(salary) FROM Employees WHERE department_id = d.department_id
);

-- 38. Find employees who joined in the same year as their manager.
SELECT e.first_name, e.last_name, m.first_name AS manager
FROM Employees e
JOIN Employees m ON e.manager_id = m.employee_id
WHERE YEAR(e.hire_date) = YEAR(m.hire_date);

-- 39. Get the average project budget by year.
SELECT YEAR(start_date) AS year, AVG(budget) AS avg_budget
FROM Projects
GROUP BY YEAR(start_date);


-- 40. List all employees and indicate whether they are a manager or not.
SELECT e.first_name, e.last_name,
       CASE WHEN EXISTS (SELECT 1 FROM Employees WHERE manager_id = e.employee_id)
            THEN 'Manager' ELSE 'Employee' END AS role
FROM Employees e;


