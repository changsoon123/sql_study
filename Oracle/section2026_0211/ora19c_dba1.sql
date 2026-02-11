select d.*
from hr.departments d, hr.employees e
where d.department_id = e.department_id;

select /*+ gather_plan_statistics */ *
from hr.departments d
where exists (select /*+ unnest nl_sj */ 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where exists (select /*+ unnest merge_sj */ 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where exists (select /*+ unnest hash_sj */ 'x' from hr.employees where department_id = d.department_id);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.departments d
where exists (select /*+ no_unnest */ 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where not exists (select 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where not exists (select /*+ unnest nl_aj */ 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where not exists (select /*+ unnest merge_aj */ 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where not exists (select /*+ unnest hash_aj */ 'x' from hr.employees where department_id = d.department_id);

select /*+ gather_plan_statistics */ *
from hr.departments d
where not exists (select /*+ no_unnest */ 'x' from hr.employees where department_id = d.department_id);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.departments d
where department_id not in (select department_id from hr.employees);

select /*+ gather_plan_statistics */ *
from hr.departments d
where department_id not in (select department_id from hr.employees where department_id is not null);

select /*+ gather_plan_statistics */ *
from hr.departments d
where department_id not in (select /*+ no_unnest */ department_id from hr.employees where department_id is not null);

select /*+ gather_plan_statistics */ e.*, d.*
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and exists ( select 'x'
             from hr.locations
             where location_id = d.location_id
             and city = 'London');
             

select /*+ gather_plan_statistics leading(l,d,e) use_nl(d) use_nl(e) */ e.*, d.*
from hr.employees e, hr.departments d, hr.locations l
where e.department_id = d.department_id
and l.location_id = d.location_id
and l.city = 'London';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ e.*, d.*
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and exists ( select /*+ no_unnest */ 'x'
             from hr.locations
             where location_id = d.location_id
             and city = 'London');
             
select *
from hr.departments d
where exists (select 'x' from hr.locations where location_id = d.location_id and city = 'London');

select /*+ gather_plan_statistics */ e.*, d.*
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and exists ( select /*+ no_unnest push_subq */ 'x'
             from hr.locations
             where location_id = d.location_id
             and city = 'London');

select /*+ gather_plan_statistics */ *
from hr.departments d
where exists (select 'x' from hr.locations where location_id = d.location_id and city = 'London');

select /*+ gather_plan_statistics */ e.*, z.*
from hr.employees e, (select *
    from hr.departments d
    where exists (select 'x' from hr.locations where location_id = d.location_id and city = 'London')) z
where e.department_id = z.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from (select * from hr.employees where manager_id = 145) e,
     (select * from hr.departments where location_id = 2500) d
where e.department_id = d.department_id;

select /*+ gather_plan_statistics */ e.*,d.*
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.manager_id = 145
and d.location_id = 2500;

select /*+ gather_plan_statistics */ *
from (select /*+ no_merge */ * from hr.employees where manager_id = 145) e,
     (select /*+ no_merge */ * from hr.departments where location_id = 2500) d
where e.department_id = d.department_id;

select /*+ gather_plan_statistics */ *
from hr.employees e, (select * from hr.departments where department_id = 20) d
where e.department_id = d.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and d.department_id = 20;

select /*+ gather_plan_statistics */ *
from hr.employees e, hr.departments d
where e.department_id = 20
and d.department_id = 20;

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_complex_view_merging';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ d.department_id, d.department_name, e.avg_sal
from hr.departments d, (select department_id, avg(salary) avg_sal
                        from hr.employees
                        group by department_id) e
where d.department_id = e.department_id;

select /*+ gather_plan_statistics */ d.department_id, d.department_name, avg(e.salary) avg_sal
from hr.departments d, hr.employees e
where d.department_id = e.department_id
group by d.department_id, d.department_name;

select /*+ gather_plan_statistics */ d.department_id, d.department_name, e.avg_sal
from hr.departments d, (select department_id, avg(salary) avg_sal
                        from hr.employees
                        group by department_id) e
where d.department_id = e.department_id
and d.location_id = 1800;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));


select /*+ gather_plan_statistics */ d.department_id, d.department_name, avg(e.salary) avg_sal
from hr.departments d, hr.employees e
where d.department_id = e.department_id
and d.location_id = 1800
group by d.department_id, d.department_name;

select /*+ gather_plan_statistics */ d.department_id, d.department_name, e.avg_sal
from hr.departments d, (select /*+ no_merge */ department_id, avg(salary) avg_sal
                        from hr.employees
                        group by department_id) e
where d.department_id = e.department_id
and d.location_id = 1800;

select /*+ gather_plan_statistics */ avg(salary) from hr.employees where department_id = 20;

select /*+ gather_plan_statistics no_merge */ department_id, avg(salary) avg_sal
                        from hr.employees
                        group by department_id;
                        
select /*+ gather_plan_statistics */ d.department_id, d.department_name, e.avg_sal
from hr.departments d, (select /*+ no_merge */ department_id, avg(salary) avg_sal
                        from hr.employees
                        where 20 = department_id
                        group by department_id) e
where d.location_id = 1800;

select /*+ gather_plan_statistics */ department_id, avg(salary) avg_sal
                        from hr.employees
                        where department_id = 20
                        group by department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ d.department_id, d.department_name, e.avg_sal
from hr.departments d, (select /*+ no_merge no_push_pred */ department_id, avg(salary) avg_sal
                        from hr.employees
                        group by department_id) e
where d.department_id = e.department_id
and d.location_id = 1800;

select *
from hr.departments
where location_id = 1800;

select department_id, avg(salary)
from hr.employees
group by department_id;

select /*+ gather_plan_statistics no_px_join_filter(e) */ d.department_id, d.department_name, e.avg_sal
from hr.departments d, (select /*+ no_merge no_push_pred */ department_id, avg(salary) avg_sal
                        from hr.employees
                        group by department_id) e
where d.department_id = e.department_id
and d.location_id = 1800;

select /*+ gather_plan_statistics */ *
from (select department_id, sum(salary) sum_sal from hr.employees group by department_id)
where department_id = 20;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from (select department_id, sum(salary) sum_sal from hr.employees where department_id = 20 group by department_id);

select /*+ gather_plan_statistics */ *
from (select /*+ no_merge */ department_id, sum(salary) sum_sal from hr.employees group by department_id)
where department_id = 20;

select /*+ gather_plan_statistics */ *
from (select /*+ no_merge */ department_id, sum(salary) sum_sal from hr.employees where department_id = 20 group by department_id);

select /*+ gather_plan_statistics */ *
from (select /*+ no_merge */ department_id, sum(salary) sum_sal from hr.employees group by department_id);

select /*+ gather_plan_statistics */ a.department_id, a.sum_sal, b.avg_sal, b.max_sal
from (select department_id, sum(salary) sum_sal from hr.employees where department_id = 20 group by department_id) a,
     (select department_id,avg(salary) avg_sal, max(salary) max_sal from hr.employees group by department_id) b
where a.department_id = b.department_id;

select /*+ gather_plan_statistics */ department_id ,sum(salary) sum_sal, avg(salary) avg_sal ,max(salary) max_sal
from hr.employees
where department_id = 20
group by department_id;

select /*+ gather_plan_statistics */ a.department_id, a.sum_sal, b.avg_sal, b.max_sal
from (select department_id, sum(salary) sum_sal from hr.employees where department_id = 20 group by department_id) a,
     (select department_id,avg(salary) avg_sal, max(salary) max_sal from hr.employees  where department_id = 20 group by department_id) b
where a.department_id = b.department_id;