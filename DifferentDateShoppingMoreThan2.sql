SELECT order_id, customer_id, order_date, total_amount
	FROM public.orders_date;
	
	
select customer_id 
from orders_date
where total_amount >1 
group by (customer_id) 
having count (distinct(order_date)) > 1; 

