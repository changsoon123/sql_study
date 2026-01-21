select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_kghdsidx_count';

select name, gets from v$latch_children where name = 'shared pool';

show parameter cpu_count;

declare
    v_cnt number;
begin
    for i in 1..100000 loop
        execute immediate 'select count(*) from dual where dummy = to_char('||i||')' into v_cnt;
    end loop;
end;
/

select sql_id,sql_text, parse_calls, loads, executions, invalidations
from v$sql
where sql_text like '%select count(*) from dual where dummy =%'
and sql_text not like '%v$sql%';

alter system flush shared_pool;

select sid, event, total_waits, time_waited 
from v$session_event 
where sid in (select sid from v$session where username = 'HR');

select plan_hash_value, count(*)
from v$sql
group by plan_hash_value
having count(*) > 100;

select sql_text from v$sql where plan_hash_value = 2522405774 and rownum=1;

alter system flush shared_pool;

select sql_id,sql_text, parse_calls, loads, executions, invalidations
from v$sql
where sql_text like '%select count(*) from dual where dummy =%'
and sql_text not like '%v$sql%';

declare
    v_cnt number;
begin
    for i in 1..100000 loop
        select count(*) into v_cnt from dual where dummy = to_char(i);
    end loop;
end;
/
alter session set session_cached_cursors = 0;
show parameter session_cached_cursors;

select sid, event, total_waits, time_waited 
from v$session_event 
where sid in (select sid from v$session where username = 'HR');

select sql_id,sql_text, parse_calls, loads, executions, invalidations
from v$sql
where sql_text like '%select count(*) into v_cnt from dual where dummy%'
and sql_text not like '%v$sql%';

alter system flush shared_pool;

declare
    v_cnt number;
begin
    for i in 1..100000 loop
        select count(*) into v_cnt from dual where dummy = to_char(i);
    end loop;
end;
/

alter session set session_cached_cursors = 50;
show parameter session_cached_cursors;

alter system flush shared_pool;

select sql_id, sql_text, version_count
from v$sqlarea
where sql_text like '%hr.employees%'
and sql_text not like '%v$sqlarea%';

select plan_hash_value, count(*)
from v$sql
group by plan_hash_value
having count(*) > 100;

select sql_text from v$sql where plan_hash_value = 2522405774 and rownum=1;

select * from v$sql_shared_cursor where sql_id = '0t028xxgcphg0';

select *
from v$sql_bind_capture
where sql_id = 'gqgwd5rvu5ftu';

select * from table(dbms_xplan.display_cursor('gqgwd5rvu5ftu',0));
select * from table(dbms_xplan.display_cursor('gqgwd5rvu5ftu',1));

drop table hr.emp purge;
drop table insa.emp purge;
create table hr.emp tablespace users as select * from hr.employees;
create table insa.emp tablespace users as select * from hr.employees;

select sql_id, sql_text, version_count
from v$sqlarea
where sql_text like '%hr.employees%'
and sql_text not like '%v$sqlarea%';

ALTER USER insa ACCOUNT UNLOCK;

ALTER USER insa IDENTIFIED BY oracle ACCOUNT UNLOCK;

alter system flush shared_pool;

select sql_id, sql_text, version_count
from v$sqlarea
where sql_text like 'select count(*) from emp where employee_id = 100%'
and sql_text not like '%v$sqlarea%';

select *
from v$sql_bind_capture
where sql_id = '3k29y3p86fuyc';

select * from v$sql_shared_cursor where sql_id = '3k29y3p86fuyc';

select * from table(dbms_xplan.display_cursor('3k29y3p86fuyc',0));
select * from table(dbms_xplan.display_cursor('3k29y3p86fuyc',1));

alter system flush shared_pool;

select sql_id, sql_text, version_count, address, hash_value
from v$sqlarea
where sql_text like '%hr.employees%'
and sql_text not like '%v$sqlarea%';

exec dbms_shared_pool.purge('00000000627083C8,4154637114','c');

select * from table(dbms_xplan.display_cursor('gqgwd5rvu5ftu',0));
select * from table(dbms_xplan.display_cursor('gqgwd5rvu5ftu',1));

select pool, name, bytes from v$sgastat where name = 'row cache';

select cache#, type, parameter from v$rowcache;

select * from dba_sequences where sequence_owner = 'HR' and sequence_name='SEQ_1';

declare
    v_value number;
begin
    for i in 1..100000 loop
        select hr.seq_1.nextval into v_value from dual;
    end loop;
end;
/

select h.address, h.saddr, s.sid, h.lock_mode
from v$rowcache_parent h, v$rowcache_parent w, v$session s
where h.address = w.address
and w.saddr = (select saddr from v$session where event = 'row cache lock' and rownum = 1)
and h.saddr = s.saddr
and h.lock_mode > 0;

select sid, event, total_waits, time_waited 
from v$session_event 
where sid in (select sid from v$session where username = 'HR');

select * from v$session where sid = 15;

select sql_text
from v$sql
where address = (select prev_sql_addr from v$session where sid = 15);

select * from dba_sequences where sequence_owner = 'HR' and sequence_name='SEQ_1';

alter sequence hr.seq_1 cache 20;

select h.address, h.saddr, s.sid, h.lock_mode
from v$rowcache_parent h, v$rowcache_parent w, v$session s
where h.address = w.address
and w.saddr = (select saddr from v$session where event = 'row cache lock' and rownum = 1)
and h.saddr = s.saddr
and h.lock_mode > 0;

select sid, event, total_waits, time_waited 
from v$session_event 
where sid in (select sid from v$session where username = 'HR');

alter sequence hr.seq_1 cache 100;