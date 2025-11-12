
SELECT * FROM session_privs;

SELECT * FROM user_tab_privs;

select * from hr.sawon;

desc hr.sawon;

exec hr.sawon_insert(1,'oracle',p_deptno=>10);

INSERT INTO hr.sawon(id,name,day,deptno) values(1,'oracle',sysdate,10);