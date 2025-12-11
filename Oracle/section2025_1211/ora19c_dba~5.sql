select table_name, tablespace_name
from dba_tables
where table_name in ('AUD$','FGA_LOG$');

select * from sys.fga_log$;