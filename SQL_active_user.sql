
user_actionsExample Input:
user_id	event_id	event_type	event_date
445	7765	sign-in	05/31/2022 12:00:00
742	6458	sign-in	06/03/2022 12:00:00
445	3634	like	06/05/2022 12:00:00
742	1374	comment	06/05/2022 12:00:00
648	3124	like	06/18/2022 12:00:00

Example Output for June 2022:
month	monthly_active_users
6	2

--Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".



SELECT
    EXTRACT(MONTH FROM curr_month.event_date) AS month,
    COUNT(DISTINCT curr_month.user_id) AS monthly_active_users
FROM
    user_actions AS curr_month
WHERE
    EXISTS (
        SELECT
            last_month.user_id
        FROM
            user_actions AS last_month
        WHERE
            last_month.user_id = curr_month.user_id
            AND EXTRACT(MONTH FROM last_month.event_date) = EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
            
    )
    AND EXTRACT(MONTH FROM curr_month.event_date) = 7
    AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY
    EXTRACT(MONTH FROM curr_month.event_date);