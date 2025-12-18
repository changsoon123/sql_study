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

select s.username, s.sid, s.serial# , r.name, t.ubafil, t.xidusn, t.ubablk, t.used_ublk
from v$session s, v$transaction t, v$rollname r
where s.taddr = t.addr
and t.xidusn = r.usn;

create undo tablespace undo1 datafile '/u01/app/oracle/oradata/ORA19C/undo1' size 10m autoextend on;

alter system set undo_tablespace = undo1;

show parameter undo_tablespace;

select segment_id, segment_name, owner, tablespace_name, status
from dba_rollback_segs;

drop tablespace undotbs1 including contents and datafiles;

alter system set undo_tablespace = undotbs1 scope = spfile;

select segment_name||',' from dba_rollback_segs where status = 'ONLINE';

select username, temporary_tablespace from dba_users;

select * from database_properties;

select * from dba_temp_files;