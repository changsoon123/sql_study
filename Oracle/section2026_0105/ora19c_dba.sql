select table_name, tablespace_name from user_tables;

select table_name, tablespace_name from dba_tables where table_name = 'EMP';

select constraint_name, constraint_type, search_condition, status, index_name
from dba_constraints
where table_name = 'JOB_HISTORY'
and owner = 'HR';

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
?
select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') time
from v$datafile a, v$backup b
where a.file# = b.file#;
?
select sequence#, name, first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, next_change#, to_char(next_time,'yyyy-mm-dd hh24:mi:ss') next_time 
from v$archived_log;

alter database add supplemental log data;

select supplemental_log_data_min from v$database;

select username from dba_users where username ='HR';

ALTER USER system ACCOUNT UNLOCK;

select supplemental_log_data_min from v$database;

alter database add supplemental log data;

begin
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log',options=>dbms_logmnr.new);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo02.log',options=>dbms_logmnr.addfile);
end;
/

execute dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);

select filename from v$logmnr_logs;

select timestamp, operation, sql_redo, sql_undo
from v$logmnr_contents
where seg_name = 'ITWILL';

execute dbms_logmnr.end_logmnr;

select f.tablespace_name, f.file_name
from dba_extents e, dba_data_files f
where f.file_id = e.file_id
and e.segment_name = 'EMP_NEW'
and e.owner = 'HR';