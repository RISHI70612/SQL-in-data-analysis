SELECT 
    *
FROM
    order_details;
SELECT 
    *
FROM
    orders;
SELECT 
    *
FROM
    pizzas;
SELECT 
    *
FROM
    pizza_types;
-- Join the necessary tables to find the total quantity of each pizza  category ordered.
select pt.category, sum(ord.quanity) as total_quantity 
from pizza_types pt 
join pizzas p on p.pizza_type_id = pt.pizza_type_id
join order_details ord on ord.pizza_id = p.pizza_id
group by category 
order by category desc; 

-- Join the necessary tables to find the total quantity of each pizza ordered.
select pt.name , sum(ord.quanity) as total_quantity 
from pizza_types pt 
join pizzas p on p.pizza_type_id = pt.pizza_type_id
join order_details ord on ord.pizza_id = p.pizza_id
group by name ;

-- Determine the distribution of orders by hour of the day.
select hour(order_time) , count(order_id)
from orders 
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category , count(name) 
from pizza_types
group by category;


    