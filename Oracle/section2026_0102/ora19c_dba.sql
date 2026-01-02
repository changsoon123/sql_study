select object_type, count(*)
from dba_objects where owner = 'HR'
group by object_type;

select supplemental_log_data_min 
from v$database;

alter database add supplemental log data;

select object_type, count(*)
from dba_objects where owner = 'HR'
group by object_type;

select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss') time, operation, sql_redo
from v$logmnr_contents
where seg_owner = 'HR';

begin
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo01.log',options=>dbms_logmnr.new);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log',options=>dbms_logmnr.addfile);
end;
/

select filename from v$logmnr_logs;

execute dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog)

select object_type, count(*)
from dba_objects where owner = 'HR'
group by object_type;

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

select a.file#, a.name, a.checkpoint_change#, b.status, b.change#, to_char(b.time, 'yyyy-mm-dd hh24:mi:ss') time
from v$datafile a, v$backup b
where a.file# = b.file#;

select sequence#, name, first_change#, to_char(first_time,'yyyy-mm-dd hh24:mi:ss') first_time, next_change#, to_char(next_time,'yyyy-mm-dd hh24:mi:ss') next_time 
from v$archived_log;

select f.tablespace_name, f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'INSA'
and e.owner = 'HR';

select constraint_name, constraint_type, search_condition, status, index_name
from dba_constraints
where table_name = 'JOB_HISTORY'
and owner = 'HR';

alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';
select * from dba_objects where owner = 'HR' and object_name='JOB_HISTORY';

select * from hr.employees where department_id=50 and job_id='ST_MAN';

select * from dba_datapump_jobs;

select * from dba_db_links;

create public database link xe_link connect to system identified by oracle using 'xe';

select * from dba_db_links;

select * from hr.employees@xe_link;

create user jan
identified by jan
default tablespace sysaux
temporary tablespace temp
quota unlimited on sysaux;

grant create session to jan;

select * from tab;

drop user jan cascade;