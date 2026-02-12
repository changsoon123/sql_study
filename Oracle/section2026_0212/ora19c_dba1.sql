select  a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_pred_move_around';

select /*+ gather_plan_statistics */ a.department_id, a.sum_sal, b.avg_sal, b.max_sal
from (select 20 department_id, sum(salary) sum_sal from hr.employees where department_id = 20 group by 20) a,
(select 20 department_id,avg(salary) avg_sal, max(salary) max_sal from hr.employees where department_id = 20 group by 20) b
where a.department_id = b.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics opt_param('_pred_move_around','false') no_push_pred(b)*/ a.department_id, a.sum_sal, b.avg_sal, b.max_sal
from (select department_id, sum(salary) sum_sal from hr.employees where department_id = 20 group by department_id) a,
(select department_id,avg(salary) avg_sal, max(salary) max_sal from hr.employees group by department_id) b
where a.department_id = b.department_id;

select 20 department_id,avg(salary) avg_sal, max(salary) max_sal from hr.employees where department_id = 20 group by 20;

select ix.index_name, ix.uniqueness, ic.column_name, ix.blevel, ix.leaf_blocks, ix.distinct_keys
	from dba_indexes ix, dba_ind_columns ic
	where ix.index_name = ic.index_name
	and ix.table_name = 'EMPLOYEES'
    and ix.owner = 'HR'
    and ix.owner = ic.index_owner;

select /*+ gather_plan_statistics */ * from hr.employees where job_id = 'IT_PROG';
select /*+ gather_plan_statistics */ * from hr.employees where department_id = 20;

select /*+ gather_plan_statistics */ * from hr.employees where job_id = 'IT_PROG' or department_id = 20;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ * from hr.employees where job_id = 'IT_PROG'
union
select * from hr.employees where department_id = 20;

select /*+ gather_plan_statistics */ * from hr.employees where job_id = 'IT_PROG'
union all
select * from hr.employees where department_id = 20;

select /*+ gather_plan_statistics */ * 
from hr.employees 
where job_id = 'IT_PROG'
and (department_id <> 20 or department_id is null);

select /*+ gather_plan_statistics */ * from hr.employees where job_id = 'IT_PROG' and lnnvl(department_id =20)
union all
select * from hr.employees where department_id = 20;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics use_concat */ * from hr.employees where job_id = 'IT_PROG' or department_id = 20;
select /*+ gather_plan_statistics */ * from hr.employees where department_id = 20;

select /*+ gather_plan_statistics */ * from hr.employees where department_id = 50;

select /*+ gather_plan_statistics index(e EMP_DEPARTMENT_IX) */ * from hr.employees e where department_id = 50;

select department_id, count(*) from hr.employees group by department_id order by 2 desc;

select /*+ gather_plan_statistics use_concat */ * from hr.employees where job_id = 'IT_PROG' or department_id = 50;

select /*+ gather_plan_statistics index(e emp_job_ix) */ * from hr.employees e where job_id = 'IT_PROG' and lnnvl(department_id = 50) 
union all
select /*+ full(e) */ * from hr.employees e where department_id = 50;

select employee_id , salary, department_id
from hr.employees
where department_id = 20
order by salary;

SELECT a.employee_id,
       a.salary,
       a.department_id,
       SUM(b.salary) AS ´©ÀûÇÕ
FROM hr.employees a
JOIN hr.employees b
  ON a.department_id = b.department_id
 AND b.salary <= a.salary
WHERE a.department_id = 20
GROUP BY a.employee_id, a.salary, a.department_id
ORDER BY a.salary;

select /*+ gather_plan_statistics */ e1.employee_id, e1.salary ,e1.department_id, sum(e2.salary) total
from hr.employees e1, hr.employees e2
where e1.employee_id >= e2.employee_id
and e1.department_id = e2.department_id
and e1.department_id = 20
group by e1.employee_id,e1.salary, e1.department_id;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ e1.employee_id, e1.salary , sum(e2.salary) total
from hr.employees e1, hr.employees e2
where e1.employee_id >= e2.employee_id
group by e1.employee_id,e1.salary
order by 1;

select /*+ gather_plan_statistics */ employee_id, salary, department_id, avg(salary) over(order by employee_id) total
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, salary,sum(salary) over() total
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, salary,max(salary) over() total
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, salary,min(salary) over() total
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, department_id,salary,sum(salary) over(partition by department_id) total
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, department_id, salary,sum(salary) over(partition by department_id order by employee_id) total
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, salary, rank() over(order by salary desc) rank, dense_rank() over(order by salary desc) dense_rank
from hr.employees;

select /*+ gather_plan_statistics */ employee_id, salary, department_id,
    rank() over(partition by department_id order by salary desc) rank, 
    dense_rank() over(partition by department_id order by salary desc) dense_rank
from hr.employees;

select employee_id, salary
from hr.employees
order by salary desc;

select rownum, employee_id, salary
from (select employee_id,salary
        from hr.employees
        order by salary desc)
where rownum <= 10;

select *
from(select rank() over(order by salary desc) rank, employee_id, salary
    from hr.employees)
where rank <= 10;

select *
from(select dense_rank() over(order by salary desc) rank, employee_id, salary
    from hr.employees)
where rank <= 10;

select *
from(select row_number() over(order by salary desc) no, employee_id, salary
    from hr.employees)
where no <= 10;

select /*+ gather_plan_statistics */ e.employee_id, e.salary, d.department_id, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.salary > (select avg(salary) from hr.employees where department_id = d.department_id);

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ *
from hr.employees e
where e.salary > (select avg(salary) from hr.employees where department_id = e.department_id);

select /*+?gather_plan_statistics?*/ e1.*
from ( select department_id, avg(salary) avg_sal
from hr.employees
group by department_id) e1, hr.employees e2
where e1.department_id = e2.department_id
and e2.salary > e1.avg_sal;

select  a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_remove_aggr_subquery';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics opt_param('_remove_aggr_subquery','false') */ e.employee_id, e.salary, d.department_id, d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
and e.salary > (select avg(salary) from hr.employees where department_id = d.department_id);

select *
from ( select d.department_id, d.department_name, e1.avg_sal
from (select department_id, avg(salary) avg_sal
from hr.employees
group by department_id) e1, hr.departments d
where e1.department_id = d.department_id) e, hr.employees e2
where e.department_id = e2.department_id;

select /*+ gather_plan_statistics */ e2.*, e.*
from ( select d.department_id, d.department_name, e1.avg_sal
from (select department_id, avg(salary) avg_sal
from hr.employees
group by department_id) e1, hr.departments d
where e1.department_id = d.department_id) e, hr.employees e2
where e.department_id = e2.department_id
and e2.salary > e.avg_sal;

select
employee_id,
salary,
department_id,
avg(salary) over(partition by department_id) dept_avg
from hr.employees;

select
employee_id,
salary,
department_id,
avg(salary) over(partition by department_id) dept_avg,
case when salary > avg(salary) over(partition by department_id) then 'x' end case_sal
from hr.employees;

select
e.employee_id,
e.salary,
e.department_id,
avg(e.salary) over(partition by e.department_id) dept_avg,
case when e.salary > avg(e.salary) over(partition by e.department_id) then 'x' end case_sal,
d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id;



select *
from (
select
e.employee_id,
e.salary,
e.department_id,
avg(e.salary) over(partition by e.department_id) dept_avg,
case when e.salary > avg(e.salary) over(partition by e.department_id) then 'x' end case_sal,
d.department_name
from hr.employees e, hr.departments d
where e.department_id = d.department_id
)
where case_sal = 'x';