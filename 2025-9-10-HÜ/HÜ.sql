//aufgabe 1
select count() from customers where City = 'Berlin';
//aufgabe 2
select CustomerName, City, Country from customers;
//aufgabe 3
select * from customers where City = 'London';
//aufgabe 4
select ProductName, Price from products where Price > 20;
//aufgabe 5
select * from products where Price != 18;
//andere möglichkeit
select * from products where Price <> 18;
