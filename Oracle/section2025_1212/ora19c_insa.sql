select * from tab;

drop table insa_new purge;
drop table emp purge;
drop table dept purge;

drop table test purge;
drop table test2 purge;

drop table new purge;

purge recyclebin;

select * from tab;

select * from emp;

create database link xe_hr
connect to hr identified by hr
using 'xe';

select * from user_sys_privs;

select * from user_db_links;

select * from hr.employees@xe_hr;
select * from hr.locations@xe_hr;

select * from emp;

truncate table emp;

insert into insa.emp select * from hr.employees@xe_hr;
commit;

select * from insa.emp;

create table insa.loc
as
select * from hr.locations@xe_hr;

select * from insa.loc;