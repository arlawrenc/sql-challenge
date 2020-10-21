
drop table if exists dept_emp;
drop table if exists employees;
drop table if exists dept_managers;
drop table if exists salaries;
drop table if exists titles;
drop table if exists departments;
				
create table departments (
	dept_no varchar(30) primary key,
	dept_name varchar (30)
);

create table titles (
	title_id varchar(30) primary key,
	title varchar (30)
);

create table employees (
	emp_no varchar(30) primary key,
	emp_title_id varchar (30) REFERENCES titles(title_id),
	birth_date varchar (30),
	first_name varchar (30),
	last_name varchar (30),
	sex varchar (30), 
	hire_date varchar (30)
);

create table salaries (
	emp_no varchar(30) references employees(emp_no),
	salary varchar (30)
);
	
create table dept_manager (
	dept_no varchar(30) references departments(dept_no),
	emp_no varchar (30) references employees(emp_no)
);
			
create table dept_emp(
	emp_no varchar(30) references employees(emp_no),
	dept_no varchar (30) references departments(dept_no)
);

-- order to insert
--departments, titles, employees, dept_emp, dept_managers, salaries;

--1. List the following details of each employee: employee number, last name, first name, sex, and salary.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary
from employees as e inner join salaries as s on e.emp_no=s.emp_no;

--2. List first name, last name, and hire date for employees who were hired in 1986.
select last_name, first_name, hire_date 
from employees where DATE(hire_date)>= '1986/1/1' and DATE(hire_date)<= '1986/12/31';

--3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
select m.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
	from employees as e 
	inner join dept_manager as m on e.emp_no=m.emp_no
	inner join departments as d on d.dept_no=m.dept_no;
	
--4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name
	from dept_emp as de 
	inner join employees as e on de.emp_no=e.emp_no
	inner join departments as d on d.dept_no=de.dept_no;

--5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."

select first_name, last_name, sex
from employees where first_name ='Hercules' and last_name LIKE 'B%';

6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
select e.emp_no, e.last_name, e.first_name, d.dept_name
	from departments as d 
	inner join dept_emp as de on d.dept_no=de.dept_no
	inner join employees as e on de.emp_no=e.emp_no
	where dept_name='Sales';
	
--7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name
	from employees as e
	inner join dept_emp as de on e.emp_no=de.emp_no
	inner join departments as d on de.dept_no=d.dept_no
	where dept_name='Sales' or dept_name='Development';

--8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.

select 
	count(*) as cnt, last_name
from 
	employees
group by last_name
order by cnt desc;