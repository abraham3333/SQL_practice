create table call_details (
call_type varchar(10),
call_number varchar(12),
call_duration int
);
--
insert into call_details
values ('OUT', '181868',13),('OUT', '2159010',8)
,('OUT','2159010',178),('SMS','4153810',1),('OUT','2159010',152),('OUT','9140152',18),('SMS','4162672',1)
,('SMS','9168204',1),('OUT','9168204',576),('INC','2159010',5),('INC','2159010',4),('SMS','2159010',1)
,('SMS','4535614',1),('OUT','181868',20),('INC','181868',54),('INC','218748',20),('INC','2159010',9)
,('INC','197432',66),('SMS','2159010',1),('SMS','4535614',1);

select  * from call_details;


-----Question
---Write a query to retrieve a number 
---with that sum of the duration of outgoing is more than that of incoming.


--lets see total call duration on call type
SELECT
  call_number,
  SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE 0 END) AS total_outgoing_duration,
  SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE 0 END) AS total_incoming_duration
FROM call_details
GROUP BY call_number;



-----
SELECT
  call_number,
  SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE 0 END) AS total_outgoing_duration,
  SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE 0 END) AS total_incoming_duration
 
FROM call_details
GROUP BY call_number
HAVING
  SUM(CASE WHEN call_type = 'OUT' THEN call_duration ELSE 0 END) > SUM(CASE WHEN call_type = 'INC' THEN call_duration ELSE 0 END);
