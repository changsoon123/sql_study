select * from v$instance;

select * from v$database;

select * from dba_data_files;

select * from v$parameter;

select * from v$datafile;
select * from dba_data_files;
select * from v$tempfile;
select * from dba_temp_files;
select * from v$log;
select * from v$logfile;

select * from v$session;

select * from v$parameter;

select sysdate from dual;

select * from v$parameter where name = 'nls_date_format';

select * from v$parameter where isses_modifiable = 'FALSE';

select * from v$parameter where isses_modifiable = 'TRUE';

select * from v$parameter where issys_modifiable in ('IMMEDIATE','DEFERRED');

select * from v$parameter where name = 'processes';

select * from v$parameter where name = 'open_cursors';

select name, value, default_value, issys_modifiable from v$parameter where name = 'open_cursors';

alter system set open_cursors = 100 scope = spfile;
alter system set open_cursors = 100 scope = memory;
alter system set open_cursors = 100 scope = both;

select * from v$parameter where issys_modifiable = 'DEFERRED';

alter session set sort_area_size = 1048576;

alter system set sort_area_size = 1048576 deferred;

select * from v$parameter where name = 'sort_area_size';

alter system set sort_area_size = 2048576 deferred;

select * from v$parameter where name = 'sort_area_size';
