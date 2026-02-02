drop table hr.emp purge;

create table hr.emp tablespace users as select * from hr.employees;

declare
    type numlist is table of number;
    v_num numlist := numlist(100,101,200);
begin
    for i in v_num.first..v_num.last loop
        update hr.emp
        set salary = salary * 1.1
        where employee_id = v_num(i);
        commit;
    end loop;        
end;
/

select sid, event, total_waits, time_waited
from v$session_event
where sid in (select sid from v$session where username = 'HR');

select n.name, sum(s.value)
from v$sesstat s, v$statname n
where n.name in ('redo synch writes','user commits','user rollbacks')
and s.statistic# = n.statistic#
and s.sid = (select sid from v$session where username = 'HR')
group by n.name;

update hr.emp
set salary = salary * 1.1
where employee_id = 100;

show parameter db_block_size;

show parameter db_file_multiblock_read_count;

set autot traceonly exp;

select 
	employee_id, 
	rowid extended_format,
	dbms_rowid.rowid_object(rowid) as data_object_id,
	dbms_rowid.rowid_relative_fno(rowid) as file_no,
	dbms_rowid.rowid_block_number(rowid) as block_no,
	dbms_rowid.rowid_row_number(rowid) as row_slot_no,
	dbms_rowid.rowid_to_restricted(rowid,0) retricted_format
from hr.emp
where employee_id = 100;

select ix.index_name, ix.uniqueness, ic.column_name
	from user_indexes ix, user_ind_columns ic
	where ix.index_name = ic.index_name
	and ix.table_name = 'EMP';
    
    
select employee_id, rowid from hr.emp order by 1;

create index hr.emp_dept_idx on hr.emp(department_id);

select ix.index_name, ix.uniqueness, ic.column_name
	from user_indexes ix, user_ind_columns ic
	where ix.index_name = ic.index_name
	and ix.table_name = 'EMP';

drop index hr.emp_idx;

col CONSTRAINT_NAME format a30


select c.column_name, u.constraint_name, u.constraint_type,u.search_condition,u.index_name
from user_constraints u, user_cons_columns c
where u.constraint_name = c.constraint_name
and u.table_name = 'EMP';

select * from hr.emp where employee_id = 100
union
select * from hr.emp where employee_id = 101;

select * from hr.emp where employee_id = 100
union all
select * from hr.emp where employee_id = 101;