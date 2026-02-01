-- 41. Show the longest running project.
SELECT project_name, DATEDIFF(end_date, start_date) AS duration_days
FROM Projects
ORDER BY duration_days DESC LIMIT 1;


-- 42. Get departments sorted by average salary (descending).
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;


-- 43. Find employees who earn more than their manager.
SELECT e.first_name, e.last_name, e.salary, m.first_name AS manager, m.salary AS manager_salary
FROM Employees e
JOIN Employees m ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;


-- 44. List projects with no end date (ongoing projects).
SELECT project_name FROM Projects WHERE end_date IS NULL;


-- 45. Show total salary expense per year based on hire_date.
SELECT YEAR(hire_date) AS year, SUM(salary) AS total_salary
FROM Employees
GROUP BY YEAR(hire_date)
ORDER BY year;


-- 46. Find the difference between highest and lowest salary in the company.
SELECT MAX(salary) - MIN(salary) AS salary_difference FROM Employees;


-- 47. Retrieve employees ranked by salary across the company.
SELECT first_name, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS rank_in_company
FROM Employees;


-- 48. Show employees hired in each department, ordered by hire_date.
SELECT d.department_name, e.first_name, e.last_name, e.hire_date
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
ORDER BY d.department_name, e.hire_date;


-- 49. Find the project with the smallest budget.
SELECT project_name, budget FROM Projects ORDER BY budget ASC LIMIT 1;


-- 50. Get employees with salaries above their department’s average.
SELECT e.first_name, e.last_name, e.salary, d.department_name
FROM Employees e
JOIN Departments d ON e.department_id = d.department_id
WHERE e.salary > (
    SELECT AVG(salary) FROM Employees WHERE department_id = e.department_id
);
