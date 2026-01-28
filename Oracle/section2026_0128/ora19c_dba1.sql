drop table hr.emp purge;

create table hr.emp tablespace users as select * from hr.employees;

update hr.emp set salary = salary * 1.1 where employee_id = 100;

select s.username,s.sid, t.xidusn, t.xidslot,t.xidsqn,t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr
and s.username = 'HR';

select *
from v$lock
where type in ('TX','TM') and sid = 170;

select object_name from dba_objects where object_id =74975;

select sid, type, id1, id2, lmode, request, ctime, block, to_char(trunc(id1/power(2,16))) usn,
       bitand(id1,to_number('ffff','xxxx'))+0 slot, id2 sqn
from v$lock
where type in ('TX','TM') and sid = 170;

update hr.emp set salary = salary * 1.2 where employee_id = 100;

select sid, type, id1, id2, lmode, request, ctime, block, to_char(trunc(id1/power(2,16))) usn,
       bitand(id1,to_number('ffff','xxxx'))+0 slot, id2 sqn
from v$lock
where type in ('TX','TM') and sid in (select sid from v$session where username = 'HR')
order by 1;

select * from v$session where username = 'HR';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session where event like '%TX%';

select sql_text from v$sql where sql_id = '8sjbnzfxs5w8x';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session 
where sid in (select blocking_session from v$session where event like '%TX%');

select sql_text from v$sql where sql_id = '43qd0u7n4j2nk';


select * from v$session where event like '%TX%';

select row_wait_obj#, row_wait_file#, row_wait_block#, row_wait_row#
from v$session
where event like '%TX%';

select
        rowid,
        dbms_rowid.rowid_object(rowid) data_object_id,
        dbms_rowid.rowid_relative_fno(rowid) file_no,
        dbms_rowid.rowid_block_number(rowid) block_no,
        dbms_rowid.rowid_row_number(rowid) row_slot_no,
        employee_id
from hr.employees
where employee_id = 100;

select object_name, object_type from dba_objects where data_object_id = 74975;

select file_name, tablespace_name from dba_data_files where file_id = 7;

select extent_id, file_id, block_id, blocks from dba_extents where owner = 'HR' and segment_name = 'EMP';

select
    dbms_rowid.rowid_create(0,74975,7,587,0) as "restricted rowid",
    dbms_rowid.rowid_create(1,74975,7,587,0) as "extended rowid"
from dual;

--restricted rowid(v7) 力茄等 rowid 6byte : #block.#rowslot.#file
--extended rowid(v8) 犬厘等 rowid 10byte : #data_object_id(6磊府) #file(3磊府) #block(6磊府) #rowslot(3磊府)

select *
from hr.emp
where rowid = 'AAASTfAAHAAAAJLAAA';

update hr.emp set salary = salary * 1.2 where employee_id = 101;

select sid, type, id1, id2, lmode, request, ctime, block, to_char(trunc(id1/power(2,16))) usn,
       bitand(id1,to_number('ffff','xxxx'))+0 slot, id2 sqn
from v$lock
where type in ('TX','TM') and sid in (select sid from v$session where username = 'HR')
order by 1;

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session where event like '%TX%';

select sql_text from v$sql where sql_id = '8sjbnzfxs5w8x';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session 
where sid in (select blocking_session from v$session where event like '%TX%');

select
    dbms_rowid.rowid_create(0,74975,7,587,0) as "restricted rowid",
    dbms_rowid.rowid_create(1,74975,7,587,0) as "extended rowid"
from dual;

select *
from hr.emp
where rowid = 'AAASTfAAHAAAAJLAAA';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id, 'alter system kill session '||''''||sid||','||serial#||''''||' immediate;' kill_sql
from v$session 
where sid in (select blocking_session from v$session where event like '%TX%');

alter system kill session '49,3009' immediate;

select sid, type, id1, id2, lmode, request, ctime, block, to_char(trunc(id1/power(2,16))) usn,
       bitand(id1,to_number('ffff','xxxx'))+0 slot, id2 sqn
from v$lock
where type in ('TX','TM') and sid in (select sid from v$session where username = 'HR')
order by 1;

create table hr.unique_test(id number) tablespace users;

create unique index hr.unique_test_idx on hr.unique_test(id);

select index_name, uniqueness from dba_indexes where table_name = 'UNIQUE_TEST';

select index_name, uniqueness from user_indexes where table_name = 'UNIQUE_TEST';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session where event like '%TX%';

select sql_text from v$sql where sql_id = 'afm91tjsmrqsn';
select sql_text from v$sql where sql_id = 'c84ynr1u8hbs2';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id, 'alter system kill session '||''''||sid||','||serial#||''''||' immediate;' kill_sql
from v$session 
where sid in (select blocking_session from v$session where event like '%TX%');

select sql_text from v$sql where sql_id = '7w5ga3044ckm7';

drop table hr.emp purge;

create table hr.emp 
nologging 
tablespace users
as
select rownum  emp_id, last_name, first_name, salary, department_id
from hr.employees, (select rownum emp_id from dual connect by level < = 100000)
order by dbms_random.value;

select blocks, bytes/1024/1024 mb from dba_segments where owner = 'HR' and segment_name = 'EMP';

select sid, type, id1, id2, lmode, request, ctime, block, to_char(trunc(id1/power(2,16))) usn,
       bitand(id1,to_number('ffff','xxxx'))+0 slot, id2 sqn
from v$lock
where type in ('TX','TM') and sid in (select sid from v$session where username = 'HR')
order by 1;

create index hr.emp_name_idx on hr.emp(last_name,first_name) tablespace users;

delete from hr.emp where emp_id = 100;

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session where event like '%TM%';