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

select supplemental_log_data_min 
from v$database;

alter database add supplemental log data;

select object_type, count(*)
from dba_objects where owner = 'HR'
group by object_type;

begin
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo01.log',options=>dbms_logmnr.new);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log',options=>dbms_logmnr.addfile);
end;
/

select filename from v$logmnr_logs;

execute dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog)

select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss') time, operation, sql_redo
from v$logmnr_contents
where seg_owner = 'HR';

execute dbms_logmnr.end_logmnr;

alter system archive log current;

select name, to_char(created, 'yyyy-mm-dd hh24:mi:ss') time, log_mode from v$database;

select dbms_metadata.get_ddl('USER','HR') from dual;

set long 100000;

select default_tablespace, temporary_tablespace
from dba_users where username = 'HR';

select *
from dba_sys_privs
where grantee = 'HR';

create user hr
identified by oracle
default tablespace sysaux
temporary tablespace temp;

select dbms_metadata.get_ddl('USER','HR') from dual;

SELECT dbms_metadata.get_granted_ddl('SYSTEM_GRANT','HR') from dual;

select * from dba_ts_quotas where username = 'HR';

alter user hr quota 10m on users;

SELECT dbms_metadata.get_granted_ddl('TABLESPACE_QUOTA','HR') from dual;

SELECT dbms_metadata.get_granted_ddl('ROLE_GRANT','HR') from dual;

SELECT * from dba_role_privs where grantee = 'HR';

select constraint_name, constraint_type, search_condition, status, index_name
from dba_constraints
where owner = 'HR'
and table_name = 'EMP';

select constraint_name, constraint_type, search_condition, status, index_name
from user_constraints
where table_name = 'EMP';

select tablespace_name, file_name from dba_data_files;

select f.tablespace_name, f.file_name
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'INSA'
and e.owner = 'HR';

select * from dba_directories
where directory_name = 'PUMP_DIR';

select * from dba_tab_privs where grantee = 'HR';

select constraint_name, constraint_type, search_condition, status, index_name
from user_constraints
where table_name = 'EMP';

select constraint_name, constraint_type, search_condition, status, index_name
from dba_constraints
where owner = 'HR'
and table_name = 'EMP';