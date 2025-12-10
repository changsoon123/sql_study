select * from tab;

create table hr.new_emp as select * from hr.employees;

alter table hr.new_emp modify last_name varchar2(50);

select * from hr.new_emp;

truncate table hr.new_emp;

drop table hr.new_emp;