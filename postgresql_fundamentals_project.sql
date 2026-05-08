/* ============================================================
   POSTGRESQL PRACTICE SETUP: TABLES + MESSY DATA
   ============================================================ */

/* ---------- CLEANUP (run first) ---------- */
DROP TABLE IF EXISTS project_assignments CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS employees CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS departments CASCADE;


/* ---------- TABLES ---------- */

CREATE TABLE departments (
  dept_id   INTEGER PRIMARY KEY,
  dept_name TEXT NOT NULL UNIQUE
);

CREATE TABLE customers (
  customer_id   INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL,
  email         TEXT UNIQUE,
  city          TEXT
);

CREATE TABLE orders (
  order_id    INTEGER PRIMARY KEY,
  customer_id INTEGER NOT NULL,
  order_date  DATE NOT NULL,
  amount      NUMERIC(12,2) NOT NULL CHECK (amount >= 0),
  status      TEXT,
  CONSTRAINT fk_orders_customer
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


/* ---------- DATA (MESSY/REALISTIC) ---------- */

-- Departments
INSERT INTO departments (dept_id, dept_name) VALUES
(1, 'Data'),
(2, 'Engineering'),
(3, 'HR'),
(4, 'Sales'),
(5, 'Finance'),
(6, 'Support'),
(7, 'Marketing');


-- Customers (mix cities, some NULL emails)
INSERT INTO customers (customer_id, customer_name, email, city) VALUES
(201, 'Aditi Singh',    'aditi@gmail.com',         'Kanpur'),
(202, 'Rahul Verma',    'rahul@gmail.com',         'Delhi'),
(203, 'Sana Khan',      'sana@yahoo.com',          'Nagpur'),
(204, 'Vikas Sharma',   NULL,                      'Noida'),
(205, 'Priya Jain',     'priya@gmail.com',         'Jaipur'),
(206, 'Mohit Gupta',    'mohit@gmail.com',         'Gorakhpur'),
(207, 'Kiran Patel',    'kiran@outlook.com',       'Udaipur'),
(208, 'Neeraj Kumar',   'neeraj@gmail.com',        'Aligarh'),
(209, 'Zara Ansari',    'zara@gmail.com',          'Delhi'),
(210, 'Ankit Yadav',    'ankit@gmail.com',         'Nagpur'),
(211, 'Suresh Pal',     'suresh@gmail.com',        'Rampur'),
(212, 'Tanya Roy',      'tanya@gmail.com',         'Jodhpur'),
(213, 'Sameer Ali',     'sameer@gmail.com',        'Gorakhpur'),
(214, 'Pankaj Mishra',  'pankaj@company.com',      'Delhi'),
(215, 'Nisha Verma',    NULL,                      NULL);

-- Orders (mix statuses: Delivered/Cancelled/Pending/NULL; various dates & amounts)
INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(301, 202, '2025-12-15',  4999.00, 'Delivered'),
(302, 202, '2026-01-05', 12000.00, 'Pending'),
(303, 202, '2026-03-21',  2500.00, NULL),
(304, 201, '2026-02-11', 15500.00, 'Delivered'),
(305, 201, '2026-04-02',  999.00,  'Cancelled'),
(306, 203, '2026-03-10', 23000.00, 'Delivered'),
(307, 203, '2026-03-11', 18000.00, 'Delivered'),
(308, 203, '2026-03-25',  7000.00, 'Pending'),
(309, 204, '2026-01-18',  8500.00, NULL),
(310, 204, '2026-04-29',  4500.00, 'Delivered'),
(311, 205, '2026-05-01',  6000.00, 'Pending'),
(312, 205, '2026-05-03', 11000.00, NULL),
(313, 206, '2026-02-14',  3200.00, 'Delivered'),
(314, 206, '2026-02-20',  7800.00, 'Delivered'),
(315, 206, '2026-03-01',  1500.00, 'Cancelled'),
(316, 207, '2026-04-05', 25000.00, 'Delivered'),
(317, 208, '2026-01-10',  9999.00, 'Pending'),
(318, 208, '2026-04-10',  5000.00, NULL),
(319, 209, '2026-04-15',  3000.00, 'Delivered'),
(320, 210, '2026-03-06', 42000.00, 'Delivered'),
(321, 210, '2026-03-07',  4000.00, 'Delivered'),
(322, 210, '2026-03-08',  3500.00, 'Delivered'),
(323, 211, '2026-02-02',   799.00, NULL),
(324, 212, '2026-05-06',  8800.00, 'Pending'),
(325, 213, '2026-04-21',  9100.00, 'Cancelled'),
(326, 214, '2026-03-30',  1500.00, NULL);



/* ============================================================
   30 ADVANCED PRACTICE QUESTIONS (COMMENTED OUT)
   ============================================================ */

-- 1) Create employees table with PK, UNIQUE(email), NOT NULL(emp_name), FK(dept_id) → departments

