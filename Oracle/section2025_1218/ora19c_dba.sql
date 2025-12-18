select name from v$datafile;

select name from v$tempfile;

select name from v$controlfile;

select member from v$logfile;

select name, log_mode from v$database;

archive log list;

select file#, name, status, checkpoint_change# from v$datafile;

select * from v$recover_file;

select checkpoint_change# , scn_to_timestamp(checkpoint_change#) from v$database;

select * from v$log;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select segment_id, segment_name, owner, tablespace_name, status 
from dba_rollback_segs;

ALTER SYSTEM DISCONNECT SESSION 'SID,SERIAL#' POST_TRANSACTION;
ALTER SYSTEM DISCONNECT SESSION 'SID,SERIAL#' IMMEDIATE;
ALTER SYSTEM KILL SESSION 'sid,serial#' IMMEDIATE;

SELECT sid, serial#, username, status, osuser, program
FROM   v$session
WHERE  username = 'SYS';

create table hr.seg_new(id number) tablespace users;

select * from dba_tab_columns where owner = 'HR' and table_name = 'SEG_NEW';
select * from dba_tables where owner = 'HR' and table_name = 'SEG_NEW';
select * from dba_segments where owner = 'HR' and segment_name = 'SEG_NEW';
select * from hr.seg_new;

insert into hr.seg_new(id) values (1);

show parameter deferred_segment_creation;

select * from v$parameter where name = 'deferred_segment_creation';

rollback;

drop table hr.seg_new;

create table hr.seg_new(id number) segment creation immediate tablespace users;
create table hr.seg_new(id number) segment creation deferred tablespace users;

select * from dba_segments where owner = 'HR' and segment_name = 'SEG_NEW';

alter session set deferred_segment_creation = true;

create table hr.seg_new(id number) tablespace users;

create table hr.test1(id number) tablespace users;

insert into hr.test1(id) values(1);

commit;

select * from hr.test1;

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP'
and e.owner = 'HR';

insert into hr.test1(id) values(2);

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

SELECT username, default_tablespace
FROM   dba_users
WHERE  username = 'HR';

SELECT owner, table_name, tablespace_name
FROM   dba_tables
WHERE  owner = 'HR'
AND    table_name = 'EMPLOYEES';

SELECT DISTINCT e.file_id, f.file_name
FROM   dba_extents e
       JOIN dba_data_files f
         ON e.file_id = f.file_id
WHERE  e.owner        = 'HR'
AND    e.segment_name = 'EMPLOYEES'
AND    e.segment_type = 'TABLE';

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;


select checkpoint_change# , scn_to_timestamp(checkpoint_change#) from v$database;

select * from v$log;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select segment_id, segment_name, owner, tablespace_name, status 
from dba_rollback_segs;