select /*+ gather_plan_statistics leading(d,e) use_hash(e) full(d) full(e) parallel(d 2) parallel(e 2) pq_distribute(e,hash,hash) opt_param('optimizer_features_enable','11.2.0.4')*/ e.employee_id, e.last_name, e.salary, d.department_id, d.department_name
from  hr.dept_non d, hr.emp_non e
where e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last parallel'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

select /*+ gather_plan_statistics leading(d,e) use_hash(e) full(d) full(e) parallel(d 2) parallel(e 2) pq_distribute(e,hash,hash)*/ 
        e.employee_id, e.last_name, e.salary, d.department_id, d.department_name
from  hr.dept_non d, hr.emp_non e
where e.department_id = d.department_id;

?
select /*+ gather_plan_statistics 
        leading(d,e) 
        use_hash(e) 
        full(d) 
        full(e) 
        parallel(d 2) 
        parallel(e 2) 
*/ 
e.employee_id,
e.last_name,
e.salary,
d.department_id,
d.department_name
from hr.dept_non d,
     hr.emp_non e
where e.department_id = d.department_id;

select /*+ gather_plan_statistics 
        leading(d,e) 
        use_hash(e) 
        full(d) 
        full(e) 
        parallel(d 2) 
        parallel(e 2)
        pq_distribute(e,broadcast,none)
*/ 
e.employee_id,
e.last_name,
e.salary,
d.department_id,
d.department_name
from hr.dept_non d,
     hr.emp_non e
where e.department_id = d.department_id;

select /*+ gather_plan_statistics 
        leading(d,e) 
        use_hash(e) 
        full(d) 
        full(e) 
        parallel(d 2) 
        parallel(e 2)
        pq_distribute(e,broadcast,none)
        no_pq_replicate(e)
*/ 
e.employee_id,
e.last_name,
e.salary,
d.department_id,
d.department_name
from hr.dept_non d,
     hr.emp_non e
where e.department_id = d.department_id;

select /*+ gather_plan_statistics 
        leading(d,e) 
        use_hash(e) 
        full(d) 
        full(e) 
        parallel(d 2) 
        parallel(e 2)
        pq_distribute(e,broadcast,none)
*/ 
e.employee_id,
e.last_name,
e.salary,
d.department_id,
d.department_name
from hr.dept_non d,
     hr.emp_non e
where e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last outline'));

select tq_id, server_type, process, num_rows, bytes, waits
from v$pq_tqstat
order by  tq_id,decode(substr(server_type,1,4),'Rang',1,'Prod',2,'Cons',3),process;

create table hr.emp_dw as
select rownum as employee_id, last_name, first_name, hire_date, job_id, salary, manager_id, department_id
from hr.employees e,(select level as id from dual connect by level <=10000);

create table hr.emp_dw_copy tablespace users as select * from hr.emp_dw where 1=2;

select blocks, bytes/1024/1024 mb from dba_segments where owner = 'HR' and segment_name = 'EMP_DW';

explain plan for
insert /*+ parallel(e1 2) */ into hr.emp_dw_copy e1
select /*+ parallel(e2 2) */ * from hr.emp_dw e2;

select * from table(dbms_xplan.display);

alter session enable parallel dml;
alter session disable parallel dml;

explain plan for
insert /*+ enable_parallel_dml parallel(e1 2) */ into hr.emp_dw_copy e1
select /*+ parallel(e2 2) */ * from hr.emp_dw e2;

select  a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm in ('_very_large_object_threshold','_small_table_threshold','_serial_direct_read');

select sid, event, total_waits, time_waited 
from v$session_event 
where sid = (select  sid from v$session where username='HR');

chkconfig --level 123456 xinetd off
 chkconfig --level 123456 sendmail off
 chkconfig --level 123456 cups off
 chkconfig --level 123456 cups-config-daemon off
 chkconfig --level 123456 smartd off
 chkconfig --level 123456 iptables off
 chkconfig --level 123456 ip6tables off
 chkconfig --level 123456 bluetooth off