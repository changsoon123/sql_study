SELECT * FROM user_unused_col_tabs;

select * from user_sequences where sequence_name = 'EMP';

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT employee_id, salary, job_id
FROM hr.employees;

SELECT * FROM hr.emp;

INSERT INTO hr.emp(employee_id, salary,job_id) VALUES(300,3000,'IT_PROG');

SELECT * FROM hr.emp;

ROLLBACK;

SELECT * FROM hr.jobs;

UPDATE hr.emp
SET salary = 20000
WHERE employee_id = 103;

var b_id number;
var b_job varchar2(30);
var b_salary number;

execute :b_id := 300;
execute :b_job := 'IT_PROG';
execute :b_salary := 3000;

DECLARE
    j_min number;
    j_max number;
BEGIN
    
    SELECT min_salary, max_salary
    INTO j_min,j_max
    FROM hr.jobs
    WHERE job_id = :b_job;
    
    IF :b_salary BETWEEN j_min AND j_max THEN
        INSERT INTO hr.emp(employee_id, salary ,job_id) VALUES(:b_id,:b_salary,:b_job);
    ELSE
        RAISE_APPLICATION_ERROR(-20000,:b_job||' 급여 범위는 ' || j_min || '~' || j_max|| ' 입니다.');
    END IF;
    
--    IF :b_salary BETWEEN j_min AND j_max THEN
--        UPDATE hr.emp
--        SET salary = :b_salary
--        WHERE employee_id = :b_id;
--    END IF;
        
END;
/

CREATE OR REPLACE PROCEDURE emp_check(b_job IN varchar2, b_salary IN number, b_id IN number)
IS
    j_min number;
    j_max number;
BEGIN

    SELECT min_salary, max_salary
    INTO j_min,j_max
    FROM hr.jobs
    WHERE job_id = b_job;
    
    IF b_salary BETWEEN j_min AND j_max THEN
        INSERT INTO hr.emp(employee_id, salary ,job_id) VALUES(b_id,b_salary,b_job);
    ELSE
        RAISE_APPLICATION_ERROR(-20000,b_job||' 급여 범위는 ' || j_min || '~' || j_max|| ' 입니다.');
    END IF;
    
--    IF :b_salary BETWEEN j_min AND j_max THEN
--        UPDATE hr.emp
--        SET salary = :b_salary
--        WHERE employee_id = :b_id;
--    END IF;
END;
/

SELECT e.* , j.*
FROM hr.emp e, hr.jobs j
WHERE e.job_id = j.job_id;

CREATE OR REPLACE TRIGGER hr.salary_check
AFTER
INSERT OR UPDATE OF salary, job_id ON hr.emp
FOR EACH ROW
DECLARE
    v_minsal number;
    v_maxsal number;
BEGIN
    SELECT min_salary, max_salary
    INTO v_minsal,v_maxsal
    FROM hr.jobs
    WHERE job_id = :NEW.job_id;
    
    IF :NEW.salary NOT BETWEEN v_minsal AND v_maxsal THEN
        RAISE_APPLICATION_ERROR(-20000,:NEW.job_id||' 급여 범위는 ' || v_minsal || '~' || v_maxsal|| ' 입니다.');    
    END IF;
    
END;
/

UPDATE hr.emp
SET salary = 20000
WHERE employee_id = 103;

INSERT INTO hr.emp(employee_id, salary,job_id) VALUES(300,3000,'IT_PROG');

UPDATE hr.emp
SET job_id = 'AD_ASST'
WHERE employee_id = 206;

SELECT * FROM hr.emp;

ROLLBACK;

SELECT * FROM hr.jobs;

CREATE OR REPLACE TRIGGER hr.salary_check
AFTER
INSERT OR UPDATE OF salary, job_id ON hr.emp
FOR EACH ROW
DECLARE
    v_minsal number;
    v_maxsal number;
