with first_table as(
select 	o1.order_id, shipping_limit_date, price, freight_value,
		o2.customer_id, order_status, order_purchase_timestamp,
		p.product_category_name
from batch_32.order_items_data as o1
left join batch_32.orders_data as o2
on o1.order_id = o2.order_id
left join batch_32.product_data as p
on o1.product_id = p.product_id),
second_table as(
select f.*, c.customer_city, c.customer_state
from first_table as f
left join batch_32.customer_data as c
on f.customer_id = c.customer_id)

select product_category_name, count(distinct order_id) as number_of_order
from second_table
where product_category_name like '%fashion%'
group by product_category_name