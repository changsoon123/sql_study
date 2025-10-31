
SELECT * FROM user_tables;
SELECT * FROM user_tab_privs;

SELECT * FROM user_objects WHERE object_name = 'EMP_VIEW';

SELECT * FROM all_objects WHERE object_name = 'EMP_VIEW';

SELECT * FROM user_views WHERE view_name = 'EMP_VIEW';

SELECT * FROM all_views WHERE view_name = 'EMP_VIEW';



SELECT employee_id, last_name, department_id
FROM hr.emp_view;

SELECT * FROM hr.emp_view;
SELECT * FROM user_tab_privs;

SELECT * FROM hr.emp_view;

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

DELETE FROM hr.emp_view WHERE id = 300;

SELECT * FROM hr.emp_view WHERE id = 101;
SELECT * FROM hr.emp WHERE id = 101;

SELECT * FROM hr.emp_view WHERE id = 100;
SELECT * FROM hr.emp_view WHERE id = 300;
SELECT * FROM hr.emp_view WHERE id = 101;

COMMIT;

DESC hr.emp_view;

CREATE OR REPLACE VIEW hr.emp_view
AS
SELECT id, dept_id
FROM hr.emp;

GRANT DELETE ON hr.emp_view TO insa;

SELECT * FROM user_tab_privs;
SELECT * FROM hr.emp_view;

desc hr.emp_view;

INSERT INTO hr.emp_view(id,name,dept_id) VALUES(400,'james',20);

UPDATE hr.emp_view
SET dept_id = 10
WHERE id = 100;

DELETE FROM hr.emp_view WHERE id = 300;

UPDATE hr.emp_view
SET dept_id = 10
WHERE id = 100;

DELETE FROM hr.emp_view WHERE id = 100;

UPDATE hr.emp_view
SET name = 'my name is KING'
WHERE id = 102;

SELECT * FROM hr.emp_view;

INSERT INTO hr.emp_view(id,name,dept_id) VALUES(500,'liam',20);

SELECT * FROM hr.emp_view;

rollback;

UPDATE hr.emp_view
SET dept_id = 20
WHERE id = 201;

DELETE FROM hr.emp_view WHERE id = 201;