CREATE TABLE employees (
  emp_id     INTEGER PRIMARY KEY,
  emp_name   TEXT NOT NULL,
  email      TEXT UNIQUE,
  salary     NUMERIC(12,2),
  join_date  DATE,
  dept_id    INTEGER,
  manager_id INTEGER,
  city       TEXT,
  CONSTRAINT fk_emp_dept FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);


-- Employees (mix: NULLs, varied cities, some gmail, some NULL emails, manager structure)
INSERT INTO employees (emp_id, emp_name, email, salary, join_date, dept_id, manager_id, city) VALUES
(101, 'Aman Kumar',      'aman.kumar@gmail.com',   85000, '2022-02-14', 2, NULL, 'Delhi'),
(102, 'Riya Sharma',     'riya.sharma@yahoo.com',  62000, '2023-06-10', 1, 101,  'Noida'),
(103, 'Monu Singh',      NULL,                    48000, '2024-01-05', 4, 101,  'Aligarh'),
(104, 'Neha Verma',      'neha.verma@gmail.com',   91000, '2021-11-20', 2, NULL, 'Gurugram'),
(105, 'Farhan Ali',      'farhan@company.com',     70000, '2024-07-01', 1, 104,  'Delhi'),
(106, 'Pooja Yadav',     'pooja.yadav@gmail.com',  54000, '2023-03-19', 3, 104,  'Kanpur'),
(107, 'Sahil Khan',      'sahil.khan@gmail.com',  120000, '2020-09-12', 5, NULL, 'Mumbai'),
(108, 'Isha Jain',       'isha.jain@outlook.com',  60000, '2024-02-28', 7, 104,  'Jaipur'),
(109, 'Karan Mehta',     'karan.mehta@gmail.com',  0,     '2022-08-08', NULL,104,  NULL),   -- salary 0 + dept NULL + city NULL (for delete practice)
(110, 'Deepak Saini',    'deepak@gmail.com',       NULL,  '2023-12-30', 6, 107,  'Delhi'), -- salary NULL
(111, 'Zoya Ansari',     'zoya@gmail.com',         75000, '2022-05-16', 4, 101,  'Nagpur'),
(112, 'Rohit Gupta',     'rohit.gupta@gmail.com',  88000, '2024-04-10', 2, 104,  'Noida'),
(113, 'Simran Kaur',     'simran@gmail.com',       51000, '2023-01-22', 3, 104,  'Amritsar'),
(114, 'Vivek Patel',     'vivek@gmail.com',        66000, '2022-10-02', 6, 107,  'Udaipur'),
(115, 'Nisha Khan',      NULL,                    95000, '2021-04-18', 5, 107,  'Bhopal'),
(116, 'Arjun Singh',     'arjun.singh@gmail.com',  73000, '2024-09-15', 1, 104,  'Gorakhpur'),
(117, 'Meera Roy',       'meera.roy@gmail.com',    59000, '2022-12-11', 7, 104,  'Lucknow'),
(118, 'Harsh Vardhan',   'harsh@company.com',     105000, '2020-01-09', 2, NULL, 'Delhi'),
(119, 'Kavya Singh',     'kavya@gmail.com',        64000, '2023-09-09', 4, 101,  'Nagpur'),
(120, 'Imran Qureshi',   'imran@gmail.com',        82000, '2022-03-03', 1, 118,  'Meerut');

-- 2) Alter employees to add self FK(manager_id) → employees(emp_id)

-- Self FK for manager relationship
ALTER TABLE employees
  ADD CONSTRAINT fk_emp_manager
  FOREIGN KEY (manager_id) REFERENCES employees(emp_id);

-- 3) Insert 5 employees where 2 have invalid dept_id; observe error and fix

