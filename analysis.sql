# GENERAL STATISTICS OF THE DATA.

#check for duplicates
select count(distinct(index1)), count(*)
from market ;									-- The same values, no duplicates are recorded.

#check the date column and see the width
Select distinct year
from market;  									-- just two years 2015-2016

#Age distribution 
#Min, max, average, mode ages
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
            as mode_table;
            
Select customer_age, count(*) as age_count
from market
group by customer_age
order by customer_age;

# variance and standard deviation of the ages
Select round(var_pop(customer_age), 2) as age_variance,
	    round(stddev_pop(customer_age), 2) as age_standard_deviation
from market;

#Revenue
Select min(revenue) as min_rev,
	   max(revenue) as max_rev,
       avg(revenue) as average_rev
from market;

#Quantity
Select min(quantity) as min_quant,
	   max(quantity) as max_quant,
       avg(quantity) as average_quant
from market;





