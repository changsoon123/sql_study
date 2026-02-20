drop table hr.p1 purge;
drop table hr.p2 purge;
drop table hr.p3 purge;

drop procedure hr.p1;

create table hr.p1 tablespace users as select * from hr.employees where 1=2;
create table hr.p2 tablespace users as select * from hr.employees where 1=2;
create table hr.p3 tablespace users as select * from hr.employees where 1=2;

alter table hr.p1 add constraint p1_sal_ck check(salary < 5000);
alter table hr.p2 add constraint p2_sal_ck check(salary between 5000 and 9999);
alter table hr.p3 add constraint p3_sal_ck check(salary between 10000 and 25000);

insert into hr.p1 select * from hr.employees where salary < 5000;
insert into hr.p2 select * from hr.employees where salary between 5000 and 9999;
insert into hr.p3 select * from hr.employees where salary between 10000 and 25000;

commit;

exec dbms_stats.gather_table_stats('hr','p1')
exec dbms_stats.gather_table_stats('hr','p2')
exec dbms_stats.gather_table_stats('hr','p3')

create or replace view hr.emp_partition
as
select * from hr.p1
union all
select * from hr.p2
union all
select * from hr.p3;

select * from hr.emp_partition;

select /*+ gather_plan_statistics */ * from hr.emp_partition where salary = 24000;

select /*+ gather_plan_statistics */ * from hr.emp_partition where salary = 3000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics */ * from hr.emp_partition where salary = 6000;

select /*+ gather_plan_statistics */ * from hr.emp_partition where salary = :b_sal;

select /*+ gather_plan_statistics */ * from hr.emp_partition where salary = 6000 and employee_id = 104;

create unique index hr.p2_idx on hr.p2(employee_id) tablespace users;
alter table hr.p2 add constraint p2_id_pk primary key(employee_id) using index hr.p2_idx;

drop view hr.emp_partition;

create table hr.emp_year
partition by range(hire_date)
( partition p2004 values less than(to_date('2005-01-01','yyyy-mm-dd')),
partition p2005 values less than(to_date('2006-01-01','yyyy-mm-dd')),
partition p2006 values less than(to_date('2007-01-01','yyyy-mm-dd')),
partition pmax values less than(maxvalue)
)
tablespace users
as
select employee_id, last_name, salary, hire_date, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_YEAR'
and table_owner = 'HR';

select partitioning_type, partition_count from dba_part_tables where table_name = 'EMP_YEAR' and owner = 'HR';

select * from dba_part_key_columns where name = 'EMP_YEAR' and owner = 'HR';

select * from hr.emp_year;
select * from hr.emp_year partition(p2004);
select * from hr.emp_year partition(p2005);
select * from hr.emp_year partition(p2006);
select * from hr.emp_year partition(pmax);

select sysdate + to_yminterval('1-10') from dual;

select sysdate + numtoyminterval(1,'year') + numtoyminterval(10,'month') from dual;

select localtimestamp + to_dsinterval('10 10:10:10') from dual;

select localtimestamp + numtodsinterval(10,'day') + numtodsinterval(10,'hour') + numtodsinterval(10,'minute')
+ numtodsinterval(10,'minute') + numtodsinterval(10,'second') from dual;

drop table hr.emp_year purge;

create table hr.emp_year
partition by range(hire_date) interval(numtoyminterval(1,'year'))
( partition p2004 values less than(to_date('2005-01-01','yyyy-mm-dd')),
partition p2005 values less than(to_date('2006-01-01','yyyy-mm-dd')),
partition p2006 values less than(to_date('2007-01-01','yyyy-mm-dd'))
)
tablespace users
as
select employee_id, last_name, salary, hire_date, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_YEAR'
and table_owner = 'HR';

select partitioning_type, partition_count from dba_part_tables where table_name = 'EMP_YEAR' and owner = 'HR';

select * from dba_part_key_columns where name = 'EMP_YEAR' and owner = 'HR';

select * from hr.emp_year;
select * from hr.emp_year partition(p2004);
select * from hr.emp_year partition(p2005);
select * from hr.emp_year partition(SYS_P881);
select * from hr.emp_year partition(SYS_P882);

SELECT * FROM dba_segments where segment_name = 'EMP_YEAR';
SELECT * FROM dba_extents where segment_name = 'EMP_YEAR';

drop table hr.emp_year purge;

create table hr.emp_year
partition by range(hire_date)
( partition p2004 values less than(to_date('2005-01-01','yyyy-mm-dd')) tablespace sysaux,
partition p2005 values less than(to_date('2006-01-01','yyyy-mm-dd')) tablespace users,
partition p2006 values less than(to_date('2007-01-01','yyyy-mm-dd')) tablespace sysaux,
partition pmax values less than(maxvalue) tablespace users
)
tablespace users
as
select employee_id, last_name, salary, hire_date, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_YEAR'
and table_owner = 'HR';