BEGIN
    SELECT min_salary, max_salary
    INTO v_minsal,v_maxsal
    FROM hr.jobs
    WHERE job_id = :NEW.job_id;
    
    IF :NEW.salary NOT BETWEEN v_minsal AND v_maxsal THEN
        RAISE_APPLICATION_ERROR(-20000,:NEW.job_id||' 급여 범위는 ' || v_minsal || '~' || v_maxsal|| ' 입니다.');    
    END IF;
    
END;
/

CREATE OR REPLACE TRIGGER hr.salary_check
AFTER
INSERT OR UPDATE OF salary, job_id ON hr.emp
FOR EACH ROW
BEGIN
    hr.emp_check(:NEW.job_id, :NEW.salary, :NEW.employee_id);
END;
/

INSERT INTO hr.emp(employee_id, salary,job_id) VALUES(300,3000,'IT_PROG');

UPDATE hr.emp
SET salary = 20000
WHERE employee_id = 103;

call hr.emp_check('IT_PROG',3000,300);

CREATE OR REPLACE TRIGGER hr.salary_check
AFTER
INSERT OR UPDATE OF salary, job_id ON hr.emp
FOR EACH ROW
call hr.emp_check(:NEW.job_id, :NEW.salary, :NEW.employee_id)
/

INSERT INTO hr.emp(employee_id, salary,job_id) VALUES(300,3000,'IT_PROG');

SELECT * FROM user_triggers WHERE trigger_name = 'SALARY_CHECK';
SELECT * FROM user_source WHERE name = 'SALARY_CHECK' ORDER BY line;

DROP TRIGGER HR.SALARY_CHECK;

ROLLBACK;
SELECT * FROM hr.emp;
SELECT * FROM hr.emp WHERE job_id = 'IT_PROG';


CREATE OR REPLACE TRIGGER hr.salary_check
AFTER
INSERT OR UPDATE OF salary, job_id ON hr.emp
FOR EACH ROW
DECLARE
    v_minsal number;
    v_maxsal number;
BEGIN
    SELECT min(salary), max(salary)
    INTO v_minsal,v_maxsal
    FROM hr.emp
    WHERE job_id = :NEW.job_id;
    
    IF :NEW.salary NOT BETWEEN v_minsal AND v_maxsal THEN
        RAISE_APPLICATION_ERROR(-20000,:NEW.job_id||' 급여 범위는 ' || v_minsal || '~' || v_maxsal|| ' 입니다.');    
    END IF;
    
END;
/

INSERT INTO hr.emp(employee_id, salary,job_id) VALUES(300,3000,'IT_PROG');

SELECT job_id, min(salary), max(salary)
FROM hr.emp
GROUP BY job_id;

DECLARE
    TYPE emp_type IS TABLE OF number INDEX BY varchar2(30);
    emp_min_sal emp_type;
    emp_max_sal emp_type;
    v_job varchar2(30);
BEGIN
    FOR i IN (SELECT job_id, min(salary) minsal, max(salary) maxsal
            FROM hr.emp
        GROUP BY job_id) LOOP
        
    emp_min_sal(i.job_id) := i.minsal;
    emp_max_sal(i.job_id) := i.maxsal;
      
    END LOOP;
    
    v_job := emp_min_sal.first;
    
    dbms_output.put_line(v_job || ' ' || emp_min_sal(v_job) || ' ~ ' || emp_max_sal(v_job));
    
    LOOP
        v_job := emp_min_sal.next(v_job);
        EXIT WHEN v_job IS NULL;
        dbms_output.put_line(v_job || ' ' || emp_min_sal(v_job) || ' ~ ' || emp_max_sal(v_job));
    END LOOP;
    
END;
/

DROP TRIGGER HR.SALARY_CHECK;

CREATE OR REPLACE TRIGGER hr.check_salary
FOR INSERT OR UPDATE OF salary, job_id ON hr.emp
COMPOUND TRIGGER
    TYPE emp_type IS TABLE OF number INDEX BY varchar2(30);
    emp_min_sal emp_type;
    emp_max_sal emp_type;
