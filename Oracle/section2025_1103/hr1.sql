SELECT * FROM user_unused_col_tabs;

ALTER TABLE hr.emp DROP UNUSED COLUMNS;

SELECT * FROM user_constraints WHERE table_name = 'EMPLOYEES';

SELECT * FROM user_cons_columns WHERE table_name = 'EMPLOYEES';

SELECT * FROM user_indexes WHERE table_name = 'departments';
SELECT * FROM user_ind_columns WHERE table_name = 'departments';

SELECT * FROM session_privs;

CREATE SEQUENCE id_seq;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';

CREATE TABLE hr.seq_test(id number, name varchar2(30), day timestamp) TABLESPACE users;

INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'liam', localtimestamp);
COMMIT;

SELECT * FROM hr.seq_test;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';

INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'noah', localtimestamp);
COMMIT;

SELECT * FROM hr.seq_test;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';

INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'james', localtimestamp);
COMMIT;
INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'soon', localtimestamp);
ROLLBACK;
INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'call', localtimestamp);

SELECT * FROM hr.seq_test;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';

SELECT id_seq.currval FROM dual;

DROP SEQUENCE hr.id_seq;

CREATE SEQUENCE hr.id_seq
START WITH 1
MAXVALUE 3
INCREMENT BY 1
NOCYCLE
NOCACHE;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';
SELECT * FROM user_objects WHERE object_name = 'ID_SEQ';
SELECT id_seq.currval FROM dual;

TRUNCATE TABLE hr.seq_test;

SELECT * FROM hr.seq_test;

INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'liam', localtimestamp);
COMMIT;

INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'noah', localtimestamp);
COMMIT;
INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'james', localtimestamp);
COMMIT;
INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'soon', localtimestamp);
ROLLBACK;
INSERT INTO hr.seq_test(id,name,day)
VALUES(id_seq.nextval, 'call', localtimestamp);

COMMIT;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';

ALTER SEQUENCE hr.id_seq
INCREMENT BY 2
MAXVALUE 100
CACHE 20;

SELECT * FROM user_sequences WHERE sequence_name = 'ID_SEQ';

SELECT * FROM hr.seq_test;

GRANT SELECT, INSERT, UPDATE, DELETE ON hr.seq_test TO insa;
GRANT SELECT ON hr.id_seq TO insa;
SELECT * FROM user_tab_privs;

REVOKE SELECT ON hr.id_seq FROM insa;

CREATE TABLE hr.emp_copy_2025
AS
SELECT * FROM hr.employees;

SELECT * FROM hr.emp_copy_2025;

CREATE SYNONYM ec FOR hr.emp_copy_2025;

SELECT * FROM ec;

SELECT * FROM user_synonyms WHERE table_name = 'EMP_COPY_2025';

GRANT SELECT ON hr.emp_copy_2025 TO insa;

DROP SYNONYM ec;

SELECT * FROM session_privs;

CREATE PUBLIC SYNONYM ec FOR hr.emp_copy_2025;

SELECT * FROM user_synonyms WHERE table_name = 'EMP_COPY_2025';

SELECT * FROM all_synonyms WHERE table_name = 'EMP_COPY_2025';

SELECT * FROM user_tab_privs;

REVOKE SELECT ON hr.emp_copy_2025 FROM insa;

DROP PUBLIC SYNONYM ec;

DROP TABLE hr.emp CASCADE CONSTRAINTS PURGE;

CREATE TABLE hr.emp
AS
SELECT * FROM hr.employees;

SELECT * FROM hr.emp WHERE employee_id = 100;

SELECT rowid, e.* FROM hr.emp e;
SELECT DATA_OBJECT_ID FROM user_objects WHERE object_name = 'EMP';
SELECT * FROM user_tables WHERE table_name = 'EMP';

SELECT rowid, e.* FROM hr.emp e;

SELECT * FROM hr.emp WHERE rowid = 'AAAE+EAAEAAAAFTAAA';

SELECT rowid, e.* FROM hr.emp e;
SELECT rowid, employee_id FROM hr.emp ORDER BY employee_id;
SELECT rowid, last_name FROM hr.emp ORDER BY last_name;

SELECT * FROM hr.emp WHERE employee_id = 100;

ALTER TABLE hr.emp ADD CONSTRAINT emp_id_pk PRIMARY KEY(employee_id);
SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP';
SELECT * FROM user_indexes WHERE table_name = 'EMP';
SELECT * FROM user_ind_columns WHERE table_name = 'EMP';

SELECT * FROM hr.emp WHERE employee_id = 100;

ALTER TABLE hr.emp DROP CONSTRAINT emp_id_pk;

CREATE INDEX hr.emp_idx
ON hr.emp(employee_id)
TABLESPACE users;

SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP';
SELECT * FROM user_indexes WHERE table_name = 'EMP';
SELECT * FROM user_ind_columns WHERE table_name = 'EMP';

SELECT * FROM hr.emp WHERE employee_id = 100;

DROP INDEX hr.emp_idx;

SELECT * FROM session_privs;

CREATE UNIQUE INDEX hr.emp_idx
ON hr.emp(employee_id)
TABLESPACE users;

SELECT * FROM user_constraints WHERE table_name = 'EMP';
SELECT * FROM user_cons_columns WHERE table_name = 'EMP';
SELECT * FROM user_indexes WHERE table_name = 'EMP';
SELECT * FROM user_ind_columns WHERE table_name = 'EMP';

SELECT * FROM hr.emp WHERE employee_id = 100;

ALTER TABLE hr.emp ADD CONSTRAINT emp_id_pk PRIMARY KEY(employee_id);

DROP INDEX hr.emp_idx;

ALTER TABLE hr.emp DROP PRIMARY KEY;

WITH
    dept_cnt AS (SELECT department_id, count(*) cnt
                 FROM hr.employees
                 GROUP BY department_id)
    SELECT d2.*
    FROM dept_cnt d1, hr.departments d2
    WHERE d1.department_id = d2.department_id
    AND d1.cnt = (SELECT max(cnt) FROM dept_cnt);
    
WITH
    dept_cost AS (SELECT d.department_name, e.sumsal
                    FROM (SELECT department_id, sum(salary) sumsal
                            FROM hr.employees
                            GROUP BY department_id) e, hr.departments d
                    WHERE e.department_id = d.department_id),
    avg_cost AS (SELECT sum(sumsal)/count(*) dept_avg
                    FROM dept_cost)
    SELECT *
        FROM dept_cost
        WHERE sumsal >(SELECT dept_avg FROM avg_cost);