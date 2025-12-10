select * from user_tab_privs;

select * from hr.emp;

insert into hr.emp(id, name, sal) values(300,'sql',3000);

update hr.emp set sal = sal * 1.1 where id = 100;

delete from hr.emp where id = 200;

commit;