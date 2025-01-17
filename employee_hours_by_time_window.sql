-- First, we create a CTE (Common Table Expression) named logged_hours.
-- This CTE calculates the difference between login and logout times to determine
-- the total working duration in hours and classifies it into specific time ranges.
with logged_hours as (
    select *,
           -- EXTRACT EPOCH converts the difference between logout and login to seconds.
           -- Then, we divide the value by 3600 to get the duration in hours.
           case
               when EXTRACT(EPOCH FROM (logout - login))/3600.0 > 10 then '10+'
               when EXTRACT(EPOCH FROM (logout - login))/3600.0 > 8 then '8+'
               else '8-' 
           end as time_window
    from employees
),
-- Next, we create another CTE named time_window.
-- This CTE calculates the total number of days each employee worked in specific time ranges (8+ and 10+).
time_window as (
    select 
        emp_id,
        -- Counts the total number of days the employee worked more than 8 hours.
        count(*) as days_8,
        -- Sums up the total number of days the employee worked more than 10 hours.
        sum(case when time_window = '10+' then 1 else 0 end) as days_10
    from logged_hours
    -- Only considers time ranges '8+' and '10+' for analysis.
    where time_window in ('10+', '8+')
    group by emp_id
)
-- Finally, in the main query, we classify employees based on specific criteria.
select 
    emp_id,
    -- Employees are classified based on the following criteria:
    case 
        -- If the employee worked more than 8 hours on at least 3 days AND more than 10 hours on at least 2 days, classify as 'both'.
        when days_8 > 3 and days_10 > 2 then 'both'
        -- If the employee worked more than 8 hours on at least 3 days, classify as '1'.
        when days_8 > 3 then '1'
        -- In all other cases, classify as '2'.
        else '2' 
    end as criteria
from time_window
-- Only include employees who worked more than 8 hours on at least 3 days OR more than 10 hours on at least 2 days.
where days_8 > 3 or days_10 > 2
-- Sort the output by employee ID.
order by emp_id ASC;