SELECT * FROM dba_segments where segment_name = 'EMP_YEAR';
SELECT * FROM dba_extents where segment_name = 'EMP_YEAR';

create table hr.emp_hash
partition by hash(employee_id) partitions 4
tablespace users
as select employee_id, last_name, salary, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_HASH'
and table_owner = 'HR';

select partitioning_type, partition_count from dba_part_tables where table_name = 'EMP_HASH' and owner = 'HR';

select * from dba_part_key_columns where name = 'EMP_HASH' and owner = 'HR';

select * from hr.emp_hash;
select * from hr.emp_hash partition(SYS_P901);
select * from hr.emp_hash partition(SYS_P902);
select * from hr.emp_hash partition(SYS_P903);
select * from hr.emp_hash partition(SYS_P904);

create table hr.emp_list
partition by list(department_id)
(partition p_dept_1 values(10,20,30,40),
partition p_dept_2 values(50),
partition p_dept_3 values(60,70,80,90,100,110),
partition p_dept_4 values(default)
)
tablespace users
as select employee_id, last_name, salary, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_LIST'
and table_owner = 'HR';

select partitioning_type, partition_count from dba_part_tables where table_name = 'EMP_LIST' and owner = 'HR';

select * from dba_part_key_columns where name = 'EMP_LIST' and owner = 'HR';

select * from hr.emp_list;
select * from hr.emp_list partition(p_dept_1);
select * from hr.emp_list partition(p_dept_2);
select * from hr.emp_list partition(p_dept_3);
select * from hr.emp_list partition(p_dept_4);

create table hr.emp_comp
partition by range(salary)
subpartition by hash(employee_id) subpartitions 4
(partition p4999 values less than(5000),
partition p9999 values less than(10000),
partition p19999 values less than(20000),
partition pmax values less than(maxvalue)
)
tablespace users
as select employee_id, last_name, salary, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_COMP'
and table_owner = 'HR';

select partitioning_type, partition_count,subpartitioning_type,def_subpartition_count 
from dba_part_tables where table_name = 'EMP_COMP' and owner = 'HR';

select * from dba_part_key_columns where name = 'EMP_COMP' and owner = 'HR';

select * from dba_subpart_key_columns where name = 'EMP_COMP' and owner = 'HR';

select /*+ gather_plan_statistics */ * from hr.emp_comp where salary < 5000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last +partition'));

select /*+ gather_plan_statistics */ * from hr.emp_comp where salary < 5000 and employee_id = 185;

select /*+ gather_plan_statistics */ * from hr.emp_comp where salary < 5000 and employee_id = 129;

select *
from dba_tab_subpartitions
where table_name = 'EMP_COMP' 
and table_owner = 'HR';


select * from table(dbms_xplan.display_cursor(null,null,'allstats last +partition'));
select /*+ gather_plan_statistics */ * from hr.emp_comp where employee_id = 129;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last +partition'));
select /*+ gather_plan_statistics */ * from hr.emp_comp where salary > 20000;

drop table hr.emp_year purge;

create table hr.emp_year
partition by range(hire_date)
subpartition by list(department_id)
subpartition template
(subpartition s_dept_1 values(10,20,30,40),
subpartition s_dept_2 values(50),
subpartition s_dept_3 values(60,70,80,90,100,110),
subpartition s_dept_4 values(default))
(partition p2004 values less than(to_date('2005-01-01','yyyy-mm-dd')),
partition p2005 values less than(to_date('2006-01-01','yyyy-mm-dd')),
partition p2006 values less than(to_date('2007-01-01','yyyy-mm-dd')),
partition pmax values less than(maxvalue))
nologging
tablespace users 
as select employee_id, last_name, salary,hire_date, department_id from hr.employees;


select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'EMP_YEAR'
and table_owner = 'HR';

alter table hr.emp_year logging;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_subpartitions
where table_name = 'EMP_YEAR'
and table_owner = 'HR';

select /*+ gather_plan_statistics */ *
from hr.emp_year
where hire_date between to_date('2002-01-01','yyyy-mm-dd') and to_date('2002-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss');
select * from table(dbms_xplan.display_cursor(null,null,'allstats last +partition'));

select /*+ gather_plan_statistics */ *
from hr.emp_year
where hire_date between to_date('2002-01-01','yyyy-mm-dd') and to_date('2002-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss')
and department_id = 30;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last +partition'));

create table hr.sal_emp
partition by range(salary)(
partition p1 values less than(5000),   
partition p2 values less than(15000),  
partition p3 values less than(25000))
tablespace users  
as select employee_id, last_name, salary, department_id from hr.employees;

select partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR';

select partitioning_type, partition_count from dba_part_tables where table_name = 'SAL_EMP' and owner = 'HR';

select * from dba_part_key_columns where name = 'SAL_EMP' and owner = 'HR';

select partition_position, partition_name, high_value, tablespace_name, logging
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR';

alter table hr.sal_emp split partition p3 at(20000) into (partition p3,partition p4);

select * from hr.sal_emp partition(p3);

