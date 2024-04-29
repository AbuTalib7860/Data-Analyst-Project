
use PizzaDB;
select * from pizza_sales;

select sum(total_price) as total_revenue from pizza_sales;

select sum(total_price) / count(distinct(order_id)) AS Avg_Order_Val from pizza_sales;

select sum(quantity) from pizza_sales;

select count(distinct(order_id)) from pizza_sales;

select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct(order_id)) as decimal(10,2)) as decimal(10,2)) AS Avg_Pizza_Per_Order from pizza_sales;

select DATENAME(dw,order_date) as order_day, count(distinct order_id) as total_orders 
from pizza_sales group by DATENAME(dw,order_date);

select DATENAME(month,order_date) as order_month, COUNT(distinct order_id) as total_orders
from pizza_sales group by DATENAME(month,order_date) order by total_orders desc;

select pizza_category, sum(total_price)*100 / (select SUM(total_price) from pizza_sales  where MONTH(order_date)=1)
AS PCT_Total_Sales
from pizza_sales where MONTH(order_date)=1 group by pizza_category;

select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_Sales, 
cast(sum(total_price)*100 / (select SUM(total_price) from pizza_sales as decimal(10,2))
AS PCT_Total_Sales
from pizza_sales
group by pizza_size order by PCT_Total_Sales desc;

select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_Sales, 
cast(sum(total_price)*100 / (select SUM(total_price) from pizza_sales where datepart(quarter, order_date)=1) as decimal(10,2))
AS PCT_Total_Sales
from pizza_sales
where datepart(quarter, order_date)=1
group by pizza_size order by PCT_Total_Sales desc;

select * from pizza_sales;

select Top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name order by Total_Revenue;

select Top 5 pizza_name, sum(quantity) as Total_Quantity from pizza_sales
group by pizza_name order by Total_Quantity desc;

select Top 5 pizza_name, COUNT(distinct order_id) as Total_Order from pizza_sales
group by pizza_name order by Total_Order desc;