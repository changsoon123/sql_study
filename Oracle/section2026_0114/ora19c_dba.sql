
select db_name, dbinc_key, tablespace_name, name from rc_datafile;

select f.tablespace_name, f.file_name, count(*)
from dba_extents e, dba_data_files f
where e.file_id = f.file_id
and e.segment_name = 'DEPARTMENTS'
and e.owner = 'HR'
group by f.tablespace_name, f.file_name;

select employee_id, rowid, dbms_rowid.rowid_block_number(rowid) from hr.employees;

select t.ts#, s.header_file, s.header_block
from v$tablespace t, dba_segments s
where t.name = s.tablespace_name
and s.segment_name = 'EMPLOYEES'
and s.owner = 'HR';

select current_scn, checkpoint_change#, scn_to_timestamp(checkpoint_change#), systimestamp 
from v$database;

select salary
from hr.employees as of timestamp to_timestamp('2026-01-07 10:54:35','yyyy-mm-dd hh24:mi:ss')
where employee_id = 200;

select salary
from hr.employees as of scn 3043072
where employee_id = 200;

select versions_xid, employee_id, salary
from hr.employees versions between timestamp to_timestamp('2026-01-14 10:54:35','yyyy-mm-dd hh24:mi:ss') and
to_timestamp('2026-01-14 11:04:30','yyyy-mm-dd hh24:mi:ss')
where employee_id=200;

select versions_xid, employee_id, salary
from hr.employees versions between scn 3043072 and 3044479
where employee_id=200;

select versions_xid, employee_id, salary
from hr.employees versions between scn minvalue and maxvalue
where employee_id=200;

update hr.employees
    set salary = (select salary
    from hr.employees as of timestamp to_timestamp('2026-01-14 10:54:35','yyyy-mm-dd hh24:mi:ss')
    where employee_id = 200)
where employee_id = 200;

select salary
from hr.employees
where employee_id = 200;

commit;


select salary
from hr.emp as of timestamp to_timestamp('2026-01-14 11:54:35','yyyy-mm-dd hh24:mi:ss')
where employee_id = 100;

select salary
from hr.emp as of timestamp to_timestamp('2026-01-14 13:12:00','yyyy-mm-dd hh24:mi:ss')
where employee_id = 130;

select salary
from hr.emp as of timestamp to_timestamp('2026-01-14 13:19:30','yyyy-mm-dd hh24:mi:ss')
where employee_id = 130;

select versions_xid, employee_id, salary
from hr.emp versions between timestamp to_timestamp('2026-01-14 11:18:30','yyyy-mm-dd hh24:mi:ss') 
and to_timestamp('2026-01-14 11:21:30','yyyy-mm-dd hh24:mi:ss') 
where employee_id = 100;

select versions_xid, employee_id, salary, last_name
from hr.emp versions between timestamp to_timestamp('2026-01-14 13:12:00','yyyy-mm-dd hh24:mi:ss') 
and to_timestamp('2026-01-14 13:19:30','yyyy-mm-dd hh24:mi:ss')
where employee_id = 130;

select versions_xid, versions_operation, versions_starttime, versions_endtime,
       employee_id, salary, last_name
from hr.emp versions between timestamp
     to_timestamp('2026-01-14 13:12:00','yyyy-mm-dd hh24:mi:ss')
 and to_timestamp('2026-01-14 13:19:30','yyyy-mm-dd hh24:mi:ss')
where employee_id = 130
order by versions_starttime;

select versions_xid, employee_id, salary
from hr.emp versions between timestamp minvalue and maxvalue
where employee_id = 130;

select supplemental_log_data_min from v$database;
alter database add supplemental log data;

select a.group#, a.sequence#, b.member, a.bytes/1024/1024 mb, a.status, a.first_change#, a.next_change#
from v$log a, v$logfile b
where a.group# = b.group#;

begin
dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log',options=>dbms_logmnr.new);
dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo02.log',options=>dbms_logmnr.addfile);
dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo01.log',options=>dbms_logmnr.addfile);
end;
/

execute dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);

select filename from v$logmnr_logs;

select to_char(timestamp, 'yyyy-mm-dd hh24:mi:ss'), operation, sql_redo, sql_undo
from v$logmnr_contents
where seg_owner = 'HR'
and seg_name = 'EMP';

execute dbms_logmnr.end_logmnr;

select *
from hr.emp as of timestamp to_timestamp('2026-01-14 11:58:10','yyyy-mm-dd hh24:mi:ss');

insert into hr.emp
select *
from hr.emp as of timestamp to_timestamp('2026-01-14 11:58:10','yyyy-mm-dd hh24:mi:ss');

select count(*) from hr.emp;

rollback;

flashback table hr.emp to timestamp to_timestamp('2026-01-14?11:58:10','yyyy-mm-dd?hh24:mi:ss');

select * from v$flash_recovery_area_usage;

select systimestamp from dual;

create restore point before_hr_trunc;

select * from v$restore_point;

select count(*) from hr.emp;

truncate table hr.emp;

select a.file#, b.name tbs_name, a.name file_name, a.checkpoint_change#, a.status
from v$datafile a, v$tablespace b
where a.ts# = b.ts#;

select * from dba_flashback_archive;
select * from dba_flashback_archive_tables;

select employee_id, salary from hr.emp where department_id = 20;

update hr.emp set salary = 3000 where department_id = 20;
commit;

select employee_id, salary
from hr.emp as of timestamp(systimestamp - interval '3' minute)
where department_id = 20;

select * from hr.emp where department_id = 30;
delete from hr.emp where department_id = 30;
commit;

select *
from hr.emp
where department_id = 30;

select *
from hr.emp as of timestamp(systimestamp - interval '5' minute)
where department_id = 30;

alter table hr.emp no flashback archive;
select * from dba_flashback_archive_tables;

select * from dba_flashback_archive;

select * from dba_flashback_archive_ts;

alter flashback archive fda1 modify tablespace fda_tbs quota 100m;