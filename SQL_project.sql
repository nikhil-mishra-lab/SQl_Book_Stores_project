create database books;
use books;

CREATE TABLE Books_data (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

-- 1) Retrieve all books in the "Fiction" genre:
select * from books_data
where genre="fiction";

-- 2) Find books published after the year 1950:
select * from books_data
where published_year>1950;

-- 3)  List all customers from the Canada:
select * from books_customers
where country="canada";

-- 4) Show orders placed in November 2023:
select * from book_orders
where order_date between '2023-11-01' and '2023-11-30';

-- 5) Retrieve the total stock of books available:
select sum(stock) as total_stock from books_data;

-- 6) Find the details of the most expensive book:
select * from books_data
order by price desc limit 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
select name from books_customers b
join book_orders o
on b.customer_id=o.customer_id
where o.quantity>1;

SELECT * FROM book_Orders 
WHERE quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
select * from book_orders
where total_amount>20;

-- 9) List all genres available in the Books table:
select distinct genre from books_data;

-- 10) Find the book with the lowest stock
select * from books_data
order by stock desc limit 1;

-- 11) Calculate the total revenue generated from all orders:
select sum(total_amount) as revenue from book_orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
select b.genre,sum(o.quantity) as total_sold from books_data b
join book_orders o 
on b.book_id=o.book_id
group by b.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
select avg(price) as average_price from books_data
where genre="Fantasy";

-- 3) List customers who have placed at least 2 orders:
select c.name,count(o.order_id) as count_order from books_customers c 
join book_orders o 
on c.customer_id=o.customer_id 
group by c.name 
order by count(o.order_id)>=2;

--  4) Find the most frequently ordered book:
select b.Title , count(o.order_id) as count_book from books_data b
join book_orders o 
on b.book_id=o.book_id
group by b.title
order by count(o.order_id) desc limit 1;

-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
select * from books_data
where genre ="Fantasy"
order by price desc limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
select b.author ,sum(o.quantity) as sum_quantity from books_data b 
join book_orders o 
on b.book_id=o.book_id
group by b.author;

-- 7) List the cities where customers who spent over $30 are located:
select distinct c.city  from books_customers c 
join book_orders o 
on c.customer_id=o.customer_id
where o.total_amount >30;

-- 8) Find the customer who spent the most on orders:
select c.name , sum(o.total_amount) from books_customers c 
join book_orders o 
on c.customer_id=o.customer_id
group by c.name;

-- 9) Calculate the stock remaining after fulfilling all orders:
select b.book_id,b.title,b.stock,ifnull(sum(o.quantity),0) as order_quantity,b.stock-ifnull(sum(o.quantity),0) as remening_quantity from books_data b 
left join book_orders o 
on b.book_id = o.book_id
group by b.book_id,b.title,b.stock
order by b.book_id









