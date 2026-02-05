select /*+ gather_plan_statistics */ * from hr.emp where department_id = 80 and salary = 10000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
