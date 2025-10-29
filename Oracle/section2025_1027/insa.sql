show user

SELECT * FROM user_tab_privs;

SELECT * FROM hr.employees;

SELECT * FROM hr.departments;

INSERT INTO 소유자, 테이블(컬럼, 컬럼,....)
VALUES(데이터,데이터,....);

SELECT * FROM user_objects;

DESC insa.emp;

SELECT * FROM user_tab_columns WHERE table_name = 'EMP';

INSERT INTO insa.emp(id,name,day)
VALUES(1,'liam',to_date('2025-10-29','yyyy-mm-dd'));

INSERT INTO insa.emp(id,name,day)
VALUES(2,'NOAH',sysdate);

SELECT * FROM insa.emp;

ROLLBACK;
COMMIT;

INSERT INTO insa.emp(id,name,day)
VALUES(3,'james',to_date('2025-10-01','yyyy-mm-dd'));

INSERT INTO insa.emp(id,name,day)
VALUES(4,'henry',to_date('2025-11-01','yyyy-mm-dd'));

SELECT * FROM insa.emp;

SELECT * FROM user_tab_columns WHERE table_name = 'EMP';

INSERT INTO insa.emp(id,name)
VALUES(3,'james');

INSERT INTO insa.emp(id,name,day)
VALUES(4,'henry',default);

INSERT INTO insa.emp(id,name,day)
VALUES(5,default,default);

INSERT INTO insa.emp(id,name,day)
VALUES(6,'khai',null);

SELECT * FROM insa.emp;

ROLLBACK;
SELECT * FROM insa.emp;

UPDATE insa.emp
SET day = to_date('2025-01-01' , 'yyyy-mm-dd');

SELECT * FROM insa.emp;

UPDATE insa.emp
SET day = to_date('2025-02-01' , 'yyyy-mm-dd')
WHERE id = 2;

COMMIT;

SELECT * FROM insa.emp;

UPDATE insa.emp
SET day = default
WHERE id = 2;

UPDATE insa.emp
SET day = null
WHERE id = 2;

DELETE FROM insa.emp;

SELECT * FROM insa.emp;

ROLLBACK;

DELETE FROM insa.emp WHERE id = 1;
commit;
SELECT * FROM insa.emp;

DROP TABLE insa.emp PURGE;

