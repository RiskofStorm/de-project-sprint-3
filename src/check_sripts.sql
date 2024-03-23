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


SELECT item_id, SUM(payment_amount)
FROM mart.f_sales fs2 
WHERE status = 'refunded'
GROUP BY 1;

