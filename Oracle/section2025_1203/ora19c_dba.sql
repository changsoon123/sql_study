SELECT * FROM dba_tablespaces;

select * from dba_data_files;

drop tablespace userdata including contents and datafiles;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m;

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' resize 10m;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' autoextend on;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' autoextend off;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' resize 5m;

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

alter tablespace insa_tab add datafile '/u01/app/oracle/oradata/ORA19C/insa_tab02.dbf' size 5m;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' autoextend on;
alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab02.dbf' autoextend on;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' autoextend off;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' autoextend on;

alter database datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' autoextend on next 2m maxsize 10m;

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

drop tablespace insa_tab including contents and datafiles;

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m
extent management local uniform size 1m;

create table hr.insa
tablespace insa_tab
as select * from hr.employees;

select * from dba_segments where owner = 'HR' and segment_name='INSA';
select * from dba_extents where owner = 'HR' and segment_name='INSA';

insert into hr.insa
select * from hr.insa;

rollback;

select * from dba_tablespaces;
SELECT * FROM fet$;
SELECT * FROM uet$;

drop tablespace insa_tab including contents and datafiles;

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m
extent management local autoallocate;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m
extent management local uniform;

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

drop tablespace insa_tab including contents and datafiles;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m
extent management local
segment space management manual;

create table hr.insa
tablespace insa_tab
as select * from hr.employees;

select * from dba_tables where table_name = 'INSA';


drop tablespace insa_tab including contents and datafiles;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m
extent management local
segment space management auto;

create table hr.insa
tablespace insa_tab
as select * from hr.employees;

select * from dba_tables where table_name = 'INSA';
select * from dba_segments where table_name = 'INSA';

SELECT * FROM dba_tablespaces;
select * from dba_data_files;

select * from dba_extents where owner='HR' and segment_name = 'INSA';
select * from dba_segments where owner='HR' and segment_name = 'INSA';

drop tablespace insa_tab including contents and datafiles;

create tablespace insa_tab
datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m;

create table hr.insa
tablespace insa_tab
as select * from hr.employees;

select count(*) from hr.insa;

SELECT * FROM dba_tablespaces;

select * from dba_data_files;

alter system checkpoint;

select * from v$datafile;

select d.file_id, d.tablespace_name, d.file_name, v.checkpoint_change#, v.enabled
from v$datafile v, dba_data_files d
where v.file# = d.file_id;

alter tablespace insa_tab read write;

select * from hr.insa where employee_id = 100;

update hr.insa set salary = salary * 1.1 where employee_id = 100;

delete from hr.insa where employee_id = 100;

insert into hr.insa select * from hr.employees;

create table hr.insa_dept tablespace insa_tab as select * from hr.departments;

desc hr.insa;

alter table hr.insa modify last_name varchar2(30);

alter table hr.insa add dept_name varchar2(30);

alter table hr.insa drop column dept_name;

truncate table hr.insa;

drop table hr.insa purge;

alter tablespace insa_tab read write;

select d.file_id, d.tablespace_name, d.file_name, v.checkpoint_change#, v.enabled, d.online_status
from v$datafile v, dba_data_files d
where v.file# = d.file_id;

create table hr.insa
tablespace insa_tab
as select * from hr.employees;

alter tablespace insa_tab offline;

select count(*) from hr.insa;


alter tablespace insa_tab online;

drop tablespace insa_tab including contents and datafiles;

create tablespace insa_tab
datafile '/home/oracle/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m;

create table hr.insa
tablespace insa_tab
as select * from hr.employees;

select count(*) from hr.insa;

alter tablespace insa_tab offline normal;

alter tablespace insa_tab rename datafile '/home/oracle/insa_tab01.dbf' to '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf';

alter tablespace insa_tab online;

select d.file_id, d.tablespace_name, d.file_name, v.checkpoint_change#, v.enabled, d.online_status
from v$datafile v, dba_data_files d
where v.file# = d.file_id;

alter tablespace insa_tab rename datafile '/u01/app/oracle/oradata/ORA19C/insa_tab01.dbf' to '/home/oracle/insa_tab01.dbf';

drop tablespace insa_tab including contents and datafiles;

create tablespace insa_tab
datafile '/home/oracle/insa_tab01.dbf' size 5m autoextend on next 2m maxsize 10m;

select status from v$instance;
select name from v$datafile;
select name from v$tempfile;
