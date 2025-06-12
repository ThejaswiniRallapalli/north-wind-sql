use northwind;

-- JOINS 
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders
INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID;
-- inner join table 
-- on common fields
-- . represent reference orders.orderid means orders table and orderid column

SELECT OrderID, CustomerName, OrderDate, CustomerID
FROM Orders
INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID;
-- this query return error. Beacuse customerid is in both tables
-- mysql is confused which customerid to pick 

SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate, Customers.CustomerID
FROM Orders
INNER JOIN Customers 
ON Orders.CustomerID = Customers.CustomerID;


select 
from table1
inner join table2
on common field from table1 = common field in table2

-- Join products to categories
select *
from products
inner join categories
on products.categoryid = categories.categoryid;
-- Looking for matching results for categoryid

-- joining customers to orders table
select *
from customers
inner join orders
on customers.customerid  = orders.customerid;
-- there might be some customers who never placed an order
-- beacuse inner join returns only matching resilts

-- products and their suppliers
SELECT SupplierName, ProductName
FROM Products
INNER JOIN Suppliers
on Products.SupplierID = Suppliers.SupplierID;

-- supplier G'day, Mate
SELECT SupplierName, ProductName
FROM Products
INNER JOIN Suppliers
on Products.SupplierID = Suppliers.SupplierID
where SupplierName = "G'day, Mate";

-- Inner join Supplier of each product

-- Inner join Supplier of each product
select products.productname as product, suppliers.suppliername as supplier
from products
inner join suppliers
on products.supplierid = suppliers.supplierid;

-- Supplier Tokyo Traders only
select products.productname as product, suppliers.suppliername as supplier
from products
inner join suppliers
on products.supplierid = suppliers.supplierid
where suppliername = "Tokyo Traders";

-- suppliers tokyo trader sort by product name
select products.productname as product, suppliers.suppliername as supplier
from products
inner join suppliers
on products.supplierid = suppliers.supplierid
where suppliername = "Tokyo Traders"
order by products.productname;


-- suppliers tokyo trader sort by product name
select products.productname as product, suppliers.suppliername as supplier
from suppliers
inner join products
on products.supplierid = suppliers.supplierid
where suppliername = "Tokyo Traders"
order by products.productname;

-- the position for right and left table doesnt make difference. Beacuse this is inner join.

-- right join

SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders
RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
where orders.orderid is null
ORDER BY Orders.OrderID;


-- LEFT JOIn
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY Customers.CustomerName;

-- all info about customer and only matching in orders
 
 
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
where orders.orderid is null
ORDER BY Customers.CustomerName;
 
 
 
 -- Write SQL query to find name of the products which has never been ordered
-- if product has never been ordered, it will not have an orderid
select *
from products as p
left join order_details as od
on p.productid = od.productid
where od.orderid is null;

-- CROSS JOIN
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers
CROSS JOIN Orders
order by customername;
 
select count(*) country from customers
group by country


-- count number of different cities in each country in Customers table
SELECT count(distinct city), Country
from customers
group by Country;

select count(distinct city) as numberofcities, Country
from customers
group by Country
order by count(distinct city) desc;

SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID
GROUP BY ShipperName;

-- total sales amount by each product (quantity * price)
-- join products to order_details table


select  p.productname, sum(od.quantity * p.price) as sales
from products as p
inner join order_details as od
on p.productid = od.productid
group by p.productname
order by sales desc;

-- Write SQL query to find supplier of each product
SELECT p.ProductName, s.SupplierName
FROM Products as p
inner JOIN Suppliers as s ON p.SupplierID = s.SupplierID;

-- Write sql query to  find category of each product.
SELECT p.ProductName, c.CategoryName
FROM Products as p
inner JOIN Categories as c ON p.CategoryID = c.CategoryID;

-- Retrieve all products belonging to the meat/poultry category
SELECT p.productname,
       c.categoryname
FROM Products as p
JOIN Categories as c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Meat/Poultry';

-- Retrieve the order ID, order date, customer name, and employee name for all orders.
SELECT
  o.OrderID,
  o.OrderDate,
  c.CustomerName,
  e.FirstName, e.LastName 
FROM Orders as o
inner JOIN Customers  as c ON o.CustomerID = c.CustomerID
inner JOIN Employees as e ON o.EmployeeID = e.EmployeeID;

-- Retrieve the product name, category name, and supplier name for all products.

SELECT
  p.ProductName,
  c.CategoryName,
  s.SupplierName
FROM Products p
inner JOIN Categories c ON p.CategoryID = c.CategoryID
inner JOIN Suppliers s ON p.SupplierID = s.SupplierID;

-- Create a report for all the orders of 1996 and their Customers.
SELECT
  o.OrderID,
  o.OrderDate,
  c.CustomerName
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate >= '1996-01-01' AND o.OrderDate < '1997-01-01';

-- Retrieve all categories along with the number of products in each category.
SELECT
  c.CategoryName,
  COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryName;

-- Retrieve all products with their prices and the quantity ordered for each product.

SELECT
  p.ProductName,
  p.Price,
  SUM(od.Quantity) AS TotalQuantityOrdered
FROM Products p
JOIN Order_Details od ON p.ProductID = od.ProductID
GROUP BY p.ProductName, p.Price;