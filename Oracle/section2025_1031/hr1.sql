INSERT INTO hr.dept(id,dept_name)
SELECT department_id, department_name
FROM hr.departments;

COMMIT;

ALTER TABLE hr.emp DROP CONSTRAINT emp_sal_ck;
ALTER TABLE hr.emp DROP CONSTRAINT emp_name_uk;

INSERT INTO hr.emp(emp_id,name,sal,dept_id)
SELECT employee_id, last_name, salary, department_id
FROM hr.employees;

COMMIT;

SELECT * FROM hr.emp;
SELECT * FROM hr.dept;

SELECT * FROM user_indexes WHERE table_name IN ('DEPT','EMP');
SELECT * FROM user_ind_columns WHERE table_name IN ('DEPT','EMP');
SELECT * FROM user_constraints WHERE table_name IN ('DEPT','EMP');
SELECT * FROM user_cons_columns WHERE table_name IN ('DEPT','EMP');

SELECT * FROM hr.dept;

ALTER TABLE hr.dept RENAME COLUMN id TO dept_id;

show recyclebin

SELECT * FROM user_recyclebin;

purge recyclebin;

SELECT * FROM user_recyclebin;

SELECT * FROM hr.emp;
SELECT * FROM user_indexes WHERE table_name IN ('DEPT','EMP_NEW');
SELECT * FROM user_ind_columns WHERE table_name IN ('DEPT','EMP_NEW');
SELECT * FROM user_constraints WHERE table_name IN ('DEPT','EMP_NEW');
SELECT * FROM user_cons_columns WHERE table_name IN ('DEPT','EMP_NEW');

DROP TABLE hr.emp;

SELECT * FROM user_recyclebin;
SELECT * FROM hr.emp;

SELECT * FROM "BIN$Tzo9dFBlQRSOG3pjwUhe0w==$0";

FLASHBACK TABLE emp TO BEFORE DROP;

CREATE TABLE hr.emp
AS SELECT * FROM hr.employees;

FLASHBACK TABLE emp TO BEFORE DROP RENAME TO emp_new;

SELECT * FROM hr.emp_new;

DROP TABLE hr.dept;
DROP TABLE hr.emp;
DROP TABLE hr.emp_new PURGE;

SELECT * FROM user_recyclebin;

PURGE TABLE EMP;

PURGE RECYCLEBIN;

CREATE TABLE hr.emp
TABLESPACE  users
AS
SELECT * FROM hr.employees;

SELECT * FROM hr.emp;

SELECT * FROM user_tables WHERE table_name = 'EMP';
SELECT * FROM user_segments WHERE segment_name = 'EMP';
SELECT * FROM user_extents WHERE segment_name = 'EMP';

INSERT INTO hr.emp
SELECT * FROM hr.employees;

COMMIT;

SELECT count(*) FROM hr.emp;

DELETE FROM hr.emp;

COMMIT;

TRUNCATE TABLE hr.emp;

COMMENT ON TABLE hr.emp IS '사원 정보 테이블';
SELECT * FROM user_tab_comments WHERE table_name = 'EMP';

SELECT * FROM user_col_comments WHERE table_name = 'EMP';

COMMENT ON COLUMN hr.emp.employee_id IS '사원 정보 테이블';
COMMENT ON COLUMN hr.emp.salary IS '사원 급여';

SELECT * FROM user_col_comments WHERE table_name = 'EMP';

desc hr.emp;

COMMENT ON TABLE hr.emp IS '';
COMMENT ON COLUMN hr.emp.employee_id IS '';
COMMENT ON COLUMN hr.emp.salary IS '';
SELECT * FROM user_tab_comments WHERE table_name = 'EMP';
SELECT * FROM user_col_comments WHERE table_name = 'EMP';

SELECT *
FROM hr.employees;

GRANT SELECT ON hr.employees TO insa;

SELECT * FROM user_tab_privs;

