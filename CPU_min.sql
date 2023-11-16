-- 
DROP TABLE IF EXISTS cpu_prices;

-- 
DROP TABLE IF EXISTS companies;



-- companies table
CREATE TABLE companies (
    company_id INTEGER PRIMARY KEY,
    company_name VARCHAR(50) NOT NULL
   
);

-- cpu_prices table
CREATE TABLE cpu_prices (
    company_id INTEGER,
    price INT NOT NULL,
    cpu_type VARCHAR(10) NOT NULL
);



-- insert values into companies table
INSERT INTO companies (company_id, company_name)
VALUES
    (101, 'A company'),
    (102, 'B company'),
    (103, 'C company'),
    (104, 'D company'),
    (105, 'E company'),
    (106, 'F company'),
    (107, 'G company');
	
	
	
-- insert values into cpu_prices table
INSERT INTO cpu_prices (company_id, price, cpu_type)
VALUES
    (101, 600, 'i5'),
    (102, 500, 'i3'),
    (103, 800, 'i7'),
    (104, 700, 'i5'),
    (105, 450, 'i3'),
    (106, 1000, 'i9'),
    (107, 900, 'i7'),

    (101, 550, 'i3'),
    (102, 480, 'i5'),
    (103, 750, 'i7'),
    (104, 680, 'i5'),
    (105, 420, 'i3'),
    (106, 950, 'i9'),
    (107, 850, 'i7'),

    (101, 580, 'i5'),
    (102, 520, 'i3'),
    (103, 780, 'i7'),
    (104, 690, 'i5'),
    (105, 440, 'i3'),
    (106, 980, 'i9'),
    (107, 870, 'i7');


--	Which CPU prices are min by Company name?
	
SELECT * FROM companies;

SELECT * FROM cpu_prices;


SELECT
    c.company_name,
    cp.cpu_type,
    cp.price
FROM
    companies c
JOIN
    cpu_prices cp ON c.company_id = cp.company_id
WHERE
    (cp.price, cp.cpu_type) IN (
        SELECT
            MIN(price) AS min_price,
            cpu_type
        FROM
            cpu_prices
        GROUP BY
            cpu_type
    );




