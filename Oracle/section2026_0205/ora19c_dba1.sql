drop table hr.emp purge;

create table hr.emp tablespace users as select * from hr.employees;

select * from hr.employees;

select * from hr.emp where department_id = 80 and salary = 10000;
select * from hr.emp where department_id = 80;
select * from hr.emp where salary = 10000;

drop index hr.emp_sal_idx;
drop index hr.emp_dept_idx;

create index hr.emp_sal_idx on hr.emp(salary) tablespace users;

create index hr.emp_dept_idx on hr.emp(department_id);

select ix.index_name, ix.uniqueness, ic.column_name, ix.blevel, ix.leaf_blocks, ix.distinct_keys
                from dba_indexes ix, dba_ind_columns ic
                where ix.index_name = ic.index_name
                and ix.table_name = 'EMP'
                and ix.owner = 'HR'
		and ix.owner = ic.index_owner;


select /*+ gather_plan_statistics */ * from hr.emp where department_id = 80 and salary = 10000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

ALTER SYSTEM FLUSH BUFFER_CACHE;
ALTER SYSTEM FLUSH SHARED_POOL;

select /*+ gather_plan_statistics index(e emp_dept_idx) */ * 
from hr.emp e 
where department_id = 80 and salary = 10000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics and_equal(e emp_dept_idx emp_sal_idx) */ * 
from hr.emp e 
where department_id = 80 and salary = 10000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select /*+ gather_plan_statistics index_combine(e emp_dept_idx emp_sal_idx) */ * 
from hr.emp e 
where department_id = 80 and salary = 10000;

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

select 
	employee_id, 
	rowid extended_format,
	dbms_rowid.rowid_object(rowid) as data_object_id,
	dbms_rowid.rowid_relative_fno(rowid) as file_no,
	dbms_rowid.rowid_block_number(rowid) as block_no,
	dbms_rowid.rowid_row_number(rowid) as row_slot_no,
	dbms_rowid.rowid_to_restricted(rowid,0) retricted_format
from hr.emp
where department_id = 80;