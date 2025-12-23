select * from dba_temp_files;

select * from database_properties;

select * from v$log;

select * from v$database_incarnation;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') time
from v$datafile a, v$backup b
where a.file# = b.file#;

alter database begin backup;

select sequence#, name, first_change#, next_change# from v$archived_log;

select * from v$database_incarnation;

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'TEST'
and e.owner = 'HR';

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMPLOYEES'
and e.owner = 'HR';

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'TEST_NEW'
and e.owner = 'HR';