select sal,comm from hr.emp where dept_id = 80;

select * from fga_emp_log;

select  sys_context('userenv','session_user')
from dual;

truncate table fga_emp_log;