select num_rows, blocks, avg_row_len, logging 
from dba_tables
where owner = 'HR' and table_name = 'EMP';

select /*+ gather_plan_statistics parallel(e 2) */ count(*) from hr.emp e;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select /*+ gather_plan_statistics parallel(e 2) */ * from hr.emp e;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select /*+ gather_plan_statistics parallel(e 2) */ *
            from hr.emp e
            order by last_name;
            
select *
from table(dbms_xplan.display_cursor(null, null, 'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select /*+ gather_plan_statistics parallel(e 4) */ *
            from hr.emp e
            order by last_name;
            
select *
from table(dbms_xplan.display_cursor(null, null, 'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select /*+ gather_plan_statistics parallel(e 2) */ department_id, count(*)
from hr.emp e group by department_id;


select /*+ gather_plan_statistics parallel(e 2) no_gby_pushdown */ department_id, count(*)
from hr.emp e group by department_id;

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select sum(cnt)
from hr.emp e
where department_id in (50,20,80,100)
group by department_id;

create table hr.emp_part
partition  by list(department_id)(
partition p_dept_1 values(10,20,30,40),
partition p_dept_2 values(50),
partition p_dept_3 values(60,70,80,90,100,110),
partition p_dept_4 values(default))
tablespace users
as select * from hr.employees; 

create table hr.dept_part
partition  by list(department_id)(
partition p_dept_1 values(10,20,30,40),
partition p_dept_2 values(50),
partition p_dept_3 values(60,70,80,90,100,110),
partition p_dept_4 values(default))
tablespace users
as select * from hr.departments;

exec dbms_stats.gather_table_stats('hr','emp_part',granularity=>'auto')
exec dbms_stats.gather_table_stats('hr','dept_part',granularity=>'auto')

select partition_position, partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_owner = 'HR' and table_name = 'EMP_PART';

select partition_position, partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_owner = 'HR' and table_name = 'DEPT_PART';

select * from dba_part_key_columns where name in ('EMP_PART', 'DEPT_PART');

select /*+ gather_plan_statistics leading(d,e) use_hash(e) full(d) full(e) parallel(d 2) parallel(e 2) pq_distribute(e,none,none) */ e.employee_id, e.last_name, e.salary, d.department_id, d.department_name
from  hr.dept_part d, hr.emp_part e
where e.department_id = d.department_id;

select *
from table(dbms_xplan.display_cursor(null, null, 'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select /*+ gather_plan_statistics leading(d,e) use_hash(e) full(d) full(e) parallel(d 2) parallel(e 2) pq_distribute(e,none,none) */ e.employee_id, e.last_name, e.salary, d.department_id, d.department_name
from  hr.dept_part d, hr.emp_part e
where e.department_id = d.department_id;

create table hr.emp_non tablespace users as select * from hr.employees;

select /*+ gather_plan_statistics leading(d,e) use_hash(e) full(d) full(e) parallel(d 2) parallel(e 2) pq_distribute(e,none,partition) */ e.employee_id, e.last_name, e.salary, d.department_id, d.department_name
from  hr.dept_part d, hr.emp_non e
where e.department_id = d.department_id;

select tq_id, server_type, process, num_rows, bytes, waits 
from v$pq_tqstat 
order by tq_id, decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3), process;

create table hr.dept_non tablespace users as select * from hr.departments;

select /*+ gather_plan_statistics leading(d,e) use_hash(e) full(d) full(e) parallel(d 2) parallel(e 2) pq_distribute(e,hash,hash) */ e.employee_id, e.last_name, e.salary, d.department_id, d.department_name
from  hr.dept_non d, hr.emp_non e
where e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits 
from v$pq_tqstat 
order by tq_id, decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3), process;