CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    city VARCHAR(50),
    account_balance DECIMAL(10,2) DEFAULT 0
);
-- DROP TABLE IF EXISTS customers;

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL
);
select * from products;
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL DEFAULT CURRENT_DATE,
    order_city VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    payment_date DATE NOT NULL DEFAULT CURRENT_DATE,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);
CREATE TABLE complaints (
    complaint_id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    complaint_text TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'unresolved',
    complaint_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

--Insert
INSERT INTO customers (first_name, last_name, email, phone, city)
VALUES
('Ali', 'Mammadov', 'ali.mammadov@example.com', '0501234567', 'Baku'),
('Leyla', 'Aliyeva', 'leyla.aliyeva@example.com', '0557654321', 'Ganja'),
('Rauf', 'Huseynov', 'rauf.huseynov@example.com', '0709876543', 'Baku');


INSERT INTO products (product_name, category, price)
VALUES
('iPhone 13', 'Electronics', 1299.99),
('Samsung Galaxy S21', 'Electronics', 999.99),
('Milk 1L', 'Groceries', 1.50);

INSERT INTO orders (customer_id, order_date)
VALUES
(1, '2024-02-15'),
(2, '2024-03-10'),
(3, '2024-05-01');

INSERT INTO order_items (order_id, product_id, quantity)
VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 5);

INSERT INTO payments (order_id, payment_date, amount)
VALUES
(1, '2024-02-16', 1299.99),
(2, '2024-03-11', 1999.98),
(3, '2024-05-02', 7.50);

INSERT INTO orders (customer_id, order_date, order_city)
VALUES
(1, '2024-02-15', 'Baku'),
(2, '2024-03-10', 'Ganja'),
(3, '2024-05-01', 'Baku');


INSERT INTO complaints (customer_id, complaint_text, status, complaint_date)
VALUES
(1, 'Delayed delivery', 'unresolved', '2024-02-20'),
(2, 'Received wrong product', 'resolved', '2024-03-12'),
(3, 'Payment issue', 'unresolved', '2024-05-03');


select * from customers;
select  * from  orders;
select * from products;
select * from order_items;
select * from payments;
select * from complaints;
--Select
SELECT CONCAT(first_name, ' ', last_name) AS full_name, phone
FROM customers;


SELECT first_name || ' ' || last_name AS full_name, email
FROM customers
WHERE city = 'Baku';

SELECT product_name,price FROM products
WHERE product_name ILIKE '%Phone%';

--Conditional Queries
SELECT c.customer_id, c.first_name, c.last_name, o.order_id, o.order_date
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_date > '2024-01-01';

INSERT INTO customers (first_name, last_name, email, phone, city)
VALUES ('Elvin', 'Quliyev', 'elvin.quliyev@example.com', '0505555555', 'Baku');

SELECT c.customer_id, c.first_name, c.last_name
FROM customers c
LEFT JOIN complaints cm ON c.customer_id = cm.customer_id
WHERE cm.customer_id IS NULL;

SELECT DISTINCT c.customer_id, c.first_name, c.last_name, c.account_balance
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_city = 'Baku'
   OR c.account_balance > 1000;

--5
SELECT product_name ,price FROM products
ORDER BY price desc ;

SELECT DISTINCT category from products
WHERE category like 'E%';


--6
UPDATE customers
set email ='newexcample@gmail.com'
WHERE  customer_id = 1;
select * from customers;


UPDATE customers
SET first_name = Case customer_id
WHEN 1 THEN 'Nigar'
WHEN 2 THEN 'Leyla'
ELSE first_name
END;


UPDATE complaints SET status = 'resolved'
WHERE status = 'unresolved';


--7
ALTER TABLE customers
ADD loyalty_points INT;

select * from customers;

ALTER TABLE customers
DROP COLUMN loyalty_points;

--8
INSERT INTO customers (first_name, last_name, email, phone, city)
VALUES ('Elvin', 'Quliyev', 'elvin.quliyev@example.com', '0505555555', 'Baku');

DELETE FROM customers
WHERE customer_id = 5;

--9
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    cm.complaint_text,
    cm.status
FROM customers c
LEFT JOIN complaints cm ON c.customer_id = cm.customer_id;

--10
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1;


DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS complaints;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

