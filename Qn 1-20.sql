-- 1. Select all employees from Engineering department.
SELECT * FROM Employees WHERE department_id = 101;


-- 2. Find employees who joined after 2018.
SELECT first_name, last_name, hire_date FROM Employees WHERE hire_date > '2018-12-31';


-- 3. List employees with salary greater than 70,000.
SELECT first_name, last_name, salary FROM Employees WHERE salary > 70000;


-- 4. Show distinct job titles in the company.
SELECT DISTINCT job_title FROM Employees;


-- 5. Sort employees by hire_date (earliest first).
SELECT first_name, last_name, hire_date FROM Employees ORDER BY hire_date ASC;


-- 6. Find the average salary of each department.
SELECT d.department_name, AVG(e.salary) AS avg_salary FROM Employees e JOIN Departments d ON e.department_id = d.department_id GROUP BY d.department_name;


-- 7. List employees along with their department name.
SELECT e.first_name, e.last_name, d.department_name FROM Employees e JOIN Departments d ON e.department_id = d.department_id;


-- 8. Find the highest paid employee in Data Science.
SELECT first_name, last_name, salary FROM Employees WHERE department_id = 102 ORDER BY salary DESC LIMIT 1;


-- 9. Count how many employees each manager supervises.
SELECT manager_id, COUNT(*) AS num_employees FROM Employees WHERE manager_id IS NOT NULL GROUP BY manager_id;


-- 10. Show employees working in projects with a budget over 200,000.
SELECT e.first_name, e.last_name, p.project_name, p.budget FROM Employees e JOIN Departments d ON e.department_id = d.department_id JOIN Projects p ON d.department_id = p.department_id WHERE p.budget > 200000;

-- 11. Find employees whose salary is above the company average.
SELECT first_name, last_name, salary FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);

-- 12. List departments that have more than 2 employees.
SELECT d.department_name, COUNT(e.employee_id) AS emp_count FROM Employees e JOIN Departments d ON e.department_id = d.department_id GROUP BY d.department_name HAVING COUNT(e.employee_id) > 2;


-- 13. Show employees who do not manage anyone.
SELECT e.employee_id, e.first_name, e.last_name FROM Employees e WHERE e.employee_id NOT IN (SELECT DISTINCT manager_id FROM Employees WHERE manager_id IS NOT NULL);


-- 14. Find employees who are not assigned to any project.
SELECT e.first_name, e.last_name FROM Employees e LEFT JOIN Projects p ON e.department_id = p.department_id WHERE p.project_id IS NULL;

-- 15. Get the 2nd highest salary in the company.
SELECT DISTINCT salary FROM Employees ORDER BY salary DESC LIMIT 1 OFFSET 1;


-- 16. Rank employees within each department by salary.
SELECT e.first_name, e.last_name, d.department_name, e.salary, RANK() OVER (PARTITION BY e.department_id ORDER BY e.salary DESC) AS salary_rank FROM Employees e JOIN Departments d ON e.department_id = d.department_id;


-- 17. Find the top 3 highest paid employees in the company.
SELECT first_name, last_name, salary FROM (SELECT e.*, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk FROM Employees e) t WHERE rnk <= 3;


-- 18. Show cumulative salary expense ordered by hire_date.
SELECT first_name, last_name, hire_date, salary, SUM(salary) OVER (ORDER BY hire_date) AS running_total FROM Employees;


-- 19. Find departments where average salary is higher than the overall company average.
WITH company_avg AS (SELECT AVG(salary) AS avg_salary FROM Employees) SELECT d.department_name, AVG(e.salary) AS dept_avg FROM Employees e JOIN Departments d ON e.department_id = d.department_id GROUP BY d.department_name HAVING AVG(e.salary) > (SELECT avg_salary FROM company_avg);


-- 20. List employees with their manager’s name.
SELECT e.first_name AS employee, m.first_name AS manager FROM Employees e LEFT JOIN Employees m ON e.manager_id = m.employee_id;
