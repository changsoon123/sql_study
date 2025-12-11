select * from user_tab_privs;

select sal,comm from hr.emp where dept_id = 80;

select sal,comm from hr.emp where dept_id = 80;

select sal,comm from hr.emp where dept_id = 80;


select * from hr.emp where dept_id = :b_dept_id;
select * from hr.emp where id = :b_id;

insert into hr.emp(id,name,sal,comm,dept_id) values(300,'zoey',1000,0.1,80);
insert into hr.emp(id,name,sal,comm,dept_id) values(400,'lucy',1000,0.1,20);
commit;

insert into hr.emp(id,name,sal,comm,dept_id) values(:b_id,:b_name,:b_sal,:b_comm,:b_dept_id);
commit;

desc hr.emp;

insert into hr.emp(id,name,sal,dept_id) values(:b_id,:b_name,:b_sal,:b_dept_id);
commit;

update hr.emp
set sal = sal * 1.1
where id = 145;

rollback;

delete from hr.emp where id = 145;