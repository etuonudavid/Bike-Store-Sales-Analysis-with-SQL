#Location, Location, Location
# What is going on in the locations.

#how many locations do we have
Select distinct country
from market;

#What country has the most revenue
select country,
	   sum(revenue) as revenue
from market
group by country;

#Sales volume across these countries
select country,
	   sum(quantity) as revenue
from market
group by country;

#Trend of sales in these countries over time
Select year, month,
	   Sum(case when country = 'United Kingdom' then revenue else 0 end) as UK,
       Sum(case when country = 'France' then revenue else 0 end) as France,
       Sum(case when country = 'United States' then revenue else 0 end) as US,
       Sum(case when country = 'Germany' then revenue else 0 end) as Germany
from market
group by year, month
order by year, month(Date);

#What product is driving sales in each of these countries?
Select country, product_category, sum(revenue) as Revenue
from market
group by country, product_category
order by country, Revenue;

#What product is driving sales volumne in each of these countries?
Select country, product_category, sum(quantity) as Quantity
from market
group by country, product_category
order by country, Quantity;

#how many states in these countries have access to our products
Select country, count(distinct state) as state_count  -- so many states in france have access to our products but has the least sales
from market
group by country
order by state_count;

#Lets see how the distribution is across these states -- first off in the United States.
Select state,
	   round(100*sum(revenue)/(Select sum(revenue) from market where country = "United States"), 3) as perct
from market
where country = "United States"
group by state
order by perct;    -- 99% of the sales in the U.S.A came from just 3 states out of the 22 states. very poor distribution.

Select state,
	   round(100*sum(revenue)/(Select sum(revenue) from market where country = "France"), 1) as perct
from market
where country = "France"
group by state
order by perct;    -- france has a better distribution across the different states than USA. though maority (20%) of the sales are from Seine(Paris)

Select state,
	   round(100*sum(revenue)/(Select sum(revenue) from market where country = "Germany"), 1) as perct
from market
where country = "Germany"
group by state
order by perct;  -- germany has the best distribution across its states with Brandenburg having the lowest of 2.1% while ther other five states have more than 10% of revenue distribution.

-- The united kingdom seems to be a new market for our products ans as such, much advertizing should be made.

# this can also be done using window functions
Select  distinct State,
		100 * round(sum(revenue) over(partition by country, state) / sum(revenue) over(partition by country), 2) as pct
from market
#where country = "Germany"
;

#Let's see the age distribution of the customers in these countries. --
Select min(m.customer_age) as min_age,
	   max(m.customer_age) as max_age,
       avg(m.customer_age) as average_age,
       mode
from market as m
cross join (Select customer_age as mode,
				   count(*) as cnt
			from market
            group by customer_age
			order by cnt desc
			limit 1)
            as mode_table
where m.country = "Germany";

Select distinct	country,
	   min(customer_age) over(partition by country) as min_age,
       max(customer_age) over(partition by country) as max_age,
       avg(customer_age) over(partition by country) as avg_age
from market ;



