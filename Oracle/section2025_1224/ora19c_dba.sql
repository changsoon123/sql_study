SELECT status from v$instance;

select * from v$log;

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP_2025'
and e.owner = 'HR'
group by f.tablespace_name, f.file_name;

select checkpoint_change#, scn_to_timestamp(checkpoint_change#) from v$database;

select a.file#, to_char(a.creation_time, 'yyyy-mm-dd hh24:mi:ss') creation_time, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

create table hr.test_new(id number) tablespace data_tbs;

insert into hr.test_new(id) values(1);

commit;

create tablespace data_tbs datafile '/u01/app/oracle/oradata/ORA19C/data_tbs01.dbf' size 5m;

select * from hr.test_new;

select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') time
from v$datafile a, v$backup b
where a.file# = b.file#;

select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') time
from v$datafile a, v$backup b
where a.file# = b.file#(+);

select * from v$log;

select * from v$archived_log;

select sequence#, name, first_change#, next_change# from v$archived_log;

select segment_id, segment_name, owner, tablespace_name,status
from dba_rollback_segs;

select s.username, s.sid, s.serial#, r.name, t.ubafil, t.xidusn, t.ubablk, t.used_ublk
from v$session s, v$transaction t, v$rollname r
where s.taddr = t.addr
and t.xidusn = r.usn;