INSERT INTO employees (emp_id, emp_name, email, salary, join_date, dept_id, manager_id, city) VALUES
(121, 'Manoj Singh',     'manojsingh456@gmail.com',  85600, '2024-08-30', 10, 104,  'Gorakhpur'),
(122, 'Shubham Roy',       'shubham4roy@gmail.com',    56800, '2022-09-21', 70, 104,  'Lucknow'),
(123, 'Dheeraj Singh',   'singhdheeraj@company.com',     35000, '2020-01-25', 2, NULL, 'Delhi'),
(124, 'Pooja Singh',     'poojas@gmail.com',        69000, '2023-08-02', 4, 101,  'Nagpur'),
(125, 'Amir Khan',   'amir_kahn@gmail.com',        36500, '2022-05-08', 1, 118,  'Meerut');

--ANSWER
/*insert or update on table "employees" violates foreign key constraint "fk_emp_dept"
Key (dept_id)=(10) is not present in table "departments". 
*/

-- 4) Add FK orders(customer_id) with ON DELETE CASCADE; delete a customer and verify orders removed

ALTER TABLE orders
DROP CONSTRAINT IF EXISTS fk_orders_customer;

ALTER TABLE orders
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
ON DELETE CASCADE;

-- 5) Add CHECK so salary > 0; test with wrong UPDATE

-- Salary check (can be tested)
ALTER TABLE employees
  ADD CONSTRAINT chk_salary_positive
  CHECK (salary IS NULL OR salary > 0);

-- 6) Employees: salary BETWEEN 50000 AND 90000 AND dept_id IN (1,3,5) AND city NOT LIKE '%delhi%'

SELECT 
	emp_name,
	salary,
	dept_id,
	city
FROM employees
WHERE salary BETWEEN 50000 AND 90000 AND dept_id IN(1,3,5)
AND city NOT LIKE '%delhi%';

-- 7) Employees joined in 2024 AND (salary > 70000 OR city IN ('Noida','Delhi')) AND email IS NOT NULL

SELECT
	emp_name,
	EXTRACT(YEAR FROM join_date) AS joining_year,
	salary,
	city,
	email
FROM employees
WHERE EXTRACT(YEAR FROM join_date) = 2024
	AND (salary > 70000 
	OR city IN('Noida', 'Delhi'))
	AND email IS NOT NULL;

-- 8) Employees where manager_id IS NULL but dept_id IS NOT NULL; ORDER BY salary DESC

SELECT
    emp_name,
    salary,
    manager_id,
    dept_id
FROM employees
WHERE manager_id IS NULL
AND dept_id IS NOT NULL
ORDER BY salary DESC;

-- 9) Customers: email ends with '@gmail.com' AND city contains 'pur' (LIKE)

SELECT
	email,
	city
FROM customers
WHERE email LIKE '%@gmail.com'
	AND city LIKE '%pur%';


-- 10) Orders where status IS NULL OR status NOT IN ('Delivered','Cancelled')

SELECT
	order_id,
	status
FROM orders
WHERE status IS NULL
	OR status NOT IN ('Delivered', 'Cancelled');

-- 11) COUNT DISTINCT cities in employees excluding NULL

SELECT
	COUNT(DISTINCT city) AS count_city 
FROM employees
WHERE city IS NOT NULL;

-- 12) dept_id with COUNT(*), AVG(salary), MIN, MAX; only avg salary > 60000

SELECT
	dept_id,
	COUNT(*) AS dept_id_count,
	ROUND(AVG(salary), 2) AS avg_salary,
	MIN(salary) AS min_salary,
	MAX(salary) AS max_salary
FROM employees
GROUP BY dept_id
HAVING AVG(salary) > 60000;

-- 13) Top 3 departments by SUM(salary)

SELECT
	dept_id,
	SUM(salary) AS total_salary
FROM employees
GROUP BY dept_id
ORDER BY total_salary DESC
LIMIT 3;

-- 14) Customers with >3 orders AND SUM(amount) > 50000

SELECT
	customer_id,
	COUNT(*) AS total_orders,
	SUM(amount) AS total_amount
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 3 AND SUM(amount) > 50000;

-- 15) Monthly order totals (group by month from order_date), order by month

SELECT
	EXTRACT(MONTH FROM order_date) AS monthly_order,
	SUM(amount) AS total_amount
FROM orders
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY monthly_order ASC;

-- 16) 5 highest paid employees, skip top 2 (LIMIT + OFFSET)

SELECT
	emp_name,
	salary
FROM employees
ORDER BY salary DESC
OFFSET 2
LIMIT 5;

-- 17) Employees ordered by join_date DESC, salary DESC; first 10

