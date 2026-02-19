
select * from dba_tab_stats_history where owner='HR' and table_name='TAB';

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed , 
       stale_stats, stattype_locked
from dba_tab_statistics
where owner='HR' and table_name='TAB';

select * from dba_tab_stats_history;

exec dbms_stats.purge_stats(systimestamp - 5);

exec dbms_stats.gather_table_stats('hr','tab',method_opt=>'for columns col1 size 254');

exec dbms_stats.purge_stats(to_timestamp_tz('2026-02-19 09:54:12 +09:00','yyyy-mm-dd hh24:mi:ss tzh:tzm'));

exec dbms_stats.delete_table_stats('hr','tab');

exec dbms_stats.set_table_stats(ownname=>'hr',tabname=>'tab',numrows=>1100,numblks=>5,avgrlen=>7);

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed , 
       stale_stats, stattype_locked
from dba_tab_statistics
where owner='HR' and table_name='TAB';

show parameter cursor_sharing;

CREATE TABLE hr.t1(c1 varchar2(1), c2 number) tablespace users;

insert into hr.t1(c1,c2)
select 'a', level from dual connect by level <= 10000
union all
select 'b', level from dual connect by level <= 100
union all
select 'c', level from dual connect by level <= 100;

commit;

select c1, count(*) from hr.t1 group by c1;

create index hr.t1_idx on hr.t1(c1) tablespace users;

select count(*) from hr.t1 where c1='a';

select count(*) from hr.t1 where c1='b';

select count(*) from hr.t1 where c1='c';

alter system flush shared_pool;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select count(*) from hr.t1 where c1%'
and sql_text not like'%v$sql%';

select * from table(dbms_xplan.display_cursor('chhaptn94t3mf'));
select * from table(dbms_xplan.display_cursor('282yth3zwxm20'));
select * from table(dbms_xplan.display_cursor('fspvq62nfvx8j'));

alter session set cursor_sharing = force;

select count(*) from hr.t1 where c1='a';

select count(*) from hr.t1 where c1='b';

select count(*) from hr.t1 where c1='c';

select * from table(dbms_xplan.display_cursor('3t9zsjd6kxdnd'));

select count(*) from hr.t1 where c1='b';
select count(*) from hr.t1 where c1='a';
select count(*) from hr.t1 where c1='c';

select * from table(dbms_xplan.display_cursor('3t9zsjd6kxdnd'));

exec dbms_stats.gather_table_stats('hr','t1',method_opt=>'for columns size 3 c1');

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'T1'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

alter system flush shared_pool;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select count(*) from hr.t1 where c1%'
and sql_text not like'%v$sql%';

alter session set cursor_sharing = exact;

select count(*) from hr.t1 where c1='b';

select count(*) from hr.t1 where c1='a';

select count(*) from hr.t1 where c1='c';

select * from table(dbms_xplan.display_cursor('3t9zsjd6kxdnd'));

alter system flush shared_pool;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select count(*) from hr.t1 where c1%'
and sql_text not like'%v$sql%';

alter session set cursor_sharing = exact;

select count(*) from hr.t1 where c1='b';

select count(*) from hr.t1 where c1='a';

select count(*) from hr.t1 where c1='c';

select * from table(dbms_xplan.display_cursor('3t9zsjd6kxdnd'));

select count(*) from hr.t1 where c1=:b_id;

select    a.ksppinm  parameter, b.ksppstvl session_value, c.ksppstvl  instance_value 
from   x$ksppi a,   x$ksppcv b,   x$ksppsv c 
where   a.indx = b.indx   
and   a.indx = c.indx  
and   a.ksppinm in ('_optim_peek_user_binds','_optimizer_adaptive_cursor_sharing');

alter session set "_optimizer_adaptive_cursor_sharing"=false;

alter session set "_optim_peek_user_binds"=false;

select * from table(dbms_xplan.display_cursor('gp53qk41apt2v'));

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'T1'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

select * from table(dbms_xplan.display_cursor('gp53qk41apt2v'));

alter session set "_optimizer_adaptive_cursor_sharing"=false;

alter session set "_optim_peek_user_binds"=true;

select * from table(dbms_xplan.display_cursor('gp53qk41apt2v',0));
select * from table(dbms_xplan.display_cursor('gp53qk41apt2v',1));
select * from table(dbms_xplan.display_cursor('gp53qk41apt2v'));

alter system flush shared_pool;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select count(*) from hr.t1 where c1%'
and sql_text not like'%v$sql%';

select * from hr.employees where employee_id = 100;
select * from hr.employees where employee_id = 101;
select * from hr.employees where employee_id = 102;
select * from hr.employees where employee_id = 103;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select * from hr.employees where employee_id%'
and sql_text not like'%v$sql%';

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMPLOYEES'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

select * from hr.employees where department_id = 10;
select * from hr.employees where department_id = 20;
select * from hr.employees where department_id = 50;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select * from hr.employees where department_id%'
and sql_text not like'%v$sql%';

select * from table(dbms_xplan.display_cursor('4787hrf22agj3'));

alter session set cursor_sharing = force;

select * from table(dbms_xplan.display_cursor('4787hrf22agj3'));

select name, value_string, last_captured from v$sql_bind_capture where sql_id = '4787hrf22agj3';

exec dbms_stats.delete_table_stats('hr','employees');

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMPLOYEES'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

exec dbms_stats.gather_table_stats('hr','employees',method_opt=>'for all columns size 1')

select name, value_string, last_captured from v$sql_bind_capture where sql_id = '4787hrf22agj3';

select * from table(dbms_xplan.display_cursor('4787hrf22agj3'));

alter system flush shared_pool;
alter session set cursor_sharing = exact;

select * from hr.employees where department_id = 20;
select * from hr.employees where department_id = 50;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select * from hr.employees where department_id%'
and sql_text not like'%v$sql%';

select * from table(dbms_xplan.display_cursor('1nq4du390k3q6'));
select * from table(dbms_xplan.display_cursor('0ac1ytgpdkya9'));

exec dbms_stats.gather_table_stats('hr','employees',method_opt=>'for columns size 20 department_id')

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMPLOYEES'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

alter system flush shared_pool;
alter session set cursor_sharing = similar;
select * from hr.employees where department_id = 50;
select * from hr.employees where department_id = 20;

select sql_id, sql_text, parse_calls, loads, executions
from v$sql
where sql_text like 'select * from hr.employees where department_id%'
and sql_text not like'%v$sql%';

select * from table(dbms_xplan.display_cursor('1nq4du390k3q6'));
select * from table(dbms_xplan.display_cursor('4787hrf22agj3'));

select name, value_string, last_captured from v$sql_bind_capture where sql_id = '4787hrf22agj3';

select sql_id,sql_text,version_count
from v$sqlarea
where sql_text like '%hr.employees%'
and sql_text not like '%v$sqlarea%'
and sql_text not like '%v$sql%';

select    a.ksppinm  parameter, b.ksppstvl session_value, c.ksppstvl  instance_value 
from   x$ksppi a,   x$ksppcv b,   x$ksppsv c 
where   a.indx = b.indx   
and   a.indx = c.indx  
and   a.ksppinm in ('_optim_peek_user_binds','_optimizer_adaptive_cursor_sharing');