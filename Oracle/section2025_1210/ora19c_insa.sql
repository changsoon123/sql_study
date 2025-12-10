select * from user_sys_privs;
select * from session_roles;
select * from role_sys_privs;
select * from role_tab_privs;

select * from tab;

create table dept(id number, name varchar2(30));

drop table dept purge;

select * from tab;

select * from user_tab_privs;

select * from hr.emp;

select * from hr.emp;

insert into hr.emp(id, name, sal) values(300,'oracle',1000);

update hr.emp set sal = sal * 1.1 where id = 200;

delete from hr.emp where id = 300;

commit;

select * from user_sys_privs;

select * from hr.employees;
select * from hr.departments;

create table test(id number);

create table test2(id number);

select * from hr.emp;

select * from hr.emp where id = 100;

update hr.emp set sal = 1000 where id = 100;

delete from hr.emp where id = 110;

commit;

select * from hr.emp where id = :b_id;