select * from hr.sal_emp partition(p4);

alter table hr.sal_emp add partition p5_1 values less than(30000);

alter table hr.sal_emp rename partition p5_1 to p5;

alter table hr.sal_emp drop partition p5;

select * from hr.sal_emp partition(p3);

alter table hr.sal_emp truncate partition p3;

select * from hr.sal_emp partition(p3);

insert into hr.sal_emp
select employee_id, last_name, salary, department_id
from hr.employees
where employee_id in (101,102);

select * from hr.sal_emp partition(p3);

update hr.sal_emp set salary = 18000 where employee_id = 101;

update hr.sal_emp set salary = 21000 where employee_id = 101;

select * from hr.sal_emp partition(p3);

alter table hr.sal_emp enable row movement;

update hr.sal_emp set salary = 21000 where employee_id = 101;

commit;

alter table hr.sal_emp disable row movement;

select * from hr.sal_emp partition(p3);

select * from hr.sal_emp partition(p4);

select partition_position, partition_name, high_value, tablespace_name, logging
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR'; 

alter table hr.sal_emp add partition pmax values less than(maxvalue);

insert into hr.sal_emp values(300, 'oracle', 29000, 20);
insert into hr.sal_emp values(300, 'oracle', 29000, 20);
commit;

select * from hr.sal_emp partition (pmax);

alter table hr.sal_emp split partition pmax at (30000) into (partition p5, partition pmax);

select partition_position, partition_name, high_value, tablespace_name, logging
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR'; 

select * from hr.sal_emp partition (p5);

select * from hr.sal_emp partition (pmax);

select * from hr.sal_emp partition (p4);

alter table hr.sal_emp merge partition p4,p5 into partition p5;

alter table hr.sal_emp merge partitions p4,p5 into partition p5;

create table hr.exch_emp
tablespace users
as
select employee_id, last_name, salary, department_id
from hr.employees
where 1 = 2;

insert into hr.exch_emp values(500,'sql',25000,30);

insert into hr.exch_emp values(501,'plsql',26000,10);

commit;

select * from hr.exch_emp;

select * from hr.sal_emp partition (p5);

alter table hr.sal_emp exchange partition p5 with table hr.exch_emp;

select * from hr.sal_emp partition (p5);

select * from hr.exch_emp;

alter table hr.sal_emp exchange partition p5 with table hr.exch_emp;

select * from hr.sal_emp partition (p5);

select * from hr.exch_emp;

select partition_position, partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR'; 

alter table hr.sal_emp rename partition p5 to p4;

select num_rows,blocks, avg_row_len
from dba_tables
where table_name = 'SAL_EMP'
and owner = 'HR'; 

select * from dba_segments where segment_name = 'SAL_EMP';
select * from dba_extents where segment_name = 'SAL_EMP';

select * from dba_segments where segment_name = 'EMPLOYEES';
select * from dba_extents where segment_name = 'EMPLOYEES';

select * from dba_segments where segment_name = 'EXCH_EMP';
select * from dba_extents where segment_name = 'EXCH_EMP';

exec dbms_stats.gather_table_stats('hr','sal_emp',granularity=>'auto');

select num_rows,blocks, avg_row_len
from dba_tables
where table_name = 'SAL_EMP'
and owner = 'HR'; 

select partition_position, partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR'; 

select * from hr.sal_emp partition (p4);

select * from hr.exch_emp;

truncate table hr.exch_emp;

insert into hr.exch_emp select * from hr.sal_emp partition (p4);

commit;

select * from hr.exch_emp;

alter table hr.sal_emp truncate partition p4;

select * from hr.sal_emp partition (p4);

exec dbms_stats.gather_table_stats('hr','sal_emp',granularity=>'auto');

select partition_position, partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR'; 

insert into hr.sal_emp partition (p4) select * from hr.exch_emp;

alter table hr.sal_emp enable row movement;

alter table hr.sal_emp modify partition p4 shrink space cascade;

alter table hr.sal_emp disable row movement;

alter table hr.sal_emp move partition p3;

exec dbms_stats.gather_table_stats('hr','sal_emp',granularity=>'auto');

select partition_position, partition_name, high_value, tablespace_name, num_rows, blocks, avg_row_len
from dba_tab_partitions
where table_name = 'SAL_EMP'
and table_owner = 'HR';

select * from dba_directories;

exec dbms_stats.gather_table_stats('hr','emp_local',granularity=>'auto');

create unique index hr.emp_local_idx on hr.emp_local(employee_id) local;

select i.index_name, i.uniqueness, p.locality, p.alignment, i.partitioned, p.partition_count
from dba_indexes i, dba_part_indexes p
where i.owner = 'HR'
and i.table_name = 'EMP_LOCAL'
and p.table_name = i.table_name
and p.index_name = i.index_name;

select partition_position, partition_name, high_value, blevel, leaf_blocks 
from dba_ind_partitions 
where index_owner = 'HR' and index_name='EMP_LOCAL_IDX'