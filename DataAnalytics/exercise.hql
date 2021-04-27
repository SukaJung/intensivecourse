# 1
select * from products WHERE price < 1000 and brand=='Gigabux';
# 2
ALTER TABLE suppliers rename to vendors;
# 3
select name from products A JOIN (SELECT count(*) as num , prod_id FROM order_details GROUP BY prod_id order by num DESC limit 3) B ON A.prod_id=B.prod_id;
