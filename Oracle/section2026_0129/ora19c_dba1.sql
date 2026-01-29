drop table hr.emp purge;

create table hr.emp 
nologging 
tablespace users
as
select rownum  emp_id, last_name, first_name, salary, department_id
from hr.employees, (select rownum emp_id from dual connect by level < = 100000)
order by dbms_random.value;

create index hr.emp_name_idx on hr.emp(last_name,first_name) online tablespace users;

select owner, object_name, object_type from dba_objects where object_id = ;

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session where event like '%TX%';

select sid, type, id1, id2, lmode, request, ctime, block, to_char(trunc(id1/power(2,16))) usn,
       bitand(id1,to_number('ffff','xxxx'))+0 slot, id2 sqn
from v$lock
where type in ('TX','TM') and sid in (select sid from v$session where username = 'HR')
order by 1;

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id, 'alter system kill session '||''''||sid||','||serial#||''''||' immediate;' kill_sql
from v$session 
where sid in (select blocking_session from v$session where event like '%TX%');

select sql_text from v$sql where sql_id = 'g4y6nw3tts7cc';

select owner, object_name, object_type from dba_objects where object_id = 74999;

delete from hr.emp where emp_id = 100;

select * from hr.SYS_JOURNAL_74998;

alter index hr.emp_name_idx rebuild;

delete from hr.emp where emp_id = 100;

alter index hr.emp_name_idx rebuild online;

select sid,serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session
where username = 'HR';

create table hr.itl_table(id number, l_name varchar2(1000), f_name varchar2(1000)) 
initrans 1 maxtrans 2 pctfree 0 tablespace users;

select ini_trans, max_trans, pct_free from dba_tables where table_name = 'ITL_TABLE';

insert into hr.itl_table(id, l_name, f_name)
select level, rpad('x', 1000,'x'), rpad('z',1000,'z')
from dual
connect by level <= 10;

commit;

select num_rows,blocks, avg_row_len, ini_trans, max_trans, pct_free from dba_tables where table_name = 'ITL_TABLE';

select id, rowid, dbms_rowid.rowid_block_number(rowid) from hr.itl_table order by 1;

execute dbms_stats.gather_table_stats('hr','itl_table');

update hr.itl_table
set l_name = rpad('y',1000,'y'), f_name = rpad('a',1000,'a')
where id = 3;

select sid,serial#, username, blocking_session, event, sql_id, prev_sql_id 
from v$session
where username = 'HR';

grant select on v_$mystat to hr;

select * from v$segment_statistics where owner = 'HR' and statistic_name = 'ITL waits' and value <> 0;

alter table hr.itl_table initrans 3 pctfree 10;

select num_rows,blocks, avg_row_len, ini_trans, max_trans, pct_free from dba_tables where table_name = 'ITL_TABLE';

select object_id, data_object_id from dba_objects where object_name = 'ITL_TABLE';
select id, rowid, dbms_rowid.rowid_block_number(rowid) from hr.itl_table order by 1;

alter table hr.itl_table move;

create table hr.mig_table(id number, l_name varchar2(2000), f_name varchar2(2000)) tablespace users;

insert into hr.mig_table(id,l_name,f_name)
select level,
        decode(mod(level,3), 1, null, rpad('x',2000,'x')),
        decode(mod(level,3), 1, null, rpad('x',2000,'x'))
from dual
connect by level <= 1000;

commit;

select * from hr.mig_table;

select num_rows, blocks, chain_cnt from dba_tables where table_name = 'MIG_TABLE';

execute dbms_stats.gather_table_stats('hr','mig_table');

create index mig_table_idx on hr.mig_table(id) tablespace users;

update hr.mig_table
set l_name = rpad('x',2000,'x'), f_name = rpad('x',2000,'x')
where mod(id,3) = 1;

select * from v$sysstat where name = 'table fetch continued row';

select to_char(sysdate,'yyyy-mm-dd hh24:ss:ss') day, a.sid, vss.username, a.name, a.value
    from (
    select vst.sid,vst.value,vsn.name,vsn.statistic#
    from v$statname vsn, v$sesstat vst
    where vsn.statistic# = vst.statistic#
    order by vst.value desc) a, v$session vss
    where a.sid = vss.sid
    and vss.username = 'HR'
    and a.name =  'table fetch continued row';