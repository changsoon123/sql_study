CREATE OR REPLACE PACKAGE global_conts
IS
c_mile_2_kilo constant number := 1.6093;
c_kilo_2_mile constant number := 0.6214;
c_yard_2_meter constant number := 0.9144;
c_meter_2_yard constant number := 1.0936;


END global_conts;
/

exec dbms_output.put_line('20 mile = '|| 20*global_conts.c_mile_2_kilo || 'km');

exec dbms_output.put_line('20 kilo = '|| 20*global_conts.c_kilo_2_mile || 'km');

exec dbms_output.put_line('20 yard = '|| 20*global_conts.c_yard_2_meter || 'km');

exec dbms_output.put_line('20 meter = '|| 20*global_conts.c_meter_2_yard || 'km');


CREATE OR REPLACE FUNCTION mtr_to_yrd(p_m IN number)
RETURN number
IS
BEGIN
        RETURN p_m * global_conts.c_meter_2_yard;
END mtr_to_yrd;
/

exec dbms_output.put_line(mtr_to_yrd(20));

GRANT execute ON hr.global_conts TO anna;
GRANT execute ON hr.mtr_to_yrd TO anna;

DESC hr.departments;

DECLARE
    e_notnull EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_notnull, -1400);
BEGIN
    INSERT INTO hr.departments(department_id,department_name) VALUES(300,NULL);

EXCEPTION
    WHEN e_notnull THEN
        dbms_output.put_line('필수항목 값을 꼭 입력하세요.');
    WHEN others THEN
        dbms_output.put_line(sqlerrm);
END;
/

CREATE OR REPLACE PACKAGE err_pkg
IS
    notnull_err EXCEPTION;
    PRAGMA EXCEPTION_INIT(notnull_err,-1400);
    
END err_pkg;
/

BEGIN
    INSERT INTO hr.departments(department_id,department_name) VALUES(300,NULL);

EXCEPTION
    WHEN err_pkg.notnull_err THEN
        dbms_output.put_line('필수항목 값을 꼭 입력하세요.');
    WHEN others THEN
        dbms_output.put_line(sqlerrm);
END;
/

DECLARE
    CURSOR emp_cur IS
    SELECT *
    FROM hr.employees
    WHERE department_id = 20;
    
    v_rec emp_cur%rowtype;
BEGIN
    OPEN emp_cur;

    LOOP
        FETCH emp_cur INTO v_rec;
        EXIT WHEN emp_cur%NOTFOUND;
        dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
    END LOOP;
    
    CLOSE emp_cur;
END;
/

CREATE OR REPLACE PACKAGE pack_cur
IS
    PROCEDURE open;
    PROCEDURE next(p_num IN number);
    PROCEDURE close;
END pack_cur;
/

CREATE OR REPLACE PACKAGE BODY pack_cur
IS
    /* private cursor : package body 안에서만 사용하는 cursor */
    CURSOR c1 IS
        SELECT employee_id, last_name
        FROM hr.employees
        ORDER BY employee_id DESC;
    
    /* private variable : package body 안에서만 사용하는 변수 */
    v_id number;
    v_name varchar2(30);
    
    PROCEDURE open
    IS
    BEGIN
        IF NOT c1%ISOPEN THEN
            OPEN c1;
            dbms_output.put_line('c1 cursor open');
        END IF;
    END open;
    
    
    PROCEDURE next(p_num IN number)
    IS
    BEGIN
        LOOP
            EXIT WHEN c1%ROWCOUNT >= p_num OR c1%NOTFOUND;
            FETCH c1 INTO v_id, v_name;
            dbms_output.put_line(v_id || ' ' || v_name);
        END LOOP;
    END next;
    
    PROCEDURE close
    IS
    BEGIN
        IF c1%ISOPEN THEN
            CLOSE c1;
            dbms_output.put_line('c1 cursor close');
        END IF;
    END close;
    
END pack_cur;
/

desc pack_cur;

exec pack_cur.next(3);

exec pack_cur.close;
exec pack_cur.open;

exec pack_cur.next(3);
exec pack_cur.next(6);
exec pack_cur.next(9);


exec pack_cur.open;
exec pack_cur.close;

CREATE OR REPLACE PACKAGE comm_pkg
IS
    PRAGMA SERIALLY_REUSABLE;
    g_comm number := 0.1;  
    PROCEDURE reset_comm(p_comm IN number);
    
END comm_pkg;
/

