SHOW USER

select * from session_roles;
select * from user_role_privs;
select * from user_sys_privs;
select * from user_tab_privs;

select * from role_sys_privs;

select * from hr.locations;
select * from hr.employees;
select * from hr.departments;

select * from dba_sys_privs where privilege like '%ANY%';

select * from user_role_privs;

select * from hr.employees;

CREATE or replace function today
return varchar2
is
     
begin
    return to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss');
end today;
/

select today from dual;

select * from tab;

select * from user_tab_privs;
select * from emp;

desc hr.insert_emp1;

execute hr.insert_emp1(2,'oracle',3000);

select * from emp;

select * from hr.emp;

select * from user_tab_privs;
execute hr.insert_emp2(3,'SQL',5000);
select * from emp;
select * from hr.emp;
select * from user_ts_quotas;