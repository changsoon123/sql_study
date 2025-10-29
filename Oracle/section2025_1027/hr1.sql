SELECT * FROM user_tab_privs;

SELECT * FROM user_tab_privs;

GRANT SELECT ON hr.departments TO insa;

REVOKE SELECT ON hr.departments FROM insa;
REVOKE SELECT ON hr.employees FROM insa;

CREATE TABLE hr.emp
AS
SELECT * FROM hr.employees;

SELECT * FROM hr.emp;

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT employee_id id, last_name || ' ' || first_name name, salary sal, department_id dept_id
FROM hr.employees;

CREATE TABLE hr.emp
AS
SELECT *
FROM hr.employees
WHERE 1 = 2; -- 테이블 구조만 복제한다. 데이터는 복제하지 않습니다.

SELECT * FROM user_tables WHERE table_name = 'EMP';
SELECT * FROM user_tab_columns WHERE table_name = 'EMP';

SELECT * FROM hr.emp;

INSERT INTO hr.emp(id,name)
SELECT employee_id, last_name
FROM hr.employees;

CREATE TABLE hr.emp
(id number,
    name varchar2(30),
    dept_id number,
    dept_name varchar2(30))
TABLESPACE users;

commit;

SELECT * FROM hr.emp;

SELECT * FROM hr.emp WHERE id = 100;

UPDATE hr.emp
SET name = null
WHERE id = 100;

SELECT last_name FROM hr.employees WHERE employee_id = 100;

UPDATE hr.emp
SET name = (SELECT last_name FROM hr.employees WHERE employee_id = 100)
WHERE id = 100;

commit;

SELECT * FROM hr.emp WHERE id = 100;

ROLLBACK;

UPDATE hr.emp e
SET dept_id = (SELECT department_id 
               FROM hr.employees 
               WHERE employee_id = e.id);
               
               
SELECT * FROM hr.emp;

commit;

SELECT * FROM hr.emp;

UPDATE hr.emp e
SET dept_name = (SELECT department_name 
               FROM hr.departments 
               WHERE department_id = e.dept_id);
               

commit;

SELECT * FROM hr.emp;

SELECT *
FROM hr.emp
WHERE id IN (
    SELECT employee_id
    FROM hr.employees
    WHERE hire_date >= to_date('2003-01-01','yyyy-mm-dd')
    AND hire_date < to_date('2004-01-01','yyyy-mm-dd'));
    
SELECT *
FROM hr.emp e
WHERE EXISTS (
    SELECT employee_id
    FROM hr.employees
    WHERE hire_date >= to_date('2003-01-01','yyyy-mm-dd')
    AND hire_date < to_date('2004-01-01','yyyy-mm-dd')
    AND employee_id = e.id);
    
    
DELETE FROM hr.emp
WHERE id IN (
    SELECT employee_id
    FROM hr.employees
    WHERE hire_date >= to_date('2003-01-01','yyyy-mm-dd')
    AND hire_date < to_date('2004-01-01','yyyy-mm-dd'));
    
ROLLBACK;

DELETE FROM hr.emp e
WHERE EXISTS (
    SELECT employee_id
    FROM hr.employees
    WHERE hire_date >= to_date('2003-01-01','yyyy-mm-dd')
    AND hire_date < to_date('2004-01-01','yyyy-mm-dd')
    AND employee_id = e.id);
    
DELETE
FROM hr.emp
WHERE id IN (SELECT employee_id
            FROM hr.job_history);

ROLLBACK;      
      
DELETE
FROM hr.emp e
WHERE EXISTS (SELECT employee_id
            FROM hr.job_history
            WHERE employee_id = e.id); --Transaction 시작(진행중)
            

SELECT *
FROM hr.emp
WHERE id IN (SELECT employee_id
            FROM hr.job_history);
            
CREATE TABLE hr.test(id number) TABLESPACE USERS;

ROLLBACK;

CREATE TABLE hr.test(id number) TABLESPACE USERS;

SELECT * FROM hr.test;

INSERT INTO hr.test(id) VALUES(1);
INSERT INTO hr.test(id) VALUES(2);
INSERT INTO hr.test(id) VALUES(3);

commit;
SELECT * FROM hr.test;

INSERT INTO hr.test(id) VALUES(100);

UPDATE hr.test
SET id = 300
WHERE id = 3;

SELECT * FROM hr.test;

DELETE FROM hr.test WHERE id = 2;

SELECT * FROM hr.test;

ROLLBACK;

----------------------------------------------

INSERT INTO hr.test(id) VALUES(100);

SAVEPOINT A;

UPDATE hr.test
SET id = 300
WHERE id = 3;

SAVEPOINT B;

SELECT * FROM hr.test;

DELETE FROM hr.test WHERE id = 2;

SELECT * FROM hr.test;

ROLLBACK TO A; --B

COMMIT;

CREATE TABLE hr.sal_history
(id number, day date, sal number)
TABLESPACE users;

