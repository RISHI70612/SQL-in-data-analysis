

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

-- Retrieve the total number of orders placed.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(p.price * ord.quanity), 2) AS total_revenue
FROM
    pizzas AS p
        JOIN
    order_details ord ON ord.pizza_id = p.pizza_id;



-- Identify the highest-priced pizza.
SELECT 
    pt.name, p.price
FROM
    pizzas p
        JOIN
    pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;


-- Identify the most common pizza size ordered.
SELECT 
    p.size, COUNT(ord.order_details_id) AS size_ordered
FROM
    pizzas AS p
        JOIN
    order_details ord ON ord.pizza_id = p.pizza_id
GROUP BY p.size;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pta.name, SUM(ord.quanity) AS most_pizza_ordered
FROM
    pizza_types pta
        JOIN
    pizzas p ON p.pizza_type_id = pta.pizza_type_id
        JOIN
    order_details ord ON ord.pizza_id = p.pizza_id
GROUP BY pta.name
ORDER BY most_pizza_ordered DESC
LIMIT 5;





