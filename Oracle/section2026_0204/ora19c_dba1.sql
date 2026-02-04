
select s.prev_sql_id, s.prev_child_number, v.sql_text
from v$session s, v$sql v
where s.prev_sql_id = v.sql_id
and s.prev_child_number = v.child_number
and s.username = 'HR';

select * from table(dbms_xplan.display_cursor('82mnzcywm53rs',0,'typical'));
select * from v$sql_plan where sql_id = '82mnzcywm53rs';

select * from hr.employees where employee_id = 101;

select * from table(dbms_xplan.display_cursor('82mnzcywm53rs',0,'all'));
select * from table(dbms_xplan.display_cursor('82mnzcywm53rs',0,'advanced'));
select * from table(dbms_xplan.display_cursor('82mnzcywm53rs',0,'outline'));

select * from hr.employees where employee_id = 110;
select * from table(dbms_xplan.display_cursor);

grant select on v_$session to hr;
grant select on v_$sql to hr;
grant select on v_$sql_plan to hr;
grant select on v_$sql_plan_statistics to hr;
grant select on v_$sql_plan_statistics_all to hr;

select * from dba_tab_privs where grantee = 'HR';

select * from table(dbms_xplan.display_cursor(null,null,'all'));
select * from table(dbms_xplan.display_cursor(null,null,'advanced'));
select * from table(dbms_xplan.display_cursor(null,null,'outline'));
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ * from hr.employees where employee_id = 110;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select * from dba_indexes where table_name = 'EMPLOYEES';

select * from hr.employees where department_id = 50;
select * from hr.employees where employee_id = 110;

select * from dba_segments where segment_name = 'EMP_EMP_ID_PK';
select * from dba_extents where segment_name = 'EMP_EMP_ID_PK';

select
        employee_id,
        department_id,
        rowid extended_format,
        dbms_rowid.rowid_object(rowid) as data_object_id,
        dbms_rowid.rowid_relative_fno(rowid) as file_no,
        dbms_rowid.rowid_block_number(rowid) as block_no,
        dbms_rowid.rowid_row_number(rowid) as row_slot_no
from hr.employees
where department_id = 50
order by 2;

select * from hr.employees;