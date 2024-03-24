DELETE FROM mart.f_customer_retention
WHERE period_id IN (
                    SELECT DISTINCT period_id
                    FROM mart.f_customer_retention fcr
                        INNER JOIN mart.d_calendar dc ON fcr.period_id = dc.week_of_year 
                    WHERE dc.week_of_year = DATE_PART('week', '{{ds}}'::DATE)
);


WITH
customer_stats AS (
SELECT *
FROM mart.f_sales
           INNER JOIN mart.d_calendar on f_sales.date_id = d_calendar.date_id
WHERE week_of_year = DATE_PART('week', '{{ds}}'::DATE)
  
),
new_customers AS (
	SELECT DISTINCT customer_id
	FROM customer_stats
	GROUP BY customer_id
	HAVING COUNT(customer_id) = 1
),
returning_customers AS (
	SELECT DISTINCT customer_id
	FROM customer_stats
	GROUP BY customer_id
	HAVING COUNT(customer_id) > 1
),
refunded_customers AS (
	SELECT DISTINCT customer_id
	FROM customer_stats
	WHERE status = 'refunded'
)

INSERT INTO mart.f_customer_retention(new_customers_count, 
                                      returning_customers_count,
                                      refunded_customer_count,
                                      period_name,
                                      period_id,
                                      item_id,
                                      new_customers_revenue,
                                      returning_customers_revenue,
                                      customers_refunded
                                      )
SELECT COUNT(new_c.customer_id) "new_customers_count",
	   COUNT(ret_c.customer_id) "returning_customers_count",
	   COUNT(ref_c.customer_id) "refunded_customer_count",
	   'weekly' "period_name",
	   cs.week_of_year "period_id",
	   cs.item_id,
	   SUM(CASE WHEN new_c.customer_id IS NOT NULL THEN payment_amount ELSE 0 END) "new_customers_revenue",
	   SUM(CASE WHEN ret_c.customer_id IS NOT NULL THEN payment_amount ELSE 0 END) "returning_customers_revenue",
	   SUM(CASE WHEN ref_c.customer_id IS NOT NULL THEN payment_amount ELSE 0 END) "customers_refunded"
FROM customer_stats cs
	LEFT JOIN new_customers new_c ON cs.customer_id = new_c.customer_id
	LEFT JOIN returning_customers ret_c ON cs.customer_id = ret_c.customer_id
	LEFT JOIN refunded_customers ref_c ON cs.customer_id = ref_c.customer_id
GROUP BY cs.item_id, cs.week_of_year
ORDER BY cs.week_of_year