select    a.ksppinm  parameter, b.ksppstvl session_value, c.ksppstvl  instance_value 
from   x$ksppi a,   x$ksppcv b,   x$ksppsv c 
where   a.indx = b.indx   
and   a.indx = c.indx  
and   a.ksppinm in ('_optim_peek_user_binds','_optimizer_adaptive_cursor_sharing');

alter system flush shared_pool;

select sql_id, sql_text, parse_calls, loads, executions, is_bind_sensitive, is_bind_aware
from v$sql
where sql_text like 'select * from hr.employees where department_id%'
and sql_text not like'%v$sql%';

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMPLOYEES'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

select name, value_string, last_captured from v$sql_bind_capture where sql_id = '7rg8b56swjsud';
select * from table(dbms_xplan.display_cursor('7rg8b56swjsud'));

select sql_id,sql_text,version_count
from v$sqlarea
where sql_text like '%hr.employees%'
and sql_text not like '%v$sqlarea%'
and sql_text not like '%v$sql%';


select sql_id, sql_text, parse_calls, loads, executions, is_bind_sensitive, is_bind_aware
from v$sql
where sql_text like 'select count(*) from hr.t1 where c1%'
and sql_text not like'%v$sql%';

select child_number,name,value_string from v$sql_bind_capture where sql_id = 'gp53qk41apt2v';
select * from table(dbms_xplan.display_cursor('gp53qk41apt2v',0));
select * from table(dbms_xplan.display_cursor('gp53qk41apt2v',1));

select sql_id,sql_text,version_count
from v$sqlarea
where sql_text like '%select count(*) from hr.t1 where c1%'
and sql_text not like '%v$sqlarea%'
and sql_text not like '%v$sql%';

select sql_id, child_number,bind_equiv_failure from v$sql_shared_cursor where sql_id = 'gp53qk41apt2v';

drop table hr.t1 purge;

create table hr.t1(c1 varchar2(1), c2 number) tablespace users;

insert into hr.t1(c1,c2)
select 'a', level from dual connect by level <= 100000
union all
select 'b', level from dual connect by level <= 100000
union all
select 'c', level from dual connect by level <= 100
union all
select 'd', level from dual connect by level <= 90;

commit;

select c1, count(*) from hr.t1 group by c1;

create index hr.t1_idx on hr.t1(c1) tablespace users;

exec dbms_stats.gather_table_stats('hr','t1',method_opt=>'for columns c1 size 4');

alter system flush shared_pool;

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct,
             1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality,
             c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'T1'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

select sql_id,sql_text,version_count
from v$sqlarea
where sql_text like '%select count(*) from hr.t1 where c1%'
and sql_text not like '%v$sqlarea%'
and sql_text not like '%v$sql%';

select /*+ gather_plan_statistics */ * from hr.t1 where c1 = 'c';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select blocks from dba_segments where owner = 'HR' and segment_name = 'T1';

select /*+ gather_plan_statistics full(t) */ * from hr.t1 t where :b_c1 in ('a','b') and c1 = :b_c1
union all
select /*+ gather_plan_statistics index(t t1_idx) */ * from hr.t1 t where :b_c1 in('c','d') and c1 = :b_c1;