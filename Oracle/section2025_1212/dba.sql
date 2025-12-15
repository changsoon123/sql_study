select * from dba_users;

drop user insa cascade;

select name from v$database;

select * from hr.departments;

select * from dba_db_links;

create public database link ora19c_insa
connect to insa identified by oracle
using 'ora19c';

select * from dba_db_links;

select e.employee_id, e.department_id, d.department_name
from insa.emp@ora19c_insa e, hr.departments d
where e.department_id = d.department_id;

drop public database link ora19c_insa;

select * from dba_db_links;

select * from insa.emp@ora19c_insa;

select * from dba_sys_privs where grantee = 'HR';