-- Drop the e-commerce billing table if it exists
drop table if exists e_commerce_billing;

-- Create the e-commerce billing table
create table e_commerce_billing
(
    order_id                   int,
    customer_id                int,
    customer_name              varchar(1),
    product_id                 varchar(5),
    order_date                 date,
    order_amount               int
);

-- PL/pgSQL block for inserting random data
do $$ 
declare
    v_order_id int;
    v_customer_id int;
    v_customer_name varchar(1);
    v_product_id varchar(5);
    v_order_date date;
    v_order_amount int;
    v_customer_count int := 10;
    v_order_count int := 40;
begin
    -- Loop for 10 different customers
    for i in 1..v_customer_count loop
        v_customer_id := i;
        v_customer_name := chr(64 + i);

        -- Nested loop for 4 orders per customer
        for j in 1..4 loop
            v_order_id := (i - 1) * 4 + j;
            
            -- Generate random product details
            v_product_id := 'p' || CAST(ceil(random() * 20) AS varchar);
            
            -- Generate random order date
			v_order_date := '2020-01-01'::date + (random() * (now()::date - '2020-01-01'::date))::int;
            
            -- Generate random order amount
            v_order_amount := ceil(random() * 450 + 50);
            
            -- Insert the order into the table
            insert into e_commerce_billing values (v_order_id, v_customer_id, v_customer_name, v_product_id, v_order_date, v_order_amount);
        end loop;
    end loop;
end $$;


SELECT 	* FROM 	e_commerce_billing;

with cte as
    (select customer_id,customer_name
    , sum(case when to_char(order_date,'yyyy') = '2020' then order_amount else 0 end)::decimal as bill_2020_sum
    , sum(case when to_char(order_date,'yyyy') = '2021' then order_amount else 0 end)::decimal as bill_2021_sum
    , sum(case when to_char(order_date,'yyyy') = '2022' then order_amount else 0 end)::decimal as bill_2022_sum
    , count(case when to_char(order_date,'yyyy') = '2020' then order_amount else null end) as bill_2020_cnt
    , count(case when to_char(order_date,'yyyy') = '2021' then order_amount else null end) as bill_2021_cnt
    , count(case when to_char(order_date,'yyyy') = '2022' then order_amount else null end) as bill_2022_cnt
    from e_commerce_billing
    group by customer_id,customer_name)
select customer_id, customer_name
, round((bill_2020_sum + bill_2021_sum + bill_2022_sum)/
    (  case when bill_2020_cnt = 0 then 1 else bill_2020_cnt end
     + case when bill_2021_cnt = 0 then 1 else bill_2021_cnt end
     + case when bill_2022_cnt = 0 then 1 else bill_2022_cnt end
    ),2)
from cte
order by 1;

