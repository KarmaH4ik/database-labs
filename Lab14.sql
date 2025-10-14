select email 
from students; 

select name 
from students where name ~ '^[d]';

select count(*) as total_students
from students;

create table customers (
	customer_id SERIAL PRIMARY KEY, 
	name VARCHAR(100),
	email VARCHAR(100)
);

create table orders(
	order_id SERIAL PRIMARY KEY, 
	customer_id INTEGER REFERENCES customers(customer_id),
	order_date DATE,
	total_amount DECIMAL (10,2)
);

SELECT c.name, c.email, o.order_date, o.total_amount
FROM customers c
INNER JOIN orders o ON c.customer_id = o.customer_id;