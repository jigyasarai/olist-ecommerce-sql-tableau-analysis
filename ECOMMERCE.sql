CREATE DATABASE ecommerce_analysis;
USE ecommerce_analysis;

-- viewing thefirst five rows of the ocustomers_dataset
select * from ocustomers_dataset limit 5;

-- Count rows
select count(*) from ocustomers_dataset;

-- table structure
describe ocustomers_dataset;

-- Count distinct customer IDs:
select count(distinct customer_id)
from ocustomers_dataset;

-- Count distinct customer IDs:
select count(distinct customer_unique_id)
from ocustomers_dataset;

-------------------------------------------
-- Order table
-------------------------------------------
select count(*) as total_rows,
count(distinct order_id) as no_of_orders
 from orders;
 describe orders;
 select *
 from orders limit 5;
 
 -- Number of total orders
 select count(distinct order_id) as total_orders
 from orders;                                   
 
 -- Number of total customers
 select count(distinct customer_id) as total_customers
 from orders;
 
 -- Distinct Order status value
 select distinct order_status from orders;          

-- Number of Orders in different status segment
 select order_status,count(order_status)
 from orders
 group by order_status;
 
 -- Counting Nulls
 SELECT
    COUNT(*) - COUNT(order_purchase_timestamp) AS purchase_ts_nulls,
    COUNT(*) - COUNT(order_approved_at) AS approved_at_nulls,
    COUNT(*) - COUNT(order_delivered_carrier_date) AS carrier_date_nulls,
    COUNT(*) - COUNT(order_delivered_customer_date) AS customer_delivery_nulls,
    COUNT(*) - COUNT(order_estimated_delivery_date) AS estimated_date_nulls
FROM orders;

 
 -------------------------------------------
 -- Product table
 -------------------------------------------
 select count(*) as total_rows
 from products;
 
 describe products;
 
 -------------------------------------------
 -- Sellers table
 -------------------------------------------
  select count(*) as total_rows
 from sellers;
 
 describe sellers;
 
 -------------------------------------------
 -- Order_items table
 -------------------------------------------
 select count(*) as total_rows
 from order_items;
 
 select * from order_items
 limit 5;
 
 describe order_items;
 
 -- Total Unique orders
 select count(distinct order_id) as total_unique_orders
 from order_items;

-- Total Unique Products
 select count(distinct product_id) as total_unique_product
 from order_items;
 
 -- Total Unique Sellers
 select count(distinct seller_id) as total_unique_seller
 from order_items;

-- Number of items in a order
 select order_id,count(order_item_id) as items
 from order_items
 group by order_id
 order by items desc;
 
 -- Average number of items in an order
 select count(*)/count(distinct order_id)
 as avg_order
 from order_items;
 
 
 ------------------------------------------
 -- Payment Table
 ------------------------------------------
 select count(*) as total_rows
 from payments;
 
  describe payments;
  
  -- Number of Payment methods
  select count(distinct payment_type)
  as payment_types 
  from payments;
  
  -- Number of Transactions via different payment methods
  select  payment_type,count( payment_type)
  as payment_types 
  from payments
  group by payment_type;
  
  -- Payments having 0.00 value
  select * from payments
  where payment_value=0.00;
  
  -- Maximum payment value
  select max(payment_value) as max_payment
  from payments ;
  
  -----------------------------------------
  -- Reviews table
  -----------------------------------------
select count(*) as total_rows
from reviews;

describe reviews;

select * from reviews
limit 5;
  
  -- Different values for review score
select distinct( review_score)
from reviews;

-- frequency of each review score
select review_score,count(review_score) as frequency
from reviews
group by review_score;
  
  -- Average review score
select sum(review_score)/count(review_score)
as avg_review_score
from reviews;
  
 ------------------------------------------------------
 -- total revenue
 ------------------------------------------------------
 select 
 sum(order_revenue)
 from(
 select order_id,sum(payment_value) as order_revenue
 from payments
 group by order_id)
 as t;
 
 -----------------------------------------------------
 -- Average Order values
 ------------------------------------------------------
