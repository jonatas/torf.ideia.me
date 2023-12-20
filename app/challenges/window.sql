DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);

INSERT INTO employees (name, department, salary) VALUES
('Alice', 'Engineering', 70000),
('Bob', 'Engineering', 60000),
('Charlie', 'HR', 50000),
('David', 'HR', 55000),
('Eve', 'Marketing', 60000);

-- Asserts that the total salary is 295000.
select sum(salary) over() = 295000 from employees limit 1;

-- Asserts that the average salary in Engineering is 65000.
select avg(salary) over(partition by department) = 65000 
from employees where department = 'Engineering' limit 1;

-- Asserts that David is 2nd in HR department.
select row_number() over(partition by department order by name) = 2 
from employees where name = 'David' limit 1;

-- Asserts that Eve is ranked 1st in Marketing.
select rank() over(partition by department order by salary desc) = 1 
from employees where name = 'Eve' limit 1;

-- Asserts the highest salary in Engineering is 70000.
select first_value(salary) over(partition by department order by salary desc) = 70000 
from employees where department = 'Engineering' limit 1;

-- Asserts Charlie's percentile rank in HR is 0.
select percent_rank() over(partition by department order by salary) = 0 
from employees where name = 'Charlie' limit 1;

-- Asserts Bob is in 2nd quartile in Engineering.
select ntile(4) over(partition by department order by salary) = 2 
from employees where name = 'Bob' limit 1;

-- Asserts Alice's cumulative distribution in Engineering is 1.
select cume_dist() over(partition by department order by salary) = 1 
from employees where name = 'Alice' limit 1;

-- Asserts the lowest salary in HR is 50000.
select last_value(salary) over(partition by department order by salary range between unbounded preceding and unbounded following) = 50000 
from employees where department = 'HR' limit 1;

-- Asserts the sum of salaries in HR is 105000.
select sum(salary) over(partition by department) = 105000 
from employees where department = 'HR' limit 1;

