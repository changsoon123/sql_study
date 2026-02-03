select * from hr.emp where last_name = 'King' and first_name = 'Steven';

select ix.index_name, ix.uniqueness, ic.column_name
	from user_indexes ix, user_ind_columns ic
	where ix.index_name = ic.index_name
	and ix.table_name = 'EMP';
    
...
AAASXIAAHAAAAJLAAA
AAASXIAAHAAAAJLAAB
AAASXIAAHAAAAJLAAC
AAASXIAAHAAAAJLAAD
AAASXIAAHAAAAJLAAE
AAASXIAAHAAAAJLAAF
AAASXIAAHAAAAJLAAG
AAASXIAAHAAAAJLAAH
AAASXIAAHAAAAJLAAI
AAASXIAAHAAAAJLAAJ
AAASXIAAHAAAAJLAAK;
..
select * from hr.emp where last_name = 'King';

select * from hr.emp where rowid = 'AAASXIAAHAAAAJLAAA';

select * from hr.emp where rowid = 'AAASXIAAHAAAAJLAAD';

select * from hr.emp where last_name = 'King' and first_name = 'Steven';

select ix.index_name, ix.uniqueness, ic.column_name
	from user_indexes ix, user_ind_columns ic
	where ix.index_name = ic.index_name
	and ix.table_name = 'EMP';
    
select * from hr.emp where last_name = 'King';
select * from hr.emp where first_name = 'Steven';

select /*+ and_equal(e emp_lname_idx emp_fname_idx) */ * from hr.emp where last_name = 'King' and first_name = 'Steven';
select /*+ and_equal(e emp_lname_idx emp_fname_idx) */ * from hr.emp e where last_name = 'King' and first_name = 'Steven';

select first_name, rowid from hr.emp order by 1;
select last_name, rowid from hr.emp order by 1;

select id3.rowid
from( select e.rowid, e.* from hr.emp e where last_name = 'King') id3,
    (select e.rowid, e.* from hr.emp e where first_name = 'Steven') id4
where id3.rowid = id4.rowid;

select *
from hr.emp
where rowid in (
    select id3.rowid
    from( select e.rowid, e.* from hr.emp e where last_name = 'King') id3,
        (select e.rowid, e.* from hr.emp e where first_name = 'Steven') id4
    where id3.rowid = id4.rowid
);


select * from hr.emp where last_name = 'King' and first_name = 'Steven';

select last_name,first_name, rowid from hr.emp order by 1,2;

select * from hr.emp where last_name = 'King';

select * from hr.emp where first_name = 'Steven';

select ix.index_name, ix.uniqueness, ic.column_name, ic.column_position, ic.descend
	from user_indexes ix, user_ind_columns ic
	where ix.index_name = ic.index_name
	and ix.table_name = 'EMP';
    
select /*+ index_desc(e emp_idx) */ employee_id from hr.emp e where rownum <= 1;
select max(employee_id) from hr.emp;

select max(min_id) min_id, max(max_id) max_id
from (select min(employee_id) min_id, null max_id from hr.emp
        union all
        select null, max(employee_id) from hr.emp);

create table hr.insa
tablespace users
as
select employee_id id, last_name name, salary sal, hire_date hire, to_char(department_id) dept_id
from hr.employees;

create index insa_name_idx on hr.insa(name) tablespace users;
create index insa_sal_idx on hr.insa(sal) tablespace users;
create index insa_hire_idx on hr.insa(hire) tablespace users;
create index insa_dept_idx on hr.insa(dept_id) tablespace users;

select * from hr.insa where sal = 90000 / 12;

select * from hr.insa where to_char(hire,'yyyymmdd') = '20070207';

select * from nls_session_parameters;

select * from hr.insa where hire = to_date('07-FEB-2007');

select * from hr.insa 
where hire >= to_date('2007-02-07','yyyy-mm-dd')
and hire < to_date('2007-02-08','yyyy-mm-dd');

select * from hr.insa where dept_id = '20';
select * from hr.employees where department_id = '20';

select * from all_synonyms where synonym_name = 'PLAN_TABLE';

explain plan for select * from hr.employees where employee_id = 100;
select * from table(dbms_xplan.display(null,null, 'outline'));
select * from table(dbms_xplan.display(null,null,'advanced'));
select * from table(dbms_xplan.display('plan_table','demo1', 'typical'));
select * from table(dbms_xplan.display('plan_table','demo1', 'all'));
select * from table(dbms_xplan.display('plan_table','demo1', 'outline'));
select * from table(dbms_xplan.display('plan_table','demo1', 'advanced'));