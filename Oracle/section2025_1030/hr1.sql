
MERGE INTO hr.dw_emp d
USING hr.oltp_emp o
ON (d.employee_id = o.employee_id)
WHEN MATCHED THEN
    UPDATE SET
        d.salary = o.salary * 1.1
        DELETE WHERE o.flag = 'd'
WHEN NOT MATCHED THEN
    INSERT(d.employee_id,d.last_name,d.salary,d.department_id)
    VALUES(o.employee_id,o.last_name,o.salary,o.department_id);

SELECT * FROM hr.dw_emp;

ROLLBACK;

CREATE TABLE hr.emp_copy
AS
SELECT * FROM hr.employees;

ALTER TABLE hr.emp_copy ADD department_name varchar2(30);

UPDATE hr.emp_copy e
SET department_name = (
    SELECT d.department_name
    FROM hr.departments d
    WHERE d.department_id = e.department_id
    );

SELECT * FROM hr.emp_copy;

rollback;

MERGE INTO hr.emp_copy e
USING hr.departments d
ON (d.department_id = e.department_id)
WHEN MATCHED THEN
    UPDATE SET
        e.department_name = d.department_name;
    
DROP TABLE hr.emp PURGE;    

CREATE TABLE hr.emp
(id number, name varchar2(30), day date)
TABLESPACE users;

SELECT * FROM user_tables WHERE table_name = 'EMP';
SELECT * FROM user_tab_columns WHERE table_name = 'EMP';

DESC hr.emp

ALTER TABLE hr.emp ADD job_id varchar2(20);
ALTER TABLE hr.emp ADD dept_id varchar2(20);

SELECT * FROM user_tab_columns WHERE table_name = 'EMP';

DESC hr.emp

ALTER TABLE hr.emp MODIFY job_id varchar2(30);

ALTER TABLE hr.emp MODIFY dept_id varchar2(30);

SELECT * FROM hr.emp;

SELECT * FROM user_tab_columns WHERE table_name = 'EMP';

ALTER TABLE hr.emp DROP COLUMN job_id;

ALTER TABLE hr.emp SET UNUSED COLUMN dept_id;

DESC hr.emp;

SELECT * FROM hr.emp;

SELECT * FROM user_unused_col_tabs;

ALTER TABLE hr.emp DROP UNUSED COLUMNS;

INSERT INTO hr.emp(id,name,day) VALUES(1, 'james', sysdate);
INSERT INTO hr.emp(id,name,day) VALUES(1, 'noah', sysdate);
INSERT INTO hr.emp(id,name,day) VALUES(null, 'liam', sysdate);

SELECT * FROM hr.emp;

ROLLBACK;

SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';
SELECT * FROM user_cons_columns WHERE table_name = 'EMPLOYEES';

ALTER TABLE hr.emp ADD CONSTRAINT emp_id_pk PRIMARY KEY(id);

SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP';

SELECT * FROM user_indexes WHERE table_name = 'EMP';
SELECT * FROM user_ind_columns WHERE table_name = 'EMP';

SELECT * FROM dba_constraints WHERE owner = 'HR' and table_name = 'EMP';
SELECT * FROM dba_cons_columns WHERE owner = 'HR' and table_name = 'EMP';

SELECT * FROM dba_indexes WHERE owner = 'HR' and table_name = 'EMP';
SELECT * FROM dba_ind_columns WHERE index_owner = 'HR' and table_name = 'EMP';

ROLLBACK;

ALTER TABLE hr.emp DROP CONSTRAINT emp_id_pk;
SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_indexes WHERE table_name = 'EMP';

ALTER TABLE hr.emp ADD PRIMARY KEY(id);

ALTER TABLE hr.emp DROP PRIMARY KEY;

ALTER TABLE hr.emp ADD CONSTRAINT emp_id_pk PRIMARY KEY(id);
SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_indexes WHERE table_name = 'EMP';

