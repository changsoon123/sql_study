select * from hr.emp where id = 150;

update hr.emp
set sal = sal * 1.1;

delete from hr.emp where id = 200;


update hr.emp
set sal = sal * 1.2;

update hr.emp
set sal = sal * 1.3;

commit;