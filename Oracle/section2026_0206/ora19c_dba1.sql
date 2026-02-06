select salary, rowid from hr.emp order by 1;

select department_id, rowid from hr.emp order by 1;

create table hr.bitmap_table(id number, gender varchar2(10), marital varchar2(10)) tablespace users;

create bitmap index hr.gender_idx on hr.bitmap_table(gender) tablespace users;

create bitmap index hr.marital_idx on hr.bitmap_table(marital) tablespace users;

select index_name, index_type from dba_indexes where owner = 'HR' and table_name = 'BITMAP_TABLE';

select sid, serial#, username, blocking_session, event, sql_id, prev_sql_id
from v$session
where username = 'HR';

SELECT sql_text from v$sql where sql_id = '6gg0ffstm5bwm';

SELECT sql_text from v$sql where sql_id = '1d5kgzy4gz9za';

select sid, type, id1, id2, lmode, request, ctime, block
from v$lock
where sid in (select sid from v$session where username = 'HR')
and type in ('TX','TM');

insert into hr.bitmap_table(id,gender,marital) values(4,'m','n');

select * from user_sys_privs;

select /*+ gather_plan_statistics */  e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.employee_id = 100;

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

ALTER SYSTEM FLUSH SHARED_POOL;

ALTER SYSTEM FLUSH BUFFER_CACHE GLOBAL;

select ix.table_name,ix.index_name, ix.uniqueness, ic.column_name, ix.blevel, ix.leaf_blocks, ix.distinct_keys
from dba_indexes ix, dba_ind_columns ic
where ix.index_name = ic.index_name
and ix.table_name in ('EMPLOYEES','DEPARTMENTS','LOCATIONS')
and ix.owner = 'HR'
and ix.owner = ic.index_owner;

select /*+ gather_plan_statistics ordered use_nl(d)*/  e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.employee_id = 100;

select /*+ gather_plan_statistics leading(e,d) use_nl(d)*/  e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.employee_id = 100;

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

select /*+ gather_plan_statistics */  e.employee_id, e.last_name, e.salary, d.department_name, l.city
from hr.employees e, hr.departments d, hr.locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.employee_id = 100;

select /*+ gather_plan_statistics leading(e,d,l) use_nl(d) use_nl(l) */  e.employee_id, e.last_name, e.salary, d.department_name, l.city
from hr.employees e, hr.departments d, hr.locations l
where e.department_id = d.department_id
and d.location_id = l.location_id
and e.employee_id = 100;

select /*+ gather_plan_statistics */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.last_name = 'King';

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

select /*+ gather_plan_statistics opt_param('optimizer_features_enable','10.1.0') */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.last_name = 'King';

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

select /*+ gather_plan_statistics opt_param('optimizer_features_enable','10.1.0') */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));

select /*+ gather_plan_statistics opt_param('optimizer_features_enable','10.1.0') no_nlj_prefetch(e) */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1400;

select * from table(dbms_xplan.display_cursor(null, null, 'allstats last'));