SELECT payment_amount, status
FROM mart.f_sales fs2 
WHERE status = 'refunded';

SELECT *
FROM mart.f_sales fs2 ;



SELECT *
FROM mart.d_customer dc ; 

SELECT *
FROM staging.user_order_log uol ;

SELECT * 
FROM mart.f_customer_retention;



DELETE FROM mart.f_sales;
DELETE FROM mart.f_customer_retention;
DELETE FROM mart.d_city;
DELETE FROM mart.d_customer;
DELETE FROM mart.d_item;
DELETE FROM staging.user_order_log;



SELECT * 
FROM mart.f_sales fs2 
WHERE status = 'refunded';

SELECT *
FROM mart.f_customer_retention fcr 


SELECT COUNT(*)
FROM mart.f_sales fs2  


SELECT item_id, SUM(payment_amount)
FROM mart.f_sales fs2 
WHERE status = 'refunded'
GROUP BY 1;


-- Inspection on duplicates

SELECT uniq_id, COUNT(*)
FROM staging.user_order_log uol 
GROUP BY 1
HAVING COUNT(*) > 1


SELECT date_time::timestamp
FROM staging.user_order_log uol 

SELECT * FROM  staging.user_order_log uol 


SELECT dc.date_id, item_id, customer_id, city_id, quantity, payment_amount,
--       CASE WHEN status = 'refunded' THEN payment_amount * -1 ELSE payment_amount END "payment_amount",
       status 
FROM staging.user_order_log uol
LEFT JOIN mart.d_calendar AS dc ON uol.date_time::Date = dc.date_actual