CREATE TABLE hr.dept(dept_id number, dept_name varchar2(30)) TABLESPACE USERS;
ALTER TABLE hr.dept ADD CONSTRAINT dept_pk PRIMARY KEY(dept_id);

SELECT * FROM user_constraints WHERE table_name = 'DEPT';
SELECT * FROM user_indexes WHERE table_name = 'DEPT';

INSERT INTO hr.dept(dept_id, dept_name) VALUES(10,'인사');
INSERT INTO hr.dept(dept_id, dept_name) VALUES(20,'영업');
COMMIT;
SELECT * FROM hr.dept;

ALTER TABLE hr.emp ADD dept_id number;

DESC hr.dept;

INSERT INTO hr.emp(id,name,day,dept_id) VALUES(1,'noah',sysdate,10);
INSERT INTO hr.emp(id,name,day,dept_id) VALUES(2,'liam',sysdate,30);
COMMIT;
SELECT * FROM hr.emp;

SELECT e.*, d.*
FROM hr.emp e, hr.dept d
WHERE e.dept_id = d.dept_id;

SELECT e.*, d.*
FROM hr.emp e, hr.dept d
WHERE e.dept_id = d.dept_id(+);

DELETE FROM hr.emp;
COMMIT;
SELECT * FROM hr.emp;

ALTER TABLE hr.emp ADD CONSTRAINT emp_dept_id_fk
FOREIGN KEY(dept_id) REFERENCES hr.dept(dept_id);

SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');

INSERT INTO hr.emp(id,name,day,dept_id) VALUES(1,'noah',sysdate,10);
COMMIT;
SELECT * FROM hr.emp;
SELECT * FROM hr.dept;

INSERT INTO hr.emp(id,name,day,dept_id) VALUES(2,'liam',sysdate,30);

SELECT * FROM hr.dept;

DELETE FROM hr.dept WHERE dept_id = 10;
DELETE FROM hr.dept WHERE dept_id = 20;
rollback;

DROP TABLE hr.dept PURGE;
SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');

DROP TABLE hr.dept CASCADE CONSTRAINTS PURGE;

ALTER TABLE hr.dept DROP PRIMARY KEY;

ALTER TABLE hr.emp DROP CONSTRAINT emp_dept_id_fk;
ALTER TABLE hr.dept DROP PRIMARY KEY;

ALTER TABLE hr.dept DROP PRIMARY KEY CASCADE;
SELECT * FROM user_constraints WHERE table_name IN ('DEPT','EMP');

SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');

ALTER TABLE hr.dept ADD CONSTRAINT dept_name_uk UNIQUE(dept_name);

SELECT * FROM hr.dept;

INSERT INTO hr.dept(dept_id, dept_name) VALUES(30,'영업');
INSERT INTO hr.dept(dept_id, dept_name) VALUES(30,null);
rollback;

ALTER TABLE hr.dept DROP UNIQUE(dept_name);

SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_ind_columns WHERE table_name IN('DEPT','EMP');

ALTER TABLE hr.emp ADD sal number;
DESC hr.emp;

ALTER TABLE hr.emp ADD CONSTRAINT emp_sal_ck CHECK(sal >= 1000 AND sal <=2000);

SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_ind_columns WHERE table_name IN('DEPT','EMP');

DESC hr.emp;
INSERT INTO hr.emp(id, name, day, dept_id, sal) VALUES(2, 'james', sysdate, 20,500);

INSERT INTO hr.emp(id, name, day, dept_id, sal) VALUES(2, 'james', sysdate, 20, 1500);

commit;
SELECT * FROM hr.emp;

UPDATE hr.emp
SET sal = 200
WHERE id = 1;

INSERT INTO hr.emp(id, name, day, dept_id, sal) VALUES(3, 'james', sysdate, 10, null);

ALTER TABLE hr.emp DROP CONSTRAINT emp_sal_ck;

DESC hr.emp;

