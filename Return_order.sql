--  Orders table
CREATE TABLE orders (
    order_id INT,
    city VARCHAR(10),
    sales INT
);

--  return_order table
CREATE TABLE return_order (
    order_id INT,
    return_reason VARCHAR(30)
);

-- Inserting data into orders table
INSERT INTO orders (order_id, city, sales) VALUES
(1, 'NY', 100),
(2, 'NJ', 500),
(3, 'IL', 800),
(4, 'CA', 400),
(5, 'PA', 400),
(6, 'WA', 500);

-- Inserting data into return_order table
INSERT INTO return_order (order_id, return_reason) VALUES
(1, 'bad quality'),
(2, 'wrong item'),
(3, 'shipping time'),
(4, NULL),
(5, NULL);


SELECT * FROM orders;
SELECT * FROM return_order;

SELECT o.city, r.return_reason FROM orders o
INNER JOIN return_order r ON o.order_id = r.order_id
WHERE return_reason is NULL; 


SELECT
    o.city,
    COUNT(r.return_reason) AS return_number
FROM
    orders o
INNER JOIN
    return_order r ON o.order_id = r.order_id
GROUP BY
    o.city
HAVING
    COUNT(r.return_reason) >0  OR SUM(CASE WHEN r.return_reason IS NULL THEN 1 ELSE 0 END)>0;
	
	
SELECT
    o.city,
    COUNT(r.return_reason) AS return_number
FROM
    orders o
INNER JOIN
    return_order r ON o.order_id = r.order_id
GROUP BY
    o.city
HAVING
    COUNT(r.return_reason) > 0 OR 
	SUM(CASE WHEN r.return_reason IS NULL THEN 1 ELSE 0 END) >0;




SELECT
    o.city,
    COUNT(r.return_reason) AS return_number
FROM
    orders o
INNER JOIN
    return_order r ON o.order_id = r.order_id
GROUP BY
    o.city
HAVING
    COUNT(r.return_reason) + COUNT(COALESCE(r.return_reason, 'No Return Reason')) >0 ;


SELECT
    o.city,
    COUNT(COALESCE(r.return_reason, 'No Return Reason')) AS return_number
FROM
    orders o
INNER JOIN
    return_order r ON o.order_id = r.order_id
GROUP BY
    o.city
HAVING
    COUNT(COALESCE(r.return_reason, 'No Return Reason')) > 0;
	
	

SELECT
    o.city, r.return_reason,
    COUNT(COALESCE(r.return_reason, 'No Return Reason')) AS return_number
FROM
    orders o
LEFT JOIN
    return_order r ON o.order_id = r.order_id
WHERE
    r.return_reason IS NOT NULL OR o.city NOT IN (SELECT city FROM orders WHERE NOT EXISTS (SELECT 1 FROM return_order WHERE orders.order_id = return_order.order_id))
GROUP BY
    o.city
HAVING
    COUNT(COALESCE(r.return_reason, 'No Return Reason')) > 0;
	

SELECT
    o.city, r.return_reason,
    COUNT(*) AS return_number
FROM
    orders o
INNER JOIN
    return_order r ON o.order_id = r.order_id
GROUP BY
    o.city, r.return_reason
HAVING
    COUNT(*) > 0;























