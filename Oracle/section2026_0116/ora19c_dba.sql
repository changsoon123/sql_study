drop table hr.test purge;

create table hr.test(
    id number constraint test_id_pk primary key,
    name varchar2(30) not null,
    phone varchar2(15) constraint test_phone_unique unique,
    sal number constraint test_sal_ck check(sal > 1000),
    mgr number constraint test_mgr_fk references hr.test(id)
) tablespace users;

select * from dba_constraints where owner = 'HR' and table_name = 'TEST';
select index_name, uniqueness, status from dba_indexes where owner = 'HR' and table_name = 'TEST';

select * from hr.test;

truncate table hr.test;

drop table hr.emp purge;

create table hr.emp tablespace users as select employee_id,last_name,salary,hire_date,department_id 
from hr.employees 
where 1=2;

create directory emp_dir as '/home/oracle/data';

select * from dba_directories where directory_name = 'EMP_DIR';

grant read, write on directory emp_dir to hr;

select * from dba_tab_privs where grantee = 'HR';

drop table hr.emp purge;

create table hr.emp(
    id number(4),
    name varchar2(30),
    sal number,
    hire date,
    dept_id number(4)
    )organization external(
    type oracle_loader
    default directory emp_dir
    access parameters
    (
        records delimited by newline
        badfile 'emp.bad'
        logfile 'emp.log'
        fields terminated by ','
        missing field values are null
        (id,name,sal,hire char date_format date mask "yyyy-mm-dd",dept_id)
    )
        location('emp.dat','emp_new.dat')
    )
/
    
select * from hr.emp;
select * from dba_objects where object_name = 'EMP' and owner = 'HR';
select * from dba_tables where table_name = 'EMP' and owner = 'HR';

select * from dba_external_tables;
select * from dba_external_locations;

create table hr.insa tablespace users as select * from hr.emp;

select * from hr.insa;
truncate table hr.insa;
insert into hr.insa select * from hr.emp;
commit;
select * from hr.insa;

select employee_id, last_name, salary, to_char(hire_date, 'yyyy-mm-dd'), department_id
from hr.employees;

create table hr.emp_ext
(id, name, sal, hire, deptno)
organization external
(
    type oracle_datapump
    default directory emp_dir
    location('emp.dump')
)as
select employee_id, last_name, salary, to_char(hire_date, 'yyyy-mm-dd'), department_id
from hr.employees;

select * from hr.emp_ext;

select * from dba_external_tables;
select * from dba_external_locations;

create table hr.emp2026
as select * from hr.emp_ext;

select * from hr.emp2026;
truncate table hr.emp2026;
insert into hr.emp2026 select * from hr.emp_ext;
commit;

drop table hr.reorg_test purge;

create table hr.reorg_test(id number, name varchar2(100)) tablespace users;

begin
    for i in 1..10000 loop
        insert into hr.reorg_test(id,name) values(i,'table/index reorganization example');
    end loop;
        commit;
end;
/

select count(*) from hr.reorg_test;

select extents, blocks, bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';

select extents, blocks, bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';

ALTER TABLE hr.reorg_test add constraint reorg_id_pk primary key(id);

select * from dba_constraints where table_name = 'REORG_TEST';
select * from dba_indexes where table_name = 'REORG_TEST';
select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

exec dbms_stats.gather_table_stats('hr','reorg_test');

select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

select * from HR.reorg_test where id = 100;

delete from hr.reorg_test where id > 100;
commit;

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:miss') from dba_tables where table_name = 'REORG_TEST';

select to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') from dba_tables where table_name = 'REORG_TEST';

select extents, blocks, bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';

select count(*) from hr.reorg_test;

select 100*39/8192 from dual;

select * from dba_directories;

truncate table hr.reorg_test;

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:miss') from dba_tables where table_name = 'REORG_TEST';
select extents, blocks, bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';
select extents, blocks, bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';
exec dbms_stats.gather_table_stats('hr','reorg_test');

show parameter memory_target;
show parameter sga_target;
show parameter shared_pool_size;

alter system set shared_pool_size = 200M scope=both;

alter system flush shared_pool;