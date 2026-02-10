select /*+ gather_plan_statistics leading(e,d,l) use_merge(d) use_merge(l)*/ 
        e.employee_id, e.last_name, e.salary, d.department_name, l.city, l.street_address
from hr.emp e, hr.dept d, hr.loc l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics leading(l,d,e) use_merge(d) use_merge(e)*/ 
        e.employee_id, e.last_name, e.salary, d.department_name, l.city, l.street_address
from hr.emp e, hr.dept d, hr.loc l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ 
        d.department_id, d.department_name, sum(e.salary) sum_sal
from hr.emp e, hr.dept d
where e.department_id = d.department_id
group by d.department_id, d.department_name;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics leading(e,d) use_merge(d)*/ 
        d.department_id, d.department_name, sum(e.salary) sum_sal
from hr.emp e, hr.dept d
where e.department_id = d.department_id
group by d.department_id, d.department_name;

select /*+ gather_plan_statistics */ d.department_id, d.department_name, e.sum_sal
from (select department_id, sum(salary) sum_sal
        from hr.emp
        group by department_id) e, hr.dept d
where e.department_id = d.department_id;

select /*+ gather_plan_statistics leading(e,d) use_merge(d) */ d.department_id, d.department_name, e.sum_sal
from (select department_id, sum(salary) sum_sal
        from hr.emp
        group by department_id
        order by department_id) e, hr.dept d
where e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select department_id, sum(salary) sum_sal
        from hr.emp
        group by department_id;
        
select /*+ gather_plan_statistics leading(d,e) use_merge(e) */ d.department_id, d.department_name, e.sum_sal
from (select department_id, sum(salary) sum_sal
        from hr.emp
        group by department_id
        order by department_id) e, hr.dept d
where e.department_id = d.department_id;

select /*+ gather_plan_statistics leading(d,e) use_hash(e) */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id;

select ora_hash(department_id,10,0),department_id, department_name
from hr.dept
order by 1;

select ora_hash(department_id,10,0),department_id,employee_id, last_name, salary
from hr.emp
order by 1;

select /*+ gather_plan_statistics leading(e,d) use_hash(d) */ e.employee_id, e.last_name, e.salary, d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics leading(l,d,e) use_hash(d) use_hash(e) */ e.employee_id, e.last_name, e.salary
       ,d.department_name,l.city,l.postal_code
from hr.emp e, hr.dept d, hr.loc l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select /*+ gather_plan_statistics leading(d,e,l) use_hash(e) use_hash(l) */ e.employee_id, e.last_name, e.salary
       ,d.department_name,l.city,l.postal_code
from hr.emp e, hr.dept d, hr.loc l
where e.department_id = d.department_id
and d.location_id = l.location_id;

select /*+ gather_plan_statistics */ e.employee_id, e.last_name, e.salary
       ,d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id(+);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics leading(d,e) use_hash(e) */ e.employee_id, e.last_name, e.salary
       ,d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id(+);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics leading(d,e) use_merge(e) */ e.employee_id, e.last_name, e.salary
       ,d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id(+);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics use_nl(d) */ e.employee_id, e.last_name, e.salary
       ,d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id(+);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics use_merge(d) */ e.employee_id, e.last_name, e.salary
       ,d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id(+);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics swap_join_inputs(d) */ e.employee_id, e.last_name, e.salary
       ,d.department_name
from hr.emp e, hr.dept d
where e.department_id = d.department_id(+);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select department_id from hr.departments);

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select /*+ no_unnest */ department_id from hr.departments);

select /*+ gather_plan_statistics */ *
from hr.employees e
where department_id in (select /*+ no_unnest */ 'x' 
                        from hr.departments
                        where department_id = e.department_id);
                        
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
                        
select /*+ gather_plan_statistics */ *
from hr.employees e
where exists (select /*+ no_unnest */ 'x'
      from hr.departments
      where department_id = e.department_id);
      
select employee_id, last_name, salary, department_id from hr.employees;

select department_id from hr.departments;

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_query_execution_cache_max_size';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ e.*
from hr.employees e, hr.departments d
where e.department_id = d.department_id;

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select department_id from hr.departments);

select u.table_name, c.column_name, u.constraint_name, u.constraint_type,u.search_condition, u.r_constraint_name, u.index_name
from dba_constraints u, dba_cons_columns c
where u.constraint_name = c.constraint_name
and u.table_name in ('EMPLOYEES','DEPARTMENTS')
and u.owner = 'HR'
order by 1;

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_optimizer_join_elimination_enabled';

alter session set "_optimizer_join_elimination_enabled" = true;

select /*+ gather_plan_statistics */ *
from hr.emp
where department_id in (select department_id from hr.dept);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select department_id from hr.departments);

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select /*+ no_eliminate_join(d) */ department_id from hr.departments d);

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select department_id from hr.departments where location_id = 1500);

select /*+ gather_plan_statistics leading(d,e) use_nl(e) */ e.*
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.location_id = 1500;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.employees
where department_id in (select /*+ no_unnest */ department_id from hr.departments where location_id = 1500);

select /*+ gather_plan_statistics */ *
from hr.departments d
where exists (select 'x' from hr.employees where department_id = d.department_id);

select d.*
from hr.departments d, hr.employees e
where d.department_id = e.department_id;

select /*+ gather_plan_statistics */ d.*
from hr.departments d, (select distinct department_id from hr.employees) e
where d.department_id = e.department_id;

select * from hr.departments;

select department_id, employee_id from hr.employees order by 1;