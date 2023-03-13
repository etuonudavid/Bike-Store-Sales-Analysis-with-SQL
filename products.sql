#PRODUCT ANALYSIS
#What product category is driving the most sales
Select product_category,
	   sum(revenue) as revenue,
       sum(quantity) as volume,
       round(avg(quantity),0) as avg_quantity,
       sum(revenue - cost) as profit
from market
group by product_category;

#how many states have access to these products
Select product_category,
	   count(distinct state) as states_count
from market
group by product_category;

#who are the target customers
Select product_category,
	   sum(case when customer_gender = "F" then 1 else 0 end) as female_count,
       sum(case when customer_gender = "M" then 1 else 0 end) as male_count
from market
group by product_category;

#deeper dives into the sub category
Select product_category, subcategory,
	   sum(revenue) as revenue,
       sum(quantity) as volume,
       round(avg(quantity),0) as avg_quantity,
       sum(revenue - cost) as profit
from market
group by product_category, subcategory
order by product_category;

#Lets see when these products are sold more or less during the months of the year
Select year, month, product_category, subcategory,  sum(revenue) as revenue
from market
group by year, month, product_category,subcategory
order by year, month(date), product_category;

