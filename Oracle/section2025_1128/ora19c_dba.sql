select * from v$parameter where name = 'shared_pool_size';

select sum(bytes)/1024/1024 mb from v$sgastat where pool = 'shared pool';

select * from v$sga_dynamic_components;

select * from v$parameter where name = 'db_cache_size';
select * from v$parameter where name like '%cache_size';

select * from v$parameter where name = 'log_buffer';

select * from v$parameter where name = 'large_pool_size';

select * from v$sga_dynamic_components;

select * from v$parameter where name = 'java_pool_size';

select * from v$sga_dynamic_components;

select * from v$parameter where name = 'streams_pool_size';

select * from v$sga_dynamic_components;

select * from v$log;
select * from v$logfile;
