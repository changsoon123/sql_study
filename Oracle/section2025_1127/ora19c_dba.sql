select * from v$parameter where issys_modifiable = 'DEFERRED';

select name, value, default_value, issys_modifiable from v$parameter where name = 'sort_area_size';

select name, value, default_value, issys_modifiable from v$parameter where name = 'sga_max_size';

select * from v$sgastat where pool = 'shared pool';

SELECT * FROM dba_data_files;
SELECT * FROM dba_temp_files;

select * from dba_segments where tablespace_name = 'SYSTEM';
select * from dba_segments where tablespace_name = 'SYSAUX';

SELECT * FROM dba_users;

SELECT * FROM user$;

select * from dba_objects where owner = 'HR';
SELECT * FROM obj$;
select * from dba_tables where owner = 'HR';
SELECT * FROM tab$;
SELECT * FROM col$;

select * from v$sql;