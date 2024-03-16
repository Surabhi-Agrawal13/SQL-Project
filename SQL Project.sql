show databases;
use classicmodels;
select  * from offices;
select * from customers;
select * from orderdetails;
select * from orders;

/* Q,1: Write a SQL query to retrieve the first 5 rows from the "customers" table*/
select * from customers 
limit 5;

/* 2. Write a SQL query to retrieve the unique city names from "customers" table sorted in descending order.*/
select distinct city from customers
order by city desc
;

/* Q 3. Write a SQL query to get the number of unique city names "offices" table.*/
select distinct city from offices
order by city
;

/*  Q 4. Write a SQL query to get the maximum, minimum and average value from the "age" column in the "customers" table.*/
select min(age) as Min_age, max(age) as Max_age, avg(age) as Avg_age
from customers;

/*  Q 5. Write a SQL query to get the city names which are present in “offices” table but not in “customer” table.*/
select city from offices 
where city not in (select city from customers where city is not null);

/* Q 6. Write a SQL query to get the city names which are present in “offices” table as well as in “customer” table.*/
select distinct offices.city
from offices
inner join customers
on offices.city = customers.city;

/* Q 7. Write a SQL query to get records where city or state is not given in “customer” table and creditlimit is in the range – 80000 to 130000.*/
select * from customers
where(city is null or state is null)
and creditlimit>80000 and creditlimit<130000;

/* Q 8. Write a SQL query to get the maximum number of orders placed on a particular date and what is that date in orders table.*/
select orderDate, count(orderNumber) as MaxOrders
from orders
group by orderDate
order by MaxOrders desc
limit 1;

/* Q 9. For the records which we get in previous question(Q8), write a SQL query to get the customer names and their phone numbers.*/
select orderDate, count(orderNumber) as MaxOrders, min(customerName) as customerName, min(phone) as phone
from orders
inner join customers
on orders.customerNumber = customers.customerNumber
group by orderDate
order by MaxOrders desc, orderDate desc
limit 1;

/* Q 10. SQL query to get the customer phone number and customer name from customers table where order is either cancelled or disputed in orders table.*/
select c.phone, c.customerName
from customers c
join orders o
on c.customerNumber = o.customerNumber
where o.status in ('cancelled', 'disputed');

/* Q 11. Write a SQL query to get the top 4 highest selling products from orderdetails table.*/
select productCode, SUM(quantityOrdered) AS TotalQuantity
from orderdetails
group by productCode
order by TotalQuantity desc
limit 4;

/* Q 12. Write a SQL query to get the count of orders placed by each customer in 2003 and 2004.*/
select customerNumber, COUNT(*) as OrderCount
from orders
where orderDate between '2003-01-01' and '2004-12-31'
group by customerNumber
order by OrderCount desc;

/* Q 13. Write a SQL query to get the city names from customer table where more than 4 customers reside.*/
select city, count(customerNumber) as Count
from customers
group by city
having count(customerNumber) > 4
order by Count desc;
