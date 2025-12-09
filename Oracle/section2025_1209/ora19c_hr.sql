select * from tab;

select * from emp;

create or replace procedure insert_emp1
(p_id in number,
p_name in varchar2,
p_sal in number)
is
begin
    insert into emp(id,name,sal) values(p_id, p_name, p_sal);
    commit;
end insert_emp1;
/

select * from user_objects where object_name = 'INSERT_EMP1';
select * from user_source where name = 'INSERT_EMP1';

select * from emp;

execute insert_emp1(1,'james',1000);

grant execute on insert_emp1 to insa;

select * from user_tab_privs;

select * from emp;

create or replace procedure insert_emp2
(p_id in number,
p_name in varchar2,
p_sal in number)
authid current_user
is
begin
    insert into emp(id,name,sal) values(p_id, p_name, p_sal);
    commit;
end insert_emp2;
/

select * from user_objects where object_name = 'INSERT_EMP2';
select * from user_source where name = 'INSERT_EMP2';

select * from emp;

grant execute on hr.insert_emp2 to insa;
select * from user_tab_privs;

select count(*) from sys.obj$;

exec sys.priv_mgr;

select * from session_roles;
select count(*) from sys.obj$;