Create table customers (
    id INT NOT NULL PRIMARY KEY,
    first_name VARCHAR(50) not null,
    LAST_NAME varchar(50) not null
);

create table orders (
    id INT NOT NULL PRIMARY KEY,
    customer_id INT NOT NULL REFERENCES customers,
    product_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL
);


-- Problem Statement:
/*
Your Company wants to reward the top 2 ranked customers according to the revenue they created with all of their orders. 
If several customers generated the exact same revenue, they should all be rewarded, 
i.e. there may be more than 2 top customers if they share the same rank.
*/

select customers.id, first_name, last_name, sum(amount) amount
into #t1
from customers left outer join orders 
on customers.id = orders.customer_id
group by customers.id, first_name, last_name;

select * from #t1 where amount in 
(select max(amount) from #t1) and amount in 
(select max(amount) from #t1 where amount not in (select max(amount) from #t1));
