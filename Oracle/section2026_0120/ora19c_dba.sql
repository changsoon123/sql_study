select sql_id, sql_text,parse_calls,loads, executions, hash_value, plan_hash_value
from v$sql
where sql_text like '%hr.employees%'
and sql_text not like '%v$sql%';

select  * from v$sql_plan where sql_id = 'crmr8navwm6mf';

select * from table(dbms_xplan.display_cursor('8xub92asajn2s'));

select sql_id, sql_text from v$sql where plan_hash_value = 1833546154;

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') 
from dba_tables 
where owner='HR' and table_name='EMP';

alter system flush shared_pool;

alter table hr.emp modify last_name varchar2(40);

select sql_id, sql_text,parse_calls,loads, executions, invalidations
from v$sql
where sql_text like '%hr.emp%'
and sql_text not like '%v$sql%';

select * from table(dbms_xplan.display_cursor('8qhp0dmv9q94d'));

alter table hr.emp add constraint emp_id_pk primary key(employee_id);

execute dbms_stats.gather_table_stats('hr','emp');

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss')
from dba_tables
where owner='HR' and table_name='EMP';

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_optimizer_invalidation_period';

begin
    for i in 1..10000 loop
        execute immediate 'create or replace procedure p1 is begin null; end;';
    end loop;
end;
/

select client_info, sid from v$session where client_info in ('sess_1','sess_2');

select sid, event, wait_class, wait_time, seconds_in_wait, state
from v$session_wait 
where sid in (154,168);

select sid, event, total_waits, time_waited
from v$session_event 
where sid in (154,168);

select sid, event, wait_class, wait_time, seconds_in_wait, state
from v$session_wait 
where sid in (select sid from v$session where username = 'HR');

select sid from v$session where username = 'HR';

grant execute on dbms_lock to hr;

create or replace procedure hr.pin_proc(p_time in number)
is
begin
    dbms_lock.sleep(p_time);
end pin_proc;
/

select sid, event, wait_class, wait_time, seconds_in_wait, state
from v$session_wait 
where sid in (select sid from v$session where username = 'HR');

select sid, event, total_waits, time_waited
from v$session_event 
where sid in (select sid from v$session where username = 'HR');