CREATE OR REPLACE PACKAGE BODY comm_pkg
IS
    PRAGMA SERIALLY_REUSABLE;
    
    FUNCTION validate_comm(p_comm IN number)
    RETURN boolean
    IS
        v_comm number;
    BEGIN
        SELECT max(commission_pct)
        INTO v_comm
        FROM hr.employees;
        
        IF p_comm > v_comm THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    END validate_comm;
    
    PROCEDURE reset_comm(p_comm IN number)
    IS
    BEGIN
        IF validate_comm(p_comm) THEN
            dbms_output.put_line('OLD : ' || g_comm);
            g_comm := p_comm;
            dbms_output.put_line('NEW : ' || g_comm);
        ELSE
            raise_application_error(-20000, '기존 최고값을 넘을 수 없습니다.');
        END IF;
        
    END reset_comm;
    
END comm_pkg;
/

exec dbms_output.put_line(comm_pkg.g_comm);

exec comm_pkg.reset_comm(0.2);

exec dbms_output.put_line(comm_pkg.g_comm);

DROP PACKAGE comm_pkg;

DROP PACKAGE BODY comm_pkg;

DROP TABLE hr.dept PURGE;

CREATE TABLE hr.dept
AS
SELECT * FROM hr.departments;

SELECT * FROM hr.dept;

INSERT INTO hr.dept(department_id, department_name, manager_id, location_id)
VALUES(300,'Data Architect',100,1500);

SELECT * FROM hr.dept;

rollback;

select * from session_privs;

CREATE OR REPLACE TRIGGER dept_before
BEFORE  -- 해석을 INSERT ON hr.dept 하기전에 BEGIN 절 수행으로 해석해야 한다.
    INSERT ON hr.dept
BEGIN
    dbms_output.put_line('INSERT 하기전에 문장트리거 수행');
END dept_before;
/

CREATE OR REPLACE TRIGGER dept_after
AFTER  -- 해석을 INSERT ON hr.dept 한 후에 BEGIN 절 수행으로 해석해야 한다.
    INSERT ON hr.dept
BEGIN
    dbms_output.put_line('INSERT 한 후에 문장트리거 수행');
END dept_after;
/


CREATE OR REPLACE TRIGGER dept_row_before
BEFORE
INSERT ON hr.dept
FOR EACH ROW
BEGIN
	dbms_output.put_line('INSERT하기전에 행트리거 수행');

END dept_row_before;
/

DROP TRIGGER dept__row_before;

CREATE OR REPLACE TRIGGER dept_row_after
AFTER
INSERT ON hr.dept
FOR EACH ROW
BEGIN
	dbms_output.put_line('INSERT한 후에 행트리거 수행');
END dept_row_after;
/

INSERT INTO hr.dept(department_id, department_name, manager_id, location_id)
VALUES(300,'Data Architect',100,1500);

SELECT * FROM hr.dept;

rollback;

SELECT * FROM user_triggers WHERE table_name = 'DEPT';

SELECT * FROM user_source WHERE name = 'DEPT_ROW_AFTER';

SELECT * FROM user_objects WHERE object_name = 'DEPT_ROW_AFTER';
SELECT * FROM user_triggers WHERE trigger_name = 'DEPT_ROW_AFTER';

ALTER TRIGGER dept_row_after DISABLE;

INSERT INTO hr.dept(department_id, department_name, manager_id, location_id)
VALUES(300,'Data Architect',100,1500);

ALTER TRIGGER dept_row_after ENABLE;

DROP TRIGGER dept_row_before;
DROP TRIGGER dept_row_after;
DROP TRIGGER dept_before;
DROP TRIGGER dept_after;

-- before 문장 트리거

CREATE OR REPLACE TRIGGER secure_dept
BEFORE
INSERT OR UPDATE OR DELETE ON hr.dept
BEGIN
    IF to_char(sysdate, 'hh24:mi') NOT BETWEEN '09:00' AND '15:00' THEN
        RAISE_APPLICATION_ERROR(-20000,'DML작업을 수행할 수 없습니다.');
    END IF;
END secure_dept;
/


-- after 문장 트리거

CREATE OR REPLACE TRIGGER secure_dept
AFTER
INSERT OR UPDATE OR DELETE ON hr.dept
BEGIN
    IF to_char(sysdate, 'hh24:mi') NOT BETWEEN '09:00' AND '15:00' THEN
        RAISE_APPLICATION_ERROR(-20000,'DML작업을 수행할 수 없습니다.');
    END IF;
END secure_dept;
/

rollback;

SELECT * FROM hr.dept;

INSERT INTO hr.dept(department_id, department_name, manager_id, location_id)
VALUES(300,'Data Architect',100,1500);

UPDATE hr.dept
SET location_id = 1500
WHERE department_id = 100;

DELETE
FROM hr.dept
WHERE department_id = 10;


INSERT INTO hr.dept(department_id, department_name, manager_id, location_id)
VALUES(300,'Data Architect',100,1500);

