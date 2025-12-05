CREATE TABLESPACE dw_tbs
datafile '/home/oracle/userdata/dw_tbs01.dbf' size 5m autoextend on
extent management local uniform size 1m
segment space management auto;

alter tablespace dw_tbs add datafile '/home/oracle/userdata/dw_tbs02.dbf' size 5m autoextend off;

alter database datafile '/home/oracle/userdata/dw_tbs02.dbf' autoextend on;

create table hr.emp_dw 
tablespace dw_tbs
as SELECT * FROM hr.employees;

alter tablespace dw_tbs offline normal;

select *
from v$datafile v, dba_data_files d
WHERE v.file# = d.file_id;

alter tablespace dw_tbs rename datafile '/home/oracle/userdata/dw_tbs01.dbf' to '/u01/app/oracle/oradata/ORA19C/dw_tbs01.dbf';
alter tablespace dw_tbs rename datafile '/home/oracle/userdata/dw_tbs02.dbf' to '/u01/app/oracle/oradata/ORA19C/dw_tbs02.dbf';

select * from v$datafile;

ALTER TABLESPACE dw_tbs drop datafile '/u01/app/oracle/oradata/ORA19C/dw_tbs01.dbf';

ALTER DATABASE DATAFILE '/home/oracle/userdata/dw_tbs02.dbf' ONLINE;

DROP TABLESPACE dw_tbs INCLUDING CONTENTS AND DATAFILES;

alter tablespace dw_tbs online;

select * from dba_tablespaces;

select * from dba_tables where owner = 'HR' and table_name = 'EMPLOYEES';

CREATE TABLESPACE oltp_tbs
datafile '/home/oracle/userdata/dw_tbs01.dbf' size 5m autoextend on
blocksize 4k
extent management local uniform size 1m
segment space management auto;

create table hr.emp_oltp
tablespace oltp_tbs
as select * from hr.employees;

select * from dba_segments where owner = 'HR' and segment_name = 'EMP_OLTP';
select * from dba_extents where owner = 'HR' and segment_name = 'EMP_OLTP';
select * from dba_tables where owner = 'HR' and table_name = 'EMP_OLTP';

SELECT * FROM v$buffer_pool;

drop tablespace oltp_tbs including contents and datafiles;

alter system set db_4k_cache_size = 0;

select * from dba_tablespaces;

select * from v$parameter where name like 'undo%';

select n.usn , n.name, s.extents, s.rssize, s.xacts, s.status
from v$rollname n, v$rollstat s
where n.usn = s.usn;

select s.username, t.xidusn, t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr;

select * from v$session where username = 'HR';

select * from dba_data_files;

rollback;

select * from dba_data_files;

alter tablespace undotbs1 add datafile '/u01/app/oracle/oradata/ORA19C/undotbs02.dbf' size 10m autoextend on;

alter tablespace undotbs1 drop datafile '/u01/app/oracle/oradata/ORA19C/undotbs02.dbf';

create undo tablespace undo1
datafile '/u01/app/oracle/oradata/ORA19C/undo01.dbf' size 10m autoextend on;

select * from dba_tablespaces;

select * from v$parameter where name like 'undo%';

select n.usn , n.name, s.extents, s.rssize, s.xacts, s.status
from v$rollname n, v$rollstat s
where n.usn = s.usn;

select s.username, t.xidusn, t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr;

select * from dba_rollback_segs;

alter system set undo_tablespace = undo1 scope = both;

alter system set undo_tablespace = undotbs1 scope = both;

rollback;

select n.usn , n.name, s.extents, s.rssize, s.xacts, s.status
from v$rollname n, v$rollstat s
where n.usn = s.usn;

select s.username, t.xidusn, t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr;

select * from dba_rollback_segs;

select * from v$parameter where name like 'undo%';

alter system set undo_retention = 1800;

select * from dba_tablespaces;

alter tablespace undotbs1 retention noguarantee;

drop tablespace undo1 including contents and datafiles;

create user ora1 identified by oracle;

grant create session, create table to ora1;

select * from database_properties;

SELECT * FROM dba_users where username = 'ORA1';

SELECT * FROM database_properties;

select * from dba_data_files;

CREATE TABLESPACE oltp_tbs
datafile '/u01/app/oracle/oradata/ORA19C/oltp_tbs01.dbf' size 5m autoextend on
extent management local uniform size 1m
segment space management auto;

drop tablespace oltp_tbs;

create temporary tablespace oltp_temp
tempfile '/u01/app/oracle/oradata/ORA19C/oltp_temp01.dbf' size 5m autoextend on
extent management local uniform size 1m
segment space management manual;

select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_temp_files;

create user ora2
identified by oracle
default tablespace oltp_tbs
temporary tablespace oltp_temp
quota 1m on oltp_tbs;

select * from dba_users;

create user ora3
identified by oracle;

SELECT * FROM database_properties;

alter database default tablespace users;
alter database default temporary tablespace temp;

create user ora4
identified by oracle;

SELECT * FROM database_properties;

select * from dba_users;

select * from dba_users where username = 'ORA2';

alter user ora2
default tablespace oltp_tbs
temporary tablespace oltp_temp;

drop tablespace users including contents and datafiles;

drop tablespace temp including contents and datafiles;