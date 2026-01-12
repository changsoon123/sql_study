select file#, incremental_level, to_char(completion_time, 'yyyy-mm-dd hh24:mi:ss'), blocks, datafile_blocks, used_change_tracking 
from v$backup_datafile;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') time
from v$datafile a, v$backup b
where a.file# = b.file#;
?
select sequence#, name, first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, next_change#, to_char(next_time,'yyyy-mm-dd hh24:mi:ss') next_time 
from v$archived_log;

select file_id, tablespace_name, file_name, bytes/1024/1024 mb, autoextensible from dba_data_files;