BEFORE STATEMENT IS
BEGIN
    FOR i IN (SELECT job_id, min(salary) minsal, max(salary) maxsal
    FROM hr.emp
    GROUP BY job_id) LOOP

    emp_min_sal(i.job_id) := i.minsal;
    emp_max_sal(i.job_id) := i.maxsal;

END LOOP;

END BEFORE STATEMENT;
AFTER EACH ROW IS
BEGIN

    IF :NEW.salary < emp_min_sal(:NEW.job_id) OR :NEW.salary > emp_max_sal(:NEW.job_id) THEN
            RAISE_APPLICATION_ERROR(-20000,:NEW.job_id ||' 급여 범위는 ' || emp_min_sal(:NEW.job_id) || '~' || emp_max_sal(:NEW.job_id) || ' 입니다.');    
    END IF;

END AFTER EACH ROW;

END check_salary;
/

INSERT INTO hr.emp(employee_id, salary,job_id) VALUES(300,3000,'IT_PROG');

DROP TRIGGER hr.check_salary;

CREATE OR REPLACE TRIGGER hr.check_salary_before
AFTER
INSERT OR UPDATE OF salary, job_id ON hr.emp
BEGIN
    FOR i IN (SELECT job_id, min(salary) minsal, max(salary) maxsal
        FROM hr.emp
        GROUP BY job_id) LOOP
        NULL;

    END LOOP;

END check_salary_before;
/

DROP PACKAGE hr.job_pkg;

CREATE TABLE hr.log_table
(username varchar2(30),
date_time timestamp,
message varchar2(100))
TABLESPACE users;

CREATE TABLE hr.temp_table(n number) TABLESPACE users;

CREATE OR REPLACE PROCEDURE hr.log_message(p_message IN varchar2)
IS
BEGIN
    INSERT INTO hr.log_table(username, date_time, message)
    VALUES(user, localtimestamp, p_message);
    COMMIT;
END log_message;
/

SELECT * FROM hr.log_table;

SELECT * FROM hr.temp_table;

BEGIN
    hr.log_message('열심히 복습하자!!');
    
    INSERT INTO hr.temp_table(n) VALUES(100);
    
    hr.log_message('열심히 공부해서 꼭 취업하자!!');
    
    ROLLBACK;
END;
/


SELECT * FROM hr.log_table;

SELECT * FROM hr.temp_table;

TRUNCATE TABLE hr.log_table;

TRUNCATE TABLE hr.temp_table;

CREATE OR REPLACE PROCEDURE hr.log_message(p_message IN varchar2)
IS
PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO hr.log_table(username, date_time, message)
    VALUES(user, localtimestamp, p_message);
    COMMIT;
END log_message;
/

SELECT * FROM hr.log_table;

SELECT * FROM hr.temp_table;

BEGIN
    hr.log_message('열심히 복습하자!!');
    
    INSERT INTO hr.temp_table(n) VALUES(100);
    
    hr.log_message('열심히 공부해서 꼭 취업하자!!');
    
    ROLLBACK;
END;
/

DROP TABLE test PURGE;

CREATE TABLE hr.log_tab(id number, name varchar2(30), log_day timestamp default systimestamp);

CREATE TABLE hr.test(id number, name varchar2(30), log_day timestamp default systimestamp);

CREATE OR REPLACE TRIGGER hr.log_trigger
AFTER
INSERT ON hr.test
FOR EACH ROW
DECLARE
    PRAGMA AUTONOMOUS_TRANSACTION;
BEGIN
    INSERT INTO hr.log_tab(id, name, log_day) VALUES(:NEW.id, :NEW.name, default);
    COMMIT;
END log_trigger;
/

INSERT INTO hr.test(id,name) VALUES(100,'ORACLE');

ROLLBACK;

SELECT * FROM hr.log_tab;
SELECT * FROM hr.test;