SELECT
	emp_name,
	join_date,
	salary
FROM employees
ORDER BY join_date DESC, salary DESC
LIMIT 10;

-- 18) 3 lowest DISTINCT salaries

SELECT DISTINCT salary
FROM employees
WHERE salary IS NOT NULL
ORDER BY salary ASC
LIMIT 3;

-- 19) Top 10 orders by amount in last 60 days

SELECT
	order_id,
	amount,
	order_date
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '60 days'
ORDER BY amount DESC
LIMIT 10;

-- 20) Customers A–Z page 3 with page size 10

SELECT
	customer_id,
	customer_name
FROM customers
ORDER BY customer_name ASC
LIMIT 10
OFFSET 20;
	

-- 21) Insert 10 more orders with mixed statuses/dates (already inserted some; add more yourself)

INSERT INTO orders (order_id, customer_id, order_date, amount, status) VALUES
(327, 201, '2026-05-07',  2500.00, 'Delivered'),
(328, 205, '2026-04-18',  999.00,  'Cancelled'),
(329, 209, '2026-03-12', 17500.00, 'Pending'),
(330, 211, '2026-02-25',  2200.00, 'Pending'),
(331, 214, '2026-01-22',  4500.00, 'Delivered'),
(332, 213, '2026-05-02', 12800.00, 'Delivered'),
(333, 212, '2026-04-28',  5600.00, 'Pending'),
(334, 208, '2026-03-19',  7000.00, 'Delivered'),
(335, 210, '2026-02-06',  3100.00, 'Cancelled'),
(336, 215, '2026-05-08',  8900.00, 'Pending');

-- 22) Update: 10% hike for dept_id IN (2,4) AND join_date < '2023-01-01'

UPDATE employees
SET salary = salary + (salary * .10) 
WHERE dept_id IN(2,4) AND join_date < '2023-01-01';

-- 23) Update orders: status='Delayed' where status is NULL and order_date older than 7 days

UPDATE orders
SET status = 'Delayed'
WHERE status IS NULL 
	AND order_date < CURRENT_DATE - INTERVAL '7 days';

-- 24) Delete employees where (salary IS NULL OR salary=0) AND dept_id IS NULL

DELETE FROM employees
WHERE (salary IS NULL OR salary = 0)
	AND dept_id IS NULL;

-- 25) Delete customers who have no orders (NOT IN / IN)

DELETE FROM customers
WHERE customer_id NOT IN(
	SELECT 
		customer_id
	FROM orders
);

-- 26) Create project_assignments with PK + FK(emp_id) + project_name NOT NULL + dates

CREATE TABLE project_assignments (
  assignment_id INTEGER PRIMARY KEY,
  emp_id        INTEGER NOT NULL,
  project_name  TEXT NOT NULL,
  start_date    DATE,
  end_date      DATE,
  CONSTRAINT fk_pa_emp FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

INSERT INTO project_assignments (assignment_id, emp_id, project_name, start_date, end_date) VALUES
(401, 102, 'Sales Dashboard',   '2026-01-10', NULL),
(402, 105, 'Data Pipeline',     '2026-02-01', NULL),
(403, 112, 'ETL Optimization',  '2026-03-01', '2026-04-10'),
(404, 116, 'Customer Insights', '2026-04-05', NULL),
(405, 118, 'Infra Upgrade',     '2026-01-01', '2026-02-15');

-- 27) Alter project_assignments to add UNIQUE(emp_id, project_name)

ALTER TABLE project_assignments
ADD CONSTRAINT unique_emp_project UNIQUE (emp_id, project_name);

-- 28) Alter employees.city type change VARCHAR <-> TEXT and observe effect

ALTER TABLE employees
ALTER column city TYPE TEXT;

-- 29) Drop project_assignments safely with dependencies

DROP TABLE IF EXISTS project_assignments CASCADE;

-- 30) Make orders.status NOT NULL after cleaning existing NULLs (UPDATE then ALTER)

UPDATE orders
SET status = 'Pending'
WHERE status IS NULL;

ALTER TABLE orders
ALTER COLUMN status SET NOT NULL;


/* ============================================================
   QUICK CHECK QUERIES (optional)
   ============================================================ */
SELECT * FROM departments;
SELECT * FROM employees ORDER BY emp_id;
SELECT * FROM customers ORDER BY customer_id;
SELECT * FROM orders ORDER BY order_id;
SELECT * FROM project_assignments ORDER BY assignment_id;