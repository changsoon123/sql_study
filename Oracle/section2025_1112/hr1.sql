SELECT *
FROM hr.employees
WHERE LNNVL(department_id<>50);


CREATE OR REPLACE PROCEDURE emp_proc
(e_id IN number,
l_name OUT varchar2,
sal OUT number,
d_name OUT varchar2)
IS
    eos EXCEPTION;
BEGIN
    IF  e_id = 100 THEN
        RAISE eos;
    ELSE
        SELECT e.last_name, e.salary, d.department_name
        INTO l_name, sal, d_name
        FROM hr.employees e, hr.departments d
        WHERE e.department_id = d.department_id
        AND employee_id = e_id;
    END IF;
    
EXCEPTION
    WHEN eos THEN
        NULL;
    WHEN no_data_found THEN
        dbms_output.put_line(e_id || '사원은 존재하지 않습니다.');
END;
/

DECLARE
    v_name varchar2(30);
    v_sal number;
    v_dname varchar2(30);
BEGIN
    emp_proc(100,v_name,v_sal,v_dname);
    dbms_output.put_line(v_name || ' ' || v_sal || ' ' || v_dname);
END;
/
commit;

SELECT text FROM user_source WHERE name = 'EMP_PROC' ORDER BY line;
SELECT * FROM user_objects WHERE object_name = 'EMP_PROC';

CREATE OR REPLACE PROCEDURE emp_proc
(e_id IN number,
l_name OUT varchar2,
sal OUT number,
d_name OUT varchar2)
IS
BEGIN
    IF  e_id = 100 THEN
        RETURN;
    ELSE
        SELECT e.last_name, e.salary, d.department_name
        INTO l_name, sal, d_name
        FROM hr.employees e, hr.departments d
        WHERE e.department_id = d.department_id
        AND employee_id = e_id;
    END IF;
    
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line(e_id || '사원은 존재하지 않습니다.');
END;
/

CREATE OR REPLACE PROCEDURE emp_proc
(e_id IN number,
l_name OUT varchar2,
sal OUT number,
d_name OUT varchar2)
IS
BEGIN
    IF  e_id = 100 THEN
        RETURN;
    ELSE
        SELECT e.last_name, e.salary, d.department_name
        INTO l_name, sal, d_name
        FROM hr.employees e, hr.departments d
        WHERE e.department_id = d.department_id
        AND employee_id = e_id;
    END IF;
    
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line(e_id || '사원은 존재하지 않습니다.');
END;
/

desc emp_proc;

drop PROCEDURE emp_proc;

SELECT
    substr('01012345678',1,3) || '-' || substr('01012345678',4,4) || '-' || substr('01012345678',8)
FROM dual;

CREATE OR REPLACE PROCEDURE emp_proc
( v_no OUT varchar2)
IS
 b_no varchar2(30) := '01012345678';
BEGIN
    v_no := substr(b_no,1,3) || '-' || substr(b_no,4,4) || '-' || substr(b_no,8);
END;
/

DECLARE
    vv_no varchar2(30);
BEGIN
    emp_proc(vv_no);
    dbms_output.put_line(vv_no);
END;
/

CREATE OR REPLACE PROCEDURE format_phone(p_no IN OUT varchar2)
IS
BEGIN
    p_no := substr(p_no,1,3) || '-' || substr(p_no,4,4) || '-' || substr(p_no,8);
END;
/

desc format_phone;

DECLARE
    vv_no varchar2(30) := '01012345678';
BEGIN
    format_phone(vv_no);
    dbms_output.put_line(vv_no);
END;
/

CREATE TABLE hr.sawon
(id number , name varchar2(30), day date, deptno number)
TABLESPACE users;

desc hr.sawon;

CREATE OR REPLACE PROCEDURE sawon_insert
(p_id IN number,
p_name IN varchar2,
p_day IN date default sysdate,
p_dept_no IN NUMBER)
IS
BEGIN
INSERT INTO hr.sawon(id, name, day,deptno) VALUES(p_id,p_name,p_day,p_dept_no);
END sawon_insert;
/