select 
 sum(order_revenue)/count(distinct order_id) as Average_order_value
 from(
 select order_id,sum(payment_value) as order_revenue
 from payments
 group by order_id)
 as t;
 
 ------------------------------------------------------
 -- Customer Analysis
 ------------------------------------------------------
 -- Total number of unique customers
 select count(distinct customer_unique_id) as total_unique_customer
 from ocustomers_dataset;                                           
 
 -- Number of repeat customers
 select count(*) as repeat_customers
 from(
 select c.customer_unique_id
 from orders o
 join ocustomers_dataset c on o.customer_id=c.customer_id
 group by customer_unique_id
 having count(order_id)>1)
 as t;                                                           

-- Repeat Customer Rate
with customer_orders AS (
select 
	c.customer_unique_id, 
	count(o.order_id) AS total_orders
from orders o
join ocustomers_dataset c ON c.customer_id = o.customer_id
group by c.customer_unique_id
)
select 
    count(case when total_orders > 1 then 1 end) as repeat_customers_count,
    count(customer_unique_id) as total_customers_count, 
    round(
        (count(case when total_orders > 1 then 1 end) * 100.0) / count(customer_unique_id), 
        2
    ) as repeat_customer_percentage
from
    customer_orders;                                                                       

-- top 10 customers by spending
select 
    c.customer_unique_id,
    sum(p.order_revenue) as spending
from ocustomers_dataset c
join orders o on o.customer_id = c.customer_id
join (
    select order_id, sum(payment_value) as order_revenue
    from payments
    group by order_id
) p on p.order_id = o.order_id
where o.order_status not in ('canceled', 'unavailable') 
group by c.customer_unique_id
order by spending desc
limit 10; 
 ----------------------------------------------------------
 -- Categorywise product revenue
 ----------------------------------------------------------
-- Revenue
select
    p.product_category_name,
    sum(oi.price) as revenue
from order_items oi
join products p on oi.product_id = p.product_id
join orders o on oi.order_id = o.order_id 
where o.order_status not in ('canceled', 'unavailable')
group by p.product_category_name
order by revenue desc; 

-- average selling price by category
select p.product_category_name,
avg(price) as average_price
from products p
join order_items o on o.product_id=p.product_id
group by p.product_category_name;

 ---------------------------------------------------------
 -- Top sellers by revenue
 ---------------------------------------------------------
 select seller_id,
 sum(price) as revenue
 from order_items 
 group by seller_id
 order by revenue desc;
 
 
-----------------------------------------------------------
-- Data Cleaning
------------------------------------------------------------
ALTER TABLE orders
MODIFY COLUMN order_purchase_timestamp DATETIME;

-- Order_approved_at
ALTER TABLE orders
ADD COLUMN order_approved_at_dt DATETIME;
UPDATE orders
SET order_approved_at_dt = NULLIF(order_approved_at,'');
select * from orders limit 5;

-- Order_delivered_carrier_date
ALTER TABLE orders
ADD COLUMN order_delivered_carrier_dt DATETIME;
UPDATE orders
SET order_delivered_carrier_dt = NULLIF(order_delivered_carrier_date,'');

-- Order_delivered_customer_date
ALTER TABLE orders
ADD COLUMN order_delivered_customer_dt DATETIME;
UPDATE orders
SET order_delivered_customer_dt = NULLIF(order_delivered_customer_date,'');

-- Order_estimated_delivery_date
ALTER TABLE orders
ADD COLUMN Order_estimated_delivery_dt DATETIME;
UPDATE orders
SET Order_estimated_delivery_dt = NULLIF(Order_estimated_delivery_date,'');

select * from orders limit 5;
describe orders;

-------------------------------------------------------------------------
-- Monthly Sales Trend
--------------------------------------------------------------------------
Select
    date_format(o.order_purchase_timestamp, '%Y-%m') AS yearmonth,
    sum(p.payment_value) as revenue
from orders o
join payments p on p.order_id = o.order_id
where o.order_status not in ('canceled', 'unavailable') 
group by yearmonth
order by yearmonth;
---------------------------------------------------------------------------
-- State Performance Analysis
---------------------------------------------------------------------------
-- Number of orders per state
select customer_state as state,
count(order_id) as orders
from ocustomers_dataset c
join orders o on c.customer_id=o.customer_id
group by customer_state
order by orders desc;

-- Average number of shipping days 
SELECT
c.customer_state,
ROUND(
	AVG(
		DATEDIFF(
			o.order_delivered_customer_dt,
			o.order_purchase_timestamp
		)
	),
   2
) AS avg_shipping_days
FROM orders o
JOIN ocustomers_dataset c
    ON o.customer_id = c.customer_id
