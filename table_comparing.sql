drop table main;
drop table target;

create table main(
num int, 
mname varchar(50)
);

create table target(
tnum int, 
tname varchar(50)
);


insert into main values(10,'AA'),(20,'BB'),(30,'CC'),(40,'DD');
insert into target values(10,'AA'),(20,'BB'),(40,'ZZ'),(50,'YY');
select * from main;
select * from target; 


--3 new in main
--4 mismatched 
--5 new in target 

with cte as (
select * from main as m 
full outer join target as t 
on m.num=t.tnum)
select *,
case 
when num is not null and tnum is null then 'available in  main table' 
when tnum is not null and num is null then 'available in target table' 
when num=tnum and mname != tname then 'mismatched' 
else 'Ok'  end as review from cte



















































