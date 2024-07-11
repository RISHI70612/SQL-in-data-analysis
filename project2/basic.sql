show tables;

desc geo ;
select *
from geo;

desc people;
select *
from people;

desc products;
select * 
from products;

desc sales ;
select * 
from sales ;

select Amount,Customers , SaleDate  from sales ;

select amount , boxes, amount/boxes as 'amount per box' from sales ;

select * 
from sales 
where amount > 10000 and boxes > 400
order by amount  desc;


select * 
from sales 
where amount > 10000  and year(SaleDate) = 2022
order by Amount desc ; 

select *  
from sales 
where Boxes > 0 and boxes < 50 ;

select * 
from sales 
where weekday(Saledate) = 4;   

 
select * 
from people 
where Team = 'delish' or Team = 'Jucies';

-- different way 
select * 
from people 
where team in ('delish' ,'jucies');

-- pattern matching
select * 
from people 
where Salesperson like 'b%';

-- b anywhere in their name
select * 
from people 
where Salesperson like '%b%';

-- case operator 
select * 
from sales;

select saledate , amount , 
    case when amount < 1000 then 'under 1k'
		 when amount < 5000 then 'under 5k'
		when amount < 10000 then 'under 10k'
     else '10k or more' 
     end as 'amount category'
from sales 
order by amount;





 

