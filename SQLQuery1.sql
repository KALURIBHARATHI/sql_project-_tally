CREATE DATABASE TALLY 
USE TALLY
-- Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    gst_number VARCHAR(20),
    city VARCHAR(50)
);

-- Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10, 2),
    stock_quantity INT
);

-- Sales master table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    sale_date DATE,
    total_amount DECIMAL(10, 2),
    gst_amount DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Sale line items
CREATE TABLE SaleItems (
    sale_id INT,
    product_id INT,
    quantity INT,
    line_total DECIMAL(10, 2),
    FOREIGN KEY (sale_id) REFERENCES Sales(sale_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Insert Customers
INSERT INTO Customers VALUES
(1, 'ABC Traders', '27AABCU9603R1ZV', 'Mumbai'),
(2, 'XYZ Ltd.', '29AAACX1234Q1ZV', 'Bangalore'),
(3, 'LMN Corp.', '07LMNCD1234L1ZV', 'Delhi');

-- Insert Products
INSERT INTO Products values
(101, 'LED Monitor', 'Electronics', 7500.00, 40),
(102, 'Keyboard', 'Electronics', 500.00, 120),
(103, 'Office Chair', 'Furniture', 3500.00, 15);

-- Insert Sales
INSERT INTO Sales VALUES
(1001, 1, '2024-04-10', 8000.00, 1440.00),
(1002, 2, '2024-04-11', 4000.00, 720.00);

-- Insert SaleItems
INSERT INTO SaleItems VALUES
(1001, 101, 1, 7500.00),
(1001, 102, 1, 500.00),
(1002, 103, 1, 3500.00),
(1002, 102, 1, 500.00);
select *from saleitems
select*from sales 
select *from products
select*from customers

-- 1. List all sales with customer names and GST details
SELECT s.sale_id, c.name, c.gst_number, s.total_amount, s.gst_amount, s.sale_date
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id;

-- 2. Total sales by city
SELECT c.city, SUM(s.total_amount) AS total_sales
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.city;

-- 3. Products with low stock
SELECT name, stock_quantity
FROM Products
WHERE stock_quantity < 20;

-- 4. Sale breakdown with line items
SELECT s.sale_id, c.name AS customer_name, p.name AS product, si.quantity, si.line_total
FROM SaleItems si
JOIN Sales s ON si.sale_id = s.sale_id
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON si.product_id = p.product_id;

-- 5. Total quantity sold per product
SELECT p.name, SUM(si.quantity) AS total_quantity_sold
FROM SaleItems si
JOIN Products p ON si.product_id = p.product_id
GROUP BY p.name;