REVOKE SELECT ON hr.employees FROM insa;

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
TABLESPACE users
AS
SELECT employee_id, last_name, department_id
FROM hr.employees;

GRANT SELECT ON hr.emp TO insa;

DROP TABLE hr.emp PURGE;

CREATE VIEW hr.emp_view
AS
SELECT employee_id, last_name, department_id
FROM hr.employees;

SELECT * FROM hr.emp_view;

SELECT * FROM user_objects WHERE object_name = 'EMP_VIEW';
SELECT * FROM user_tables WHERE table_name = 'EMP_VIEW';
SELECT * FROM user_segments WHERE segment_name = 'EMP_VIEW';
SELECT * FROM user_views WHERE view_name = 'EMP_VIEW';

GRANT SELECT ON hr.emp_view TO insa;

SELECT * FROM user_sys_privs;
SELECT * FROM role_sys_privs;

SELECT * FROM session_privs;

DROP VIEW hr.emp_view;

CREATE VIEW hr.emp_view
AS
SELECT employee_id, last_name, department_id
FROM hr.employees;

CREATE OR REPLACE VIEW hr.emp_view
AS
SELECT employee_id, last_name || ' ' || first_name as "name", department_id
FROM hr.employees;

DESC hr.emp_view;

SELECT * FROM hr.emp_view;

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT employee_id as id, last_name as name, salary, department_id as dept_id
FROM hr.employees;

SELECT * FROM hr.emp;
DROP VIEW hr.emp_view;
GRANT SELECT ON hr.emp TO insa;
REVOKE SELECT ON hr.emp FROM insa;

CREATE VIEW hr.emp_view
AS
SELECT id, name, dept_id
FROM hr.emp;

SELECT * FROM hr.emp_view;

GRANT SELECT ON hr.emp_view TO insa;

SELECT * FROM user_tab_privs;

CREATE VIEW hr.emp_view
AS
SELECT id, name, dept_id
FROM hr.emp
WHERE dept_id = 20;

GRANT SELECT ON hr.emp_view TO insa;

CREATE OR REPLACE VIEW hr.emp_view
AS
SELECT id, name, dept_id
FROM hr.emp;

SELECT * FROM user_tab_privs;

SELECT * FROM hr.emp_view;

INSERT INTO hr.emp_view(id,name,dept_id) VALUES(300,'ORACLE',10);

SELECT * FROM hr.emp;

rollback;

SELECT * FROM hr.emp_view WHERE id = 101;

UPDATE hr.emp_view
SET dept_id = 10
WHERE id = 100;

DELETE FROM hr.emp_view WHERE id = 101;

SELECT * FROM hr.emp_view WHERE id = 101;
SELECT * FROM hr.emp WHERE id = 101;

GRANT INSERT, UPDATE, DELETE ON hr.emp_view TO insa;

SELECT * FROM user_tab_privs;

SELECT * FROM hr.emp WHERE id = 100;
SELECT * FROM hr.emp WHERE id = 300;
SELECT * FROM hr.emp WHERE id = 101;

desc hr.emp_view;

REVOKE DELETE ON hr.emp_view FROM insa;


CREATE OR REPLACE VIEW hr.emp_view
AS
SELECT id, 'my name is ' || name name,dept_id
FROM hr.emp;

GRANT DELETE ON hr.emp_view TO insa;

SELECT * FROM user_tab_privs;

desc hr.emp_view;


CREATE OR REPLACE VIEW hr.emp_view
AS
SELECT id, name, dept_id
FROM hr.emp
WHERE dept_id = 20
WITH CHECK OPTION CONSTRAINT emp_view_ck;

SELECT * FROM hr.emp_view;
SELECT * FROM user_constraints WHERE table_name = 'EMP_VIEW';

CREATE OR REPLACE VIEW hr.emp_view
AS
SELECT id, name, dept_id
FROM hr.emp
WITH READ ONLY;

SELECT * FROM user_tab_privs;

desc hr.emp_view;