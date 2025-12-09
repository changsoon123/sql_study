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

