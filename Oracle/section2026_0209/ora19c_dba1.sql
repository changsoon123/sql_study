select /*+ gather_plan_statistics opt_param('optimizer_features_enable','10.1.0') no_nlj_prefetch(e) */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select 
	employee_id, 
    department_id,
	rowid extended_format,
	dbms_rowid.rowid_object(rowid) as data_object_id,
	dbms_rowid.rowid_relative_fno(rowid) as file_no,
	dbms_rowid.rowid_block_number(rowid) as block_no,
	dbms_rowid.rowid_row_number(rowid) as row_slot_no,
	dbms_rowid.rowid_to_restricted(rowid,0) retricted_format
from hr.emp
order by department_id;

select /*+ gather_plan_statistics opt_param('optimizer_features_enable','10.1.0') */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select /*+ gather_plan_statistics opt_param('optimizer_features_enable','10.1.0') */ e.employee_id, e.last_name,e.salary,d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ e.employee_id, e.last_name,e.salary,d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select /*+ gather_plan_statistics leading(d,e) use_nl(e) nlj_batching(e) */ e.employee_id, e.last_name,e.salary,d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select /*+ gather_plan_statistics leading(d,e) use_nl(e) no_nlj_batching(e) */ e.employee_id, e.last_name,e.salary,d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

drop table hr.emp purge;
drop table hr.dept purge;
drop table hr.loc purge;

create table hr.emp tablespace users as select * from hr.employees;
create table hr.dept tablespace users as select * from hr.departments;
create table hr.loc tablespace users as select * from hr.locations;

select table_name, num_rows, blocks, avg_row_len, to_char(last_analyzed) analyzed
from dba_tables
where owner = 'HR'
and table_name in ('EMP','DEPT','LOC');

SELECT /*+ gather_plan_statistics */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    e.employee_id   = 100;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

SELECT /*+ gather_plan_statistics leading(e,d,l) use_nl(d) use_nl(l)*/
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    e.employee_id   = 100;

select a.table_name, a.constraint_name, b.column_name, a.constraint_type, a.search_condition, a.r_constraint_name,a.index_name
from dba_constraints a, dba_cons_columns b
where a.constraint_name = b.constraint_name
and a.table_name  in('EMP','DEPT','LOC')
and a.owner = 'HR';

create unique index hr.emp_idx on hr.emp(employee_id) tablespace users;

alter table hr.emp add constraint emp_pk primary key(employee_id) using index hr.emp_idx;

create unique index hr.emp_idx on hr.emp(employee_id) tablespace users;

alter table hr.emp add constraint emp_pk primary key(employee_id);

SELECT /*+ gather_plan_statistics leading(e,d,l) use_nl(d) use_nl(l)*/
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    e.employee_id   = 100;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

create unique index hr.dept_idx on hr.dept(department_id);
alter table hr.dept add constraint dept_pk primary key(department_id);
alter table hr.dept add constraint dept_pk primary key(department_id) using hr.dept_idx;

select ix.index_name, ix.uniqueness, ic.column_name
from dba_indexes ix, dba_ind_columns ic
where ix.index_name = ic.index_name
and ix.table_name = 'DEPT'
and ix.owner = 'HR';

create unique index hr.loc_idx on hr.loc(location_id);
alter table hr.loc add constraint loc_pk primary key(location_id) using hr.loc_idx;
alter table hr.loc add constraint loc_pk primary key(location_id);

select ix.index_name, ix.uniqueness, ic.column_name
from dba_indexes ix, dba_ind_columns ic
where ix.index_name = ic.index_name
and ix.table_name = 'LOC'
and ix.owner = 'HR';

SELECT /*+ gather_plan_statistics leading(e,d,l) use_nl(d) use_nl(l)*/
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    e.employee_id   = 100;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

SELECT /*+ gather_plan_statistics */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    l.city = 'Seattle';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

SELECT /*+ gather_plan_statistics leading(l,d,e) use_nl(d) use_nl(e) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    l.city = 'Seattle';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select * from hr.loc where city = 'Seattle';

select * from hr.dept where location_id = 1700;

select a.table_name, a.constraint_name, b.column_name, a.constraint_type, a.search_condition, a.r_constraint_name,a.index_name
from dba_constraints a, dba_cons_columns b
where a.constraint_name = b.constraint_name
and a.table_name  in('EMP','DEPT','LOC')
and a.owner = 'HR';

create index hr.loc_city_idx on hr.loc(city) tablespace users;
create index hr.dept_loc_idx on hr.dept(location_id) tablespace users;
create index hr.emp_dept_idx on hr.emp(department_id) tablespace users;

select ix.index_name, ix.uniqueness, ic.column_name
from dba_indexes ix, dba_ind_columns ic
where ix.index_name = ic.index_name
and ix.table_name in ('EMP','DEPT','LOC')
and ix.owner = 'HR';

SELECT /*+ gather_plan_statistics leading(l,d,e) use_nl(d) use_nl(e) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    l.city = 'Seattle';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

SELECT /*+ gather_plan_statistics leading(l,d,e) use_nl(d) use_nl(e) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    l.city = 'London';

SELECT /*+ gather_plan_statistics */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    l.city = 'Seattle'
AND e.job_id = 'AD_VP';

select e.employee_id, e.last_name, e.salary, d.department_name, d.location_id
from hr.emp e, hr.dept d
where e.department_id = d.department_id
and e.job_id = 'AD_VP';

select d.location_id, d.department_id, d.department_name, l.city
from hr.dept d, hr.loc l
where d.location_id = l.location_id
and l.city = 'Seattle';

SELECT /*+ gather_plan_statistics leading(e,d,l) use_nl(d) use_nl(l) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name,
       l.city
FROM   hr.emp  e,
       hr.dept d,
       hr.loc  l
WHERE  e.department_id = d.department_id
AND    d.location_id   = l.location_id
AND    l.city = 'Seattle'
AND    e.job_id = 'AD_VP';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

create index hr.emp_job_idx on hr.emp(job_id);

select ix.index_name, ix.uniqueness, ic.column_name
from dba_indexes ix, dba_ind_columns ic
where ix.index_name = ic.index_name
and ix.table_name in ('EMP','DEPT','LOC')
and ix.owner = 'HR';

SELECT /*+ gather_plan_statistics leading(e,d) use_nl(d) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT /*+ gather_plan_statistics leading(d,e) use_nl(e) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT /*+ gather_plan_statistics leading(d,e) use_nl(e) full(e) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT /*+ gather_plan_statistics leading(d,e) use_nl(e) use_nl_with_index(e emp_dept_idx)*/
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

SELECT /*+ gather_plan_statistics leading(e,d) use_nl(d) use_nl_with_index(d dept_idx)*/
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT /*+ gather_plan_statistics leading(d,e) use_nl(e) use_nl_with_index(e emp_dept_idx)*/
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT /*+ gather_plan_statistics */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT /*+ gather_plan_statistics leading(d,e) use_merge(e) */
       e.employee_id,
       e.last_name,
       e.salary,
       d.department_name
FROM   hr.emp  e,
       hr.dept d
WHERE  e.department_id = d.department_id;

SELECT department_name,department_id
FROM   hr.dept
order by department_id;

SELECT department_id,employee_id,last_name,salary
FROM   hr.emp
order by department_id;