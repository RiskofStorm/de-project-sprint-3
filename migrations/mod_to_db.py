import psycopg2
from airflow.hooks.base import BaseHook





psql_conn = BaseHook.get_connection('postgresql_de')

conn = psycopg2.connect(f"dbname='de' port='{psql_conn.port}' user='{psql_conn.login}' host='{psql_conn.host}' password='{psql_conn.password}'")

try:
    with conn.cursor() as cursor:
        cursor.execute(open("mod_user_order_log.sql", "r").read())
        cursor.execute(open("ddl_mart_f_customer_retention.sql", "r").read())
finally:
    conn.close()
