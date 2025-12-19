recover tablespace users;

alter database open;

select * from v$recover_file;

ALTER SYSTEM KILL SESSION 'sid,serial#' IMMEDIATE;

SELECT sid, serial#, username, status, osuser, program
FROM   v$session
WHERE  username = 'HR';

select checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$database;

SELECT status from v$instance;

select * from v$log;

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP'
and e.owner = 'HR';

select checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$database;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select segment_id, segment_name, owner, tablespace_name, status 
from dba_rollback_segs;

select s.username, s.sid, s.serial# , r.name, t.ubafil, t.xidusn, t.ubablk, t.used_ublk
from v$session s, v$transaction t, v$rollname r
where s.taddr = t.addr
and t.xidusn = r.usn;

create table hr.emp tablespace users as select * from hr.employees where 1=2;

INSERT INTO hr.emp select * from hr.employees;

commit;

create tablespace data_tbs datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' size 5m;

drop tablespace data_tbs including contents and datafiles;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

create table hr.new(id number) tablespace data_tbs;

insert into hr.new(id) values(1);

commit;