WHERE o.order_delivered_customer_dt IS NOT NULL
GROUP BY c.customer_state
ORDER BY avg_shipping_days DESC; 
                                     
-----------------------------------------------------------------------
-- Customer Rating
-----------------------------------------------------------------------
select product_category_name as category,
avg(review_score) as avg_rating,
count(review_id) as review_count
from reviews r
join order_items o on r.order_id=o.order_id
join products p on o.product_id=p.product_id
group by product_category_name
having review_count>250
order by avg_rating desc;

---------------------------------------------------------------------
-- Payment Method Analysis
---------------------------------------------------------------------
-- Most used method
select payment_type,
count(*) as Usage_count
from payments 
group by payment_type
order by usage_count desc;

-- Most Valuable Payment method:
select payment_type,
sum(payment_value) as payment
from payments 
group by payment_type
order by payment desc;

---------------------------------------------------------------------
-- Category sales volume
---------------------------------------------------------------------
select product_category_name,
count(order_id) as units_sold
from products p
join order_items o on p.product_id=o.product_id
group by product_category_name
order by units_sold desc;

------------------------------------------------------------------
-- Logistics and Delivery Efficiency
------------------------------------------------------------------
-- On time delivery rate
SELECT
    ROUND(
        100.0 *
        SUM(
            CASE
                WHEN order_delivered_customer_dt <= order_estimated_delivery_dt
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS on_time_delivery_rate
FROM orders
WHERE order_delivered_customer_dt IS NOT NULL;                                 

-- Average Shipping Delay
SELECT
    ROUND(
        AVG(
            DATEDIFF(
                order_delivered_customer_dt,
                order_purchase_timestamp
            )
        ),
        2
    ) AS avg_shipping_days
FROM orders
WHERE order_delivered_customer_dt IS NOT NULL;

-- Product categories experiencing the longest delivery times
select product_category_name,
round(avg (datediff(order_delivered_customer_dt,order_purchase_timestamp)),3) as delivery_time
from products p
join order_items oi on oi.product_id=p.product_id
join orders o on o.order_id=oi.order_id
group by product_category_name
order by delivery_time desc;

--------------------------------------------------------------
-- Ranking based on category wise revenue
--------------------------------------------------------------
select product_category_name,
sum(price) as revenue,
rank()over(order by sum(price) desc) as category_rank
from products p
join order_items oi on oi.product_id=p.product_id
group by product_category_name;


------------------------------------------------------------
-- Top Selling Category in each category
------------------------------------------------------------
with state_category_revenue as
(
select
c.customer_state as State,
p.product_category_name as category,
sum(oi.price) as revenue
from ocustomers_dataset c
join orders o on o.customer_id=c.customer_id
join order_items oi on oi.order_id=o.order_id
join products p on p.product_id=oi.product_id
group by c.customer_state,
p.product_category_name
)
select
state,
category,
revenue
from
(
Select
        state,
        category,
        revenue,
        row_number() over(
            partition by state
            order by revenue desc
        ) as category_rank
    from state_category_revenue
) t
where category_rank = 1;


----------------------------------------------------------------------
-- Growth Analysis
----------------------------------------------------------------------
-- monthly revenue growing over time
with monthly_revenue AS
(
    select
        date_format(o.order_purchase_timestamp,'%Y-%m') AS month,
        round(sum(py.payment_value),2) AS revenue
    from orders o
    join payments py
        on o.order_id = py.order_id
	where o.order_status not in ('canceled', 'unavailable')
    group by date_format(o.order_purchase_timestamp,'%Y-%m')
)

select
    month,
    revenue,
    lag(revenue) over(
        order by month
    ) as previous_month_revenue
from monthly_revenue;

-- Month generated the highest revenue
select  date_format(o.order_purchase_timestamp,'%Y-%m') AS month,
sum(payment_value) as revenue
from orders o
join payments p on p.order_id=o.order_id
where o.order_status not in ('canceled', 'unavailable')
group by month
order by revenue desc
limit 1 ;                                                         

-- Quarterly  Revenue Analysis 
select
    year(order_purchase_timestamp) as sales_year,
    quarter(order_purchase_timestamp) as sales_quarter,
    sum(price) as total_revenue
from 
    orders o
join 
    order_items oi ON o.order_id = oi.order_id
where o.order_status not in ('canceled', 'unavailable')
group by
    sales_year, 
    sales_quarter
order by 
    total_revenue desc ;

