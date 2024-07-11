-- JOIN 

select s.SaleDate , s.Amount , p.Salesperson 

from sales as s
join people p on p.spid = s.spid;

select g.Region , s.Amount , s.Customers
from sales s
join geo g on s.GeoID = S.GeoID;

-- join multiple table 
select s.SaleDate , s.Amount , p.Salesperson  , pr.Product, p.Team

from sales as s

join people p on p.spid = s.spid
join products pr on p.spid = s.spid
where team = 'Yummies' and
 salesperson like 'v%'
 
order by amount desc ;

-- joining table on the basis of geography 
select s.SaleDate , s.Amount , p.Salesperson  , pr.Product, p.Team , g.geo

from sales as s

join people p on p.spid = s.spid
join geo g on g.GeoID = s.geoid
join products pr on p.spid = s.spid
where g.geo in ( 'india', 'new zealand') 
order by 6;

-- GROUP BY AGGREGATIONS

select s.SaleDate , s.Amount , p.Salesperson 

from sales as s
join people p on p.spid = s.spid;

select g.Geo , sum(s.amount)
from sales s
join geo g on s.GeoID = S.GeoID
group by g.Geo;


