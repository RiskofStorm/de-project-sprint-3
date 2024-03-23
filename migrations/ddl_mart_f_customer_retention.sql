DROP TABLE IF EXISTS mart.f_customer_retention;
CREATE TABLE IF NOT EXISTS mart.f_customer_retention(
	 id BIGINT GENERATED ALWAYS AS IDENTITY NOT NULL,
	 new_customers_count BIGINT NOT NULL, 
	 returning_customers_count BIGINT NOT NULL,
	 refunded_customer_count BIGINT NOT NULL,
	 period_name VARCHAR(20) NOT NULL,
	 period_id INT4  NOT NULL,
	 item_id INT4 NOT NULL,
	 new_customers_revenue NUMERIC(12,2) NOT NULL,
	 returning_customers_revenue NUMERIC(12,2) NOT NULL,
	 customers_refunded NUMERIC(12,2) NOT NULL,
	 CONSTRAINT f_customer_retention_pkey PRIMARY KEY(id)
--	 ,CONSTRAINT f_customer_retention_date_id_fkey FOREIGN KEY (period_id) REFERENCES mart.d_calendar(week_of_year) --почему не работает?
	 ,CONSTRAINT	f_customer_retention_item_id_fkey FOREIGN KEY (item_id) REFERENCES mart.d_item(item_id)
)