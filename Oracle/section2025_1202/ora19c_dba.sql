select a.group# , a.sequence# , b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#
order by 1;

alter database drop logfile member '/u01/app/oracle/fast_recovery_area/ORA19C/onlinelog/redo01.log';

alter database drop logfile member '/u01/app/oracle/oradata/ORA19C/redo01.log';

alter database add logfile group 1 '/u01/app/oracle/oradata/ORA19C/redo01.log' size 50m;

alter database drop logfile group 1;

alter database add logfile group 1 '/u01/app/oracle/oradata/ORA19C/redo01.log' size 50m;

select a.group# , a.sequence# , b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#
order by 1;

alter database drop logfile group 2;

alter database drop logfile group 1;

alter database add logfile group 3 '/u01/app/oracle/oradata/ORA19C/redo03.log' size 50m;
alter database drop logfile group 4;

alter system switch logfile;
alter system checkpoint;
alter database drop logfile group 5;

select * from dba_tablespaces;
select * from dba_data_files;

drop table hr.emp purge;

create table hr.emp
tablespace userdata
as select * from hr.employees;

create tablespace userdata
datafile '/u01/app/oracle/oradata/ORA19C/userdata01.dbf' size 10m;

drop table hr.emp purge;

create table hr.emp
tablespace userdata
as select * from hr.employees;

truncate table hr.emp;

select * from dba_segments where owner = 'HR' and segment_name = 'EMP';
select * from dba_extents where owner = 'HR' and segment_name = 'EMP'; 

insert into hr.emp select * from hr.emp;

rollback;

drop tablespace userdata including contents and datafiles;

create tablespace userdata 
datafile '/u01/app/oracle/oradata/ORA19C/userdata01.dbf' size 5m autoextend on;

drop tablespace userdata including contents and datafiles;

truncate table hr.emp;