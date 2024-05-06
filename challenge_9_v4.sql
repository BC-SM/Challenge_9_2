CREATE TABLE employees (
  emp_no INT PRIMARY KEY, 
  emp_title_id VARCHAR,
  birth_date Date,
  first_name VARCHAR,
  last_name VARCHAR,
  sex VARCHAR, 
  hire_date DATE
);

SELECT * 
FROM employees; 

CREATE TABLE titles (
  title_id VARCHAR PRIMARY KEY, 
  title VARCHAR
);

SELECT * 
FROM titles;

CREATE TABLE departments (
  dept_no VARCHAR PRIMARY KEY, 
  dept_name VARCHAR
);

SELECT * 
FROM departments;

CREATE TABLE dept_manager (
	dept_no VARCHAR NOT NULL,
    emp_no INT   NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (dept_no, emp_no)
);

SELECT * 
FROM dept_manager;

CREATE TABLE dept_emp (
    emp_no INT   NOT NULL,
	dept_no VARCHAR NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    PRIMARY KEY (emp_no, dept_no)
);

SELECT * 
FROM dept_emp;

CREATE TABLE salaries (
    emp_no INT NOT NULL,
	salary INT NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    PRIMARY KEY (emp_no)
);

SELECT * 
FROM salaries;

--List the employee number, last name, first name, sex, and salary of each employee (2 points)
SELECT employees.emp_no, employees.last_name, employees.hire_date, employees.sex, salaries.salary
FROM employees 
INNER JOIN salaries ON 
salaries.emp_no=employees.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986 (2 points)
SELECT employees.first_name, employees.last_name, employees.hire_date
FROM employees 
WHERE employees.hire_date = '1986-01-01';

--List the manager of each department along with their department number, department name, employee number, last name, and first name (2 points)
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no=employees.emp_no
INNER JOIN departments ON dept_manager.dept_no=departments.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, and department name (2 points)
SELECT departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no=employees.emp_no
INNER JOIN departments ON dept_manager.dept_no=departments.dept_no;

--List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B (2 points)
SELECT employees.first_name, employees.last_name, employees.sex
FROM employees 
WHERE employees.first_name = 'Hercules' AND employees.last_name = 'B';

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no=employees.emp_no
INNER JOIN departments ON dept_manager.dept_no=departments.dept_no
WHERE departments.dept_name = 'Sales';

--List each employee in the Sales department, including their employee number, last name, and first name (2 points)
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no=employees.emp_no
INNER JOIN departments ON dept_manager.dept_no=departments.dept_no
WHERE departments.dept_name = 'Sales' AND departments.dept_name;


--List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name (4 points)
SELECT dept_manager.emp_no, dept_manager.dept_no, departments.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
FROM dept_manager
INNER JOIN employees ON dept_manager.emp_no=employees.emp_no
INNER JOIN departments ON dept_manager.dept_no=departments.dept_no
WHERE departments.dept_name = 'Sales' OR departments.dept_name = 'Development';


--List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name) (4 points)
SELECT employees.last_name, COUNT(employees.last_name) AS count 
FROM employees 
GROUP BY employees.last_name
ORDER BY count DESC

