select * from user_tab_privs;

desc hr.update_proc;

exec hr.update_proc(200);

COMMIT;

SELECT * FROM user_tab_privs;

select * from hr.emp;

select * from hr.dept;

SELECT * FROM hr.emp_details;