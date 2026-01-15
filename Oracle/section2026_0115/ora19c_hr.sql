create table exceptions(row_id urowid,
                        owner varchar2(128),
                        table_name varchar2(128),
                        constraint varchar2(128));
                        
                        
create table hr.test(id,number constraint test_id_pk primary key,
name varchar2(30),
phone varchar2(20))
tablespace users;

drop table hr.test purge;

create table hr.test(
    id number constraint test_id_pk primary key,
    name varchar2(30),
    phone varchar2(20)
) tablespace users;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

select * from hr.test;

select * from dba_constraints where owner='HR' and table_name='TEST';
select index_name, uniqueness, status from dba_indexes where owner='HR' and table_name='TEST';