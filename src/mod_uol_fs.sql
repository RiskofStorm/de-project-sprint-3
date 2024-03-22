
ALTER TABLE staging.user_order_log
ADD COLUMN IF NOT EXISTS "status" VARCHAR(30) DEFAULT 'shipped';


ALTER TABLE mart.f_sales
ADD COLUMN IF NOT EXISTS "status" VARCHAR(30);

-- ALTER TABLE staging.user_order_log
-- SET status = 'shipped';