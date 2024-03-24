DELETE FROM mart.f_sales
WHERE date_id IN (
                    SELECT DISTINCT date_id
                    FROM mart.f_sales
                        INNER JOIN mart.d_calendar USING(date_id)
                    WHERE week_of_year = DATE_PART('week', '{{ds}}'::DATE)
);


INSERT INTO mart.f_sales (date_id, item_id, customer_id, city_id, quantity, payment_amount, status)
SELECT dc.date_id, 
       item_id,
       customer_id,
       city_id,
       quantity, 
       CASE WHEN status = 'refunded' THEN payment_amount * -1 ELSE payment_amount END "payment_amount",
       status 
FROM staging.user_order_log uol
LEFT JOIN mart.d_calendar AS dc ON uol.date_time::Date = dc.date_actual
WHERE uol.date_time::Date = '{{ds}}';

-- ALTER TABLE mart.f_sales
-- SET COLUMN payment_amount = payment_amount * -1
-- WHERE status = 'refunded'