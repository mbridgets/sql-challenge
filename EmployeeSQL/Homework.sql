-- DROP TABLE departments, dept_emp, dept_manager, employees, salaries, titles

CREATE TABLE departments (
	dept_no VARCHAR(50),
	dept_name VARCHAR(50),
	PRIMARY KEY (dept_no)
);

CREATE TABLE dept_emp (
	emp_no VARCHAR(50),
	dept_no VARCHAR(50),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no) 
);

CREATE TABLE dept_manager (
	dept_no VARCHAR(50),
	emp_no VARCHAR(50),
	PRIMARY KEY(emp_no)
);

CREATE TABLE titles (
	title_id VARCHAR(50),
	title VARCHAR(50),
	PRIMARY KEY (title_id)
);

CREATE TABLE employees (
	emp_no VARCHAR(50),
	emp_title VARCHAR(50),
	birth_date DATE,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	sex VARCHAR(50),
	hire_date DATE,
	PRIMARY KEY (emp_no),
	FOREIGN KEY(emp_title) REFERENCES titles(title_id)
);

CREATE TABLE salaries (
	emp_no VARCHAR(50),
	salary  VARCHAR(50),
	PRIMARY KEY (emp_no)
);

-- DROP TABLE dept_manager;

-- List the following details of each employee: 
-- employee number, last name, first name, sex, and salary.

-- SELECT * FROM employees LEFT JOIN dept_manager ON employees.emp_no = dept_manager.emp_no


SELECT employees.emp_no AS "Employee Number", last_name AS "Last Name", first_name AS "First Name",
sex AS "Sex", salary AS "Salaries" FROM employees JOIN salaries 
ON salaries.emp_no = employees.emp_no;

-- List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name AS "First Name", last_name AS "Last Name", hire_date AS "Hire Date"  FROM employees 
WHERE hire_date BETWEEN '$01/01/1986' AND '$12/31/1986';

-- List the manager of each department with the following information: 
-- department number, department name, the manager's employee number, 
-- last name, first name.

-- need to use dept_no and dept_name from department, dept_no and emp_no from dept_manager and emp_no first_name and last_name from employees

SELECT departments.dept_no AS "Department Number", departments.dept_name AS "Department Name", 
dept_manager.emp_no AS "Employee Number", employees.first_name AS "First Name", 
employees.last_name AS "Last Name" FROM dept_manager
INNER JOIN departments ON departments.dept_no = dept_manager.dept_no
INNER JOIN employees ON employees.emp_no = dept_manager.emp_no;

-- List the department of each employee with the following information: 
-- employee number, last name, first name, and department name.

SELECT dept_emp.emp_no AS "Employee Number", employees.last_name AS "Last Name", 
employees.first_name AS "First Name", departments.dept_name AS "Department Name" FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON departments.dept_no = dept_emp.dept_no;

-- List first name, last name, and sex for employees whose 
-- first name is "Hercules" and last names begin with "B."

SELECT first_name AS "First Name", last_name AS "Last Name", sex AS "Sex" FROM employees
WHERE first_name = 'Hercules' AND
last_name LIKE 'B%';

-- List all employees in the Sales department, including their employee number, 
-- last name, first name, and department name.
SELECT employees.emp_no AS "Employee Number", employees.last_name AS "Last Name", 
employees.first_name AS "First Name", departments.dept_name AS "Department Name"
FROM employees INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no 
WHERE dept_name = 'Sales';

-- List all employees in the Sales and Development departments, including their 
-- employee number, last name, first name, and department name.
SELECT employees.emp_no AS "Employee Number", employees.last_name AS "Last Name", 
employees.first_name AS "First Name", departments.dept_name AS "Department Name"
FROM employees INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN departments ON dept_emp.dept_no = departments.dept_no 
WHERE dept_name = 'Sales' OR dept_name = 'Development';


-- In descending order, list the frequency count of employee last names, i.e., 
-- how many employees share each last name.

SELECT last_name AS "Last Name", COUNT(last_name) AS "Last Name Count" FROM employees
GROUP BY last_name;






