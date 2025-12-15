create table insa.emp
as select * from hr.employees;

create database link xe_dept
connect to sys identified by oracle
using 'XE';

show user;

select * from dba_sys_privs where grantee = 'INSA';

grant create database link to insa;