CREATE TABLE hr.mgr_history
(id number, mgr number, sal number)
TABLESPACE users;

SELECT * FROM hr.sal_history;

INSERT INTO hr.sal_history(id,day,sal)
SELECT employee_id, hire_date, salary
FROM hr.employees;

INSERT INTO hr.mgr_history(id,mgr,sal)
SELECT employee_id, manager_id, salary
FROM hr.employees;

SELECT * FROM hr.sal_history;
SELECT * FROM hr.mgr_history;

ROLLBACK;

SELECT * FROM hr.sal_history;
SELECT * FROM hr.mgr_history;

INSERT ALL
INTO hr.sal_history(id,day,sal) VALUES(employee_id, hire_date,salary)
INTO hr.mgr_history(id,mgr,sal) VALUES(employee_id, manager_id, salary)
SELECT employee_id, hire_date, manager_id, salary
FROM hr.employees;

INSERT ALL
INTO hr.sal_history(id,day,sal) VALUES(no, hire,sal)
INTO hr.mgr_history(id,mgr,sal) VALUES(no, mgr_id, sal)
SELECT employee_id no, hire_date hire, manager_id mgr_id, salary*1.1 sal
FROM hr.employees;

ROLLBACK;

SELECT * FROM hr.sal_history;
SELECT * FROM hr.mgr_history;

CREATE TABLE hr.emp_history
(id number, day date, sal number)
TABLESPACE users;

CREATE TABLE hr.emp_sal
(id number, comm number, sal number)
TABLESPACE users;

SELECT * FROM hr.emp_history;
SELECT * FROM hr.emp_sal;

INSERT ALL
WHEN day < to_date('2005-01-01','yyyy-mm-dd') AND sal >= 5000 THEN
    INTO hr.emp_history(id,day,sal) VALUES(id,day,sal)
WHEN comm IS NOT NULL THEN
    INTO hr.emp_sal(id,comm,sal) VALUES(id,comm,sal)
SELECT employee_id id, hire_date day, salary sal, commission_pct comm
FROM hr.employees;

CREATE TABLE hr.sal_low
(id number, name varchar2(30), sal number)
TABLESPACE users;

CREATE TABLE hr.sal_mid
(id number, name varchar2(30), sal number)
TABLESPACE users;

CREATE TABLE hr.sal_high
(id number, name varchar2(30), sal number)
TABLESPACE users;

SELECT * FROM hr.sal_low;
SELECT * FROM hr.sal_mid;
SELECT * FROM hr.sal_high;

INSERT FIRST
WHEN salary < 5000 THEN
    INTO hr.sal_low(id,name,sal) VALUES(employee_id,last_name,salary)
WHEN salary BETWEEN 5000 AND 10000 THEN
    INTO hr.sal_mid(id,name,sal) VALUES(employee_id,last_name,salary)
ELSE
    INTO hr.sal_high(id,name,sal) VALUES(employee_id,last_name,salary)
SELECT employee_id, last_name, salary
FROM hr.employees;



CREATE TABLE hr.oltp_emp
AS
SELECT employee_id, last_name, salary, department_id
FROM hr.employees;

SELECT * FROM hr.oltp_emp;

CREATE TABLE hr.dw_emp
AS
SELECT employee_id, last_name, salary, department_id
FROM hr.employees
WHERE department_id = 20;

SELECT * FROM hr.dw_emp;

DESC hr.oltp_emp;

ALTER TABLE hr.oltp_emp ADD flag char(1);


SELECT * FROM hr.oltp_emp;

SELECT * FROM hr.oltp_emp WHERE employee_id IN (201,202);

UPDATE hr.oltp_emp
SET flag = 'd'
WHERE employee_id = 202;

UPDATE hr.oltp_emp
SET salary = 20000
WHERE employee_id = 201;

COMMIT;

SELECT * FROM hr.oltp_emp WHERE employee_id IN (201,202);


SELECT * FROM hr.oltp_emp;
SELECT * FROM hr.dw_emp;


SELECT
    o.*
FROM hr.dw_emp e, hr.oltp_emp o
WHERE e.employee_id = o.employee_id;

UPDATE hr.dw_emp d
SET salary  = (SELECT salary * 1.1
                    FROM hr.oltp_emp o
                    WHERE d.employee_id = o.employee_id);

DELETE
FROM hr.dw_emp d
WHERE EXISTS(
    SELECT *
    FROM hr.oltp_emp o
    WHERE o.employee_id = d.employee_id
    AND o.flag = 'd');

ROLLBACK;

INSERT INTO dw_emp
SELECT o.employee_id, o.last_name, o.salary, o.department_id
FROM hr.oltp_emp o
WHERE NOT EXISTS(SELECT e.employee_id
                 FROM hr.dw_emp e
                 WHERE e.employee_id = o.employee_id);
                 
SELECT * FROM hr.oltp_emp;
SELECT * FROM hr.dw_emp;

rollback;