ALTER TABLE hr.emp MODIFY name CONSTRAINT emp_name_nn NOT NULL;

SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_ind_columns WHERE table_name IN('DEPT','EMP');

INSERT INTO hr.emp(id, name, day, dept_id, sal) VALUES(3, NULL , sysdate, 10, 2000);


ALTER TABLE hr.emp MODIFY name NULL;
DESC hr.emp;

DROP TABLE hr.emp CASCADE CONSTRAINTS PURGE;
DROP TABLE hr.dept CASCADE CONSTRAINTS PURGE;

CREATE TABLE hr.dept(
	id number CONSTRAINT dept_pk PRIMARY KEY, -- 열 레벨 정의
	dept_name varchar2(30))   
TABLESPACE users;

CREATE TABLE hr.emp(
	id number CONSTRAINT emp_id_pk PRIMARY KEY, -- 열 레벨 정의
	name varchar2(30) CONSTRAINT emp_name_nn NOT NULL,  -- 열 레벨 정의
	sal number,
	dept_id number CONSTRAINT emp_dept_id_fk REFERENCES hr.dept(id), -- 열 레벨 정의
	CONSTRAINT emp_name_uk UNIQUE(name), -- 테이블 레벨 정의
	CONSTRAINT emp_sal_ck CHECK(sal BETWEEN 1000 AND 2000)) 
TABLESPACE users;

SELECT * FROM user_constraints WHERE table_name IN ('DEPT','EMP');

DROP TABLE hr.emp CASCADE CONSTRAINTS PURGE;

CREATE TABLE hr.emp(
    id number,
	name varchar2(30) CONSTRAINT emp_name_nn NOT NULL,  -- 열 레벨 정의
	sal number,
	dept_id number,
    CONSTRAINT emp_id_pk PRIMARY KEY(id), -- 테이블 레벨 정의
    CONSTRAINT emp_dept_id_fk FOREIGN KEY(dept_id) REFERENCES hr.dept(id), -- 테이블 레벨 정의
	CONSTRAINT emp_name_uk UNIQUE(name), -- 테이블 레벨 정의
	CONSTRAINT emp_sal_ck CHECK(sal BETWEEN 1000 AND 2000)) 
TABLESPACE users;

SELECT * FROM user_constraints WHERE table_name IN ('DEPT','EMP');

CREATE TABLE hr.emp(
    id number,
        name varchar2(30) 
        CONSTRAINT emp_name_nn NOT NULL
        CONSTRAINT emp_name_uk UNIQUE, -- UNIQUE 조건과 NOT NULL 조건을 같이 열 레벨로 정의
	sal number,
	dept_id number,
    CONSTRAINT emp_id_pk PRIMARY KEY(id), -- 테이블 레벨 정의
    CONSTRAINT emp_dept_id_fk FOREIGN KEY(dept_id) REFERENCES hr.dept(id), -- 테이블 레벨 정의
	
	CONSTRAINT emp_sal_ck CHECK(sal BETWEEN 1000 AND 2000)) 
TABLESPACE users;

SELECT * FROM hr.emp;

SELECT * FROM user_constraints WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_indexes WHERE table_name IN('DEPT','EMP');
SELECT * FROM user_ind_columns WHERE table_name IN('DEPT','EMP');

RENAME emp TO emp_new; --소유자 이름은 사용하지 말자.
SELECT * FROM hr.emp;

ALTER TABLE hr.emp_new RENAME TO emp;

DESC hr.emp;

ALTER TABLE hr.emp RENAME COLUMN id TO emp_id;

DESC hr.emp;

SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP';
SELECT * FROM user_indexes WHERE table_name = 'EMP';
SELECT * FROM user_ind_columns WHERE table_name = 'EMP';

ALTER TABLE hr.emp RENAME CONSTRAINT emp_id_pk TO emp_pk;

ALTER INDEX emp_id_pk RENAME TO emp_id_idx;