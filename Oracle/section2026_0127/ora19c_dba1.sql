select
    rowid,
    dbms_rowid.rowid_object(rowid) data_object_id,
    dbms_rowid.rowid_relative_fno(rowid) file_no,
    dbms_rowid.rowid_block_number(rowid) block_no,
    dbms_rowid.rowid_row_number(rowid) row_slot_no,
    employee_id
from hr.employees
where employee_id = 100;

alter session set tracefile_identifier='hr_rollback_trans';

alter system dump datafile 3 block 31267;

select * from dba_tables where owner='HR' and table_name='EMPLOYEES';

update hr.employees set salary = 20000 where employee_id = 100;

alter session set tracefile_identifier='after_trans';

select s.username, t.xidusn, t.xidslot,t.xidsqn,t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr;

select n.usn, n.name, s.extents, s.rssize, s.xacts, s.status
from v$rollname n, v$rollstat s
where n.usn = s.usn;

select to_number('0a','xx'),to_number('db4','xxx'),to_number('48f3','xxxx')
from dual;

select
    rowid,
    dbms_rowid.rowid_object(rowid) data_object_id,
    dbms_rowid.rowid_relative_fno(rowid) file_no,
    dbms_rowid.rowid_block_number(rowid) block_no,
    dbms_rowid.rowid_row_number(rowid) row_slot_no,
    employee_id
from hr.employees
where employee_id = 101;

rollback;

select * from dba_tablespaces;

create tablespace flm_tbs
datafile '/u01/app/oracle/oradata/ORA19C/flm_tbs01.dbf' size 100m autoextend on
extent management local uniform size 1m
segment space management manual;

select * from dba_tablespaces;

create table hr.flm_table(id char(1000)) storage(freelists 1) tablespace flm_tbs;

select * from dba_tables where owner='HR' and table_name='FLM_TABLE';

begin
    for i in 1..100000 loop
        insert into flm_table(id) values('oracle'||i);
    end loop;
    commit;
end;
/

select sid, event, total_waits, time_waited
from v$session_event
where sid in (select sid from v$session where username = 'HR');

truncate table hr.flm_table;

select pct_used, freelists from dba_tables where owner='HR' and table_name='FLM_TABLE';

alter table hr.flm_table storage(freelists 2);

drop tablespace flm_tbs including contents and datafiles;

create tablespace assm_tbs
datafile '/u01/app/oracle/oradata/ORA19C/assm_tbs01.dbf' size 100m autoextend on
extent management local uniform size 1m
segment space management auto;

create table hr.assm_table(id char(1000)) storage(freelists 1) tablespace assm_tbs;

select * from dba_tables where owner='HR' and table_name='ASSM_TABLE';

begin
    for i in 1..100000 loop
        insert into assm_table(id) values('oracle'||i);
    end loop;
    commit;
end;
/

select sid, event, total_waits, time_waited
from v$session_event
where sid in (select sid from v$session where username = 'HR');