select * from session_roles;
select * from user_role_privs;
select * from role_sys_privs;
select * from user_sys_privs;
select * from session_privs;
select * from user_tab_privs;
select * from role_tab_privs;

select * from hr.departments;
select * from hr.employees;
select * from hr.locations;

create or replace view emp_view
as
select * from hr.employees;

create or replace view dept_view
as
select * from hr.departments;

select * from emp_view;

select * from dept_view;

select * from user_objects where object_name in ('EMP_VIEW', 'DEPT_VIEW');

select * from user_views where view_name in ('EMP_VIEW', 'DEPT_VIEW');

drop view emp_view;
drop view dept_view;

select * from hr.departments;

create or replace procedure dept_proc(p_id in number)
is
    v_rec hr.departments%rowtype;
begin
    
    select * into v_rec from hr.departments where department_id = p_id;
    dbms_output.put_line(p_id|| ' ' || v_rec.department_name);
exception
    when no_data_found then
        raise_application_error(-20000, '부서는 존재하지 않습니다.');
end dept_proc;
/

show error;

execute dept_proc(30);
execute dept_proc(300);

select * from user_objects where object_name = 'DEPT_PROC';