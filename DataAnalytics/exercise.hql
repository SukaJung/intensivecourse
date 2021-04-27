# 1
select * from products WHERE price < 1000 and brand=='Gigabux';
# 2
ALTER TABLE suppliers rename to vendors;
# 3
select name, count(*) as num from products group by name order by num DESC limit3;