-- before 문장 트리거

CREATE OR REPLACE TRIGGER secure_dept
BEFORE
INSERT OR UPDATE OR DELETE ON hr.dept
BEGIN
    IF to_char(sysdate, 'hh24:mi') NOT BETWEEN '09:00' AND '15:00' THEN
        IF inserting THEN
            RAISE_APPLICATION_ERROR(-20000,'입력 시간이 아닙니다.');
        ELSIF updating THEN
            RAISE_APPLICATION_ERROR(-20001,'수정 시간이 아닙니다.');
        ELSIF deleting THEN
            RAISE_APPLICATION_ERROR(-20002,'삭제 시간이 아닙니다.');
        END IF;
    END IF;
END secure_dept;
/

INSERT INTO hr.dept(department_id, department_name, manager_id, location_id)
VALUES(300,'Data Architect',100,1500);

UPDATE hr.dept
SET location_id = 1500
WHERE department_id = 100;

DELETE
FROM hr.dept
WHERE department_id = 10;

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT * FROM hr.employees;

CREATE OR REPLACE TRIGGER emp_before
BEFORE  -- 해석을 INSERT ON hr.dept 하기전에 BEGIN 절 수행으로 해석해야 한다.
    UPDATE ON hr.emp
BEGIN
    dbms_output.put_line('INSERT 하기전에 문장트리거 수행');
END emp_before;
/

CREATE OR REPLACE TRIGGER emp_after
AFTER  -- 해석을 INSERT ON hr.dept 한 후에 BEGIN 절 수행으로 해석해야 한다.
    UPDATE ON hr.emp
BEGIN
    dbms_output.put_line('INSERT 한 후에 문장트리거 수행');
END emp_after;
/


CREATE OR REPLACE TRIGGER emp_row_before
BEFORE
UPDATE ON hr.emp
FOR EACH ROW
BEGIN
	dbms_output.put_line('INSERT하기전에 행트리거 수행');

END emp_row_before;
/


CREATE OR REPLACE TRIGGER emp_row_after
AFTER
UPDATE ON hr.emp
FOR EACH ROW
BEGIN
	dbms_output.put_line('INSERT한 후에 행트리거 수행');
END emp_row_after;
/
SELECT * FROM user_triggers WHERE table_name = 'EMP';

SELECT * FROM user_source WHERE name = 'DEPT_ROW_AFTER';

SELECT * FROM user_objects WHERE object_name = 'EMP_ROW_AFTER';
SELECT * FROM user_objects WHERE object_name = 'EMP_ROW_BEFORE';
SELECT * FROM user_objects WHERE object_name = 'EMP_BEFORE';
SELECT * FROM user_objects WHERE object_name = 'EMP_AFTER';
SELECT * FROM user_objects;
SELECT * FROM user_triggers WHERE trigger_name = 'DEPT_ROW_AFTER';

UPDATE hr.emp
SET salary = salary * 1.1 
WHERE employee_id = 100;

rollback;


UPDATE hr.emp
SET salary = salary * 1.1 
WHERE department_id = 20;

DROP TRIGGER emp_before;
DROP TRIGGER emp_after;
DROP TRIGGER emp_row_before;
DROP TRIGGER emp_row_after;

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT employee_id, last_name, salary, department_id
FROM hr.employees;

CREATE OR REPLACE TRIGGER emp_trg
BEFORE
INSERT OR DELETE OR UPDATE OF salary ON hr.emp
FOR EACH ROW
WHEN (NEW.department_id = 20 OR OLD.department_id = 10)
DECLARE
    v_sal number;
BEGIN
    IF deleting THEN
        dbms_output.put_line('OLD EMPLOYEE_ID : '|| :OLD.employee_id);
        dbms_output.put_line('OLD salary : '|| :OLD.salary);
    ELSIF inserting THEN
        dbms_output.put_line('NEW EMPLOYEE_ID : '|| :NEW.employee_id);
        dbms_output.put_line('NEW salary : '|| :NEW.salary);
    ELSE
        v_sal := :NEW.salary - :OLD.salary;
        dbms_output.put_line('EMPLOYEE_ID : ' || :OLD.employee_id);
        dbms_output.put_line('이전 급여 : ' || :OLD.salary);
        dbms_output.put_line('수정 급여 : ' || :NEW.salary);
        dbms_output.put_line('급여 차이 : ' || v_sal);        
    END IF;
END emp_trg;
/

DELETE
FROM hr.emp
WHERE department_id = 10;

UPDATE hr.emp
SET salary = salary * 1.1
WHERE department_id = 20;

INSERT INTO hr.emp(employee_id, last_name, salary, department_id)
VALUES(9999, 'soon', 9090, 20);

rollback;