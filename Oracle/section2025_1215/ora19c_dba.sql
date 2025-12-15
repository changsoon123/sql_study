select * from dba_tablespaces;

drop tablespace insa_tbs including contents and datafiles;

drop tablespace insa_temp including contents and datafiles;

select checkpoint_change# from v$database;

select current_scn from v$database;

select checkpoint_change# ,current_scn from v$database;

select checkpoint_change# ,scn_to_timestamp(checkpoint_change#) from v$database;

select name, checkpoint_change# from v$datafile;

select * from v$log;

select f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'EMP'
and e.owner = 'HR';