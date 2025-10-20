
SELECT * FROM employees;
SELECT * FROM departments;

-- Shows which departments have the most employees.

SELECT d.department_name, 
       COUNT(e.employee_id) AS total_employees
FROM employees e
JOIN departments d ON 
e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_employees DESC;

-- Average salary per department
SELECT d.department_name,
       ROUND(AVG(e.salary), 1) AS avg_salary
FROM employees e
JOIN departments d ON 
e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- Department managers and their departments
SELECT d.department_name, 
       e.first_name || ',' || e.last_name AS manager_name
FROM employees e
JOIN departments d ON 
e.manager_id = d.manager_id;

-- Total salary expense per department
SELECT d.department_name,
       ROUND(SUM(e.salary),0) AS total_salary_cost
FROM employees e
JOIN departments d 
ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_salary_cost DESC;

--Employees by country and city
SELECT 
      c.country_name,
	  l.city,
	  count(e.employee_id) AS total_employees
FROM employees e
JOIN departments d ON e.department_id = d.department_id
JOIN locations l ON d.location_id = l.location_id
JOIN countries c ON l.country_id = c.country_id
GROUP BY c.country_name, l.city
ORDER BY total_employees DESC;

-- employee previous job history (previous role)
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
    jh.start_date,
    jh.end_date,
    j.job_title AS old_job
FROM job_history jh
JOIN employees e ON jh.employee_id = e.employee_id
JOIN jobs j ON jh.job_id = j.job_id
ORDER BY jh.start_date DESC;

-- Highest and lowest paid employees by job

SELECT j.job_title,
       MAX(e.salary) AS high_salary,
	   MIN(e.salary) AS min_salary
FROM employees e
JOIN jobs j 
ON e.job_id = j.job_id
GROUP BY j.job_title
ORDER BY high_salary DESC;

--Employees with their manager names
SELECT e.first_name || ' ' || e.last_name AS employee_name,
       m.first_name || ' ' || m.last_name AS manager_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY manager_name NULLS LAST;

-- Employee tenure (in years)
SELECT 
    e.first_name || ' ' || e.last_name AS employee_name,
	EXTRACT(YEAR FROM AGE(CURRENT_DATE, e.hire_date)) AS tenure
FROM employees e
order by tenure desc;


--Job count by department
SELECT 
    d.department_name,
    COUNT(DISTINCT e.job_id) AS distinct_jobs
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY distinct_jobs DESC;


SELECT * FROM employees;
create view emp as SELECT * FROM employees;

SELECT * FROM emp;

--creating column month, week, year
SELECT employee_id,
       first_name, 
	   last_name,
	   salary,
	   hire_date,
	   TO_CHAR(hire_date, 'Mon') AS month,
	   TO_CHAR(hire_date, 'ww') AS week_num,
	   'week ' || TO_CHAR(hire_date, 'w') AS week_of_month,
	   TO_CHAR(hire_date, 'yyyy') AS year
FROM employees
ORDER BY hire_date;

--comparison of the particular month
SELECT e.first_name || ' ' || e.last_name AS employee_full_name,
       TO_CHAR(e.hire_date, 'Mon') AS month,
	   SUM(CASE WHEN EXTRACT(year FROM e.hire_date) = EXTRACT(YEAR FROM current_date) - 2 THEN e.salary ELSE 0 END) AS y_2023,
	   SUM(CASE WHEN EXTRACT(YEAR FROM e.hire_date) = EXTRACT(YEAR FROM CURRENT_DATE) -1 THEN e.salary ELSE 0 END) AS y_2024,
	   SUM(CASE WHEN EXTRACT(YEAR FROM e.hire_date) = EXTRACT(YEAR FROM CURRENT_DATE) THEN e.salary ELSE 0 END) AS y_2025
FROM employees e
WHERE EXTRACT (YEAR FROM e.hire_date) >= EXTRACT(YEAR FROM CURRENT_DATE) -2 
GROUP BY employee_full_name, month
ORDER BY y_2023 DESC, y_2024 DESC, y_2025 DESC;


-- comparison over years
SELECT 
    e.first_name || ' ' || e.last_name AS employee_full_name,
	TO_CHAR(e.hire_date, 'Mon') AS month,
	EXTRACT(YEAR FROM e.hire_date) AS hire_year,
	SUM(e.salary) AS total_salary
FROM employees e
GROUP BY employee_full_name, month, hire_year
ORDER BY total_salary;


-- need the year of 2008 second quarter top 3  total salary holder for the employees 
SELECT 
    e.first_name || ' ' || e.last_name AS employee_full_name,
	SUM(e.salary) AS total_salary
FROM employees e
WHERE EXTRACT(YEAR FROM hire_date) = 2008
 AND  EXTRACT(QUARTER FROM hire_date) = 2
GROUP BY employee_full_name
ORDER BY total_salary DESC;


	  