exec sawon_insert(1,'oracle', sysdate, 10);

exec sawon_insert(p_id=>1, p_name=>'oracle', p_day => sysdate, p_dept_no => 10);

select * from hr.sawon;

exec sawon_insert(1,'oracle', sysdate, p_dept_no => 10);
to_date('2025-01-01','yyyy-mm-dd');
exec sawon_insert(1, p_name => 'oracle', sysdate , 10);

CREATE USER anna IDENTIFIED BY oracle;

GRANT create session TO anna;

rollback;

GRANT SELECT ON hr.sawon TO anna;
GRANT execute ON hr.sawon_insert TO anna;

select * from user_tab_privs;

select * from hr.sawon;

delete from hr.sawon;

commit;

drop table hr.emp purge;
drop table hr.dept purge;

CREATE TABLE hr.emp AS SELECT * FROM hr.employees;
CREATE TABLE hr.dept AS SELECT * FROM hr.departments;

ALTER TABLE hr.emp ADD CONSTRAINT empid_pk PRIMARY KEY(employee_id);
ALTER TABLE hr.dept ADD CONSTRAINT deptid_pk PRIMARY KEY(department_id);
ALTER TABLE hr.dept ADD CONSTRAINT dept_mgr_id_fk FOREIGN KEY(manager_id) REFERENCES hr.emp(employee_id);

SELECT * FROM user_constraints WHERE table_name IN ('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN ('DEPT','EMP');

SELECT max(department_id)
FROM hr.dept;

CREATE OR REPLACE PROCEDURE add_dept
(p_name IN varchar2,
p_mgr IN number,
p_loc IN number)
IS
    v_max number;
BEGIN

    SELECT max(department_id)
    INTO v_max
    FROM hr.dept;

    INSERT INTO hr.dept(department_id, department_name,manager_id, location_id)
    VALUES(v_max+10, p_name, p_mgr, p_loc);
    EXCEPTION
        WHEN others THEN
            dbms_output.put_line('오류부서 : ' || p_name);
            dbms_output.put_line(sqlerrm);
END add_dept;
/

desc add_dept

exec add_dept('경영기획',100,1800);

select *
from hr.dept;

rollback;

exec add_dept('경영기획',300,1800);

BEGIN
    add_dept('경영기획', 100, 1800);
    add_dept('데이터아키텍처', 300, 1800);
    add_dept('인재개발', 101, 1800);
END;
/

CREATE OR REPLACE PROCEDURE add_dept
(p_name IN varchar2,
p_mgr IN number,
p_loc IN number)
IS
    v_max number;
BEGIN

    SELECT max(department_id)
    INTO v_max
    FROM hr.dept;

    INSERT INTO hr.dept(department_id, department_name,manager_id, location_id)
    VALUES(v_max+10, p_name, p_mgr, p_loc);

END add_dept;
/

BEGIN
    add_dept('경영기획', 100, 1800);
    add_dept('데이터아키텍처', 300, 1800);
    add_dept('인재개발', 101, 1800);
EXCEPTION
    WHEN others THEN
        dbms_output.put_line(sqlerrm);
END;
/

select *
from hr.dept;

ROLLBACK;

drop procedure add_dept;

CREATE OR REPLACE PROCEDURE get_sal_proc
(p_id IN number, p_sal OUT number)
IS
BEGIN
    SELECT salary
    INTO p_sal
    FROM hr.employees
    WHERE employee_id = p_id;
EXCEPTION
    WHEN no_data_found THEN
        return;
    
END get_sal_proc;
/

desc get_sal_proc;

var b_sal number

exec get_sal_proc(150, b_sal)

CREATE OR REPLACE FUNCTION get_sal_func
(p_id IN number)
RETURN number
IS
    v_sal number;
BEGIN
    SELECT salary
    INTO v_sal
    FROM hr.employees
    WHERE employee_id = p_id;
    RETURN v_sal;
EXCEPTION
    WHEN no_data_found THEN
        return v_sal;
END get_sal_func;
/