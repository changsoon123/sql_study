merge into 
using
on ()
when matched then
    update set
        
    delete where
when not matched then
    insert()
    values();
    
alter table ~~ set unused column ~~;

select * from user_unused_col_tabs;


ALTER TABLE hr.emp DROP UNUSED COLUMNS;

alter table ~~ add constraint emp_id_pk primary key(id);


select * from user_constraints where table_name = 'EMPLOYEES';

select * from user_cons_columns;

ALTER TABLE emp
  DROP PRIMARY KEY KEEP INDEX;
  
alter table ~~ add constraint emp~~~
foreign key() references ~~();

CREATE TABLE hr.emp_target
( id number,
name varchar2(30),
day timestamp default systimestamp,
sal number )
TABLESPACE users;

CREATE TABLE hr.emp_source
( id number,
name varchar2(30),
day timestamp default systimestamp,
sal number )
TABLESPACE users;

CREATE OR REPLACE TRIGGER emp_copy_trigger
AFTER
INSERT OR DELETE OR UPDATE ON hr.emp_source
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO hr.emp_target(id,name,day,sal) 
        VALUES(:new.id, :new.name, :new.day, :new.sal);
    ELSIF UPDATING('sal') THEN
        UPDATE hr.emp_target
        SET sal = :new.sal
        WHERE id = :old.id;
    ELSIF UPDATING('name') THEN
        UPDATE hr.emp_target
        SET name = :new.name
        WHERE id = :old.id;
    ELSIF DELETING THEN
        DELETE FROM hr.emp_target WHERE id = :old.id;
    END IF;
END;
/

SELECT * FROM hr.emp_source;
DELETE FROM hr.emp_source;
DELETE FROM hr.emp_target;

INSERT INTO hr.emp_source(id,name,day,sal) VALUES(100,'ORA1',DEFAULT, 1000);

INSERT INTO hr.emp_target(id,name,day,sal) VALUES(100,'ORA1',DEFAULT, 1000);

SELECT * FROM hr.emp_target;

rollback;

UPDATE hr.emp_source
SET sal = 2000
WHERE id = 100;

UPDATE hr.emp_source
SET name = 'ORACLE'
WHERE id = 100;

DELETE FROM hr.emp_source WHERE id = 100;

CREATE TABLE hr.audit_emp_sal
(name varchar2(30),
day timestamp,
id number,
old_sal number,
new_sal number)
TABLESPACE users;

DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT employee_id id, salary sal, job_id job, department_id dept_id
FROM hr.employees;

CREATE OR REPLACE PROCEDURE hr.update_proc(p_id IN number)
IS
BEGIN
    UPDATE hr.emp
    SET sal = sal * 1.1
    WHERE id = p_id;
END update_proc;
/

SELECT * FROM hr.emp;

SELECT sal FROM hr.emp WHERE id = 200;

EXECUTE hr.update_proc(200);

SELECT sal FROM hr.emp WHERE id = 200;

ROLLBACK;

CREATE OR REPLACE TRIGGER hr.emp_sal_audit
AFTER
UPDATE OF sal ON hr.emp
FOR EACH ROW
BEGIN
    IF :old.sal != :new.sal THEN
        INSERT INTO hr.audit_emp_sal(name, day, id, old_sal, new_sal)
        VALUES(user,systimestamp, :new.id, :old.sal, :new.sal);
    END IF;
END;
/

ROLLBACK;

DELETE FROM hr.emp_sal;

select * from hr.audit_emp_sal;

update hr.emp set sal = 2000 where id = 200;

select sal from hr.emp where id = 200;

GRANT execute ON hr.update_proc TO anna;


DROP TABLE hr.emp PURGE;

CREATE TABLE hr.emp
AS
SELECT employee_id id, salary sal, department_id dept_id
FROM hr.employees;

DROP TABLE hr.dept PURGE;

CREATE TABLE hr.dept
AS
SELECT d.department_id dept_id, d.department_name dept_name, sum(e.salary) total_sal
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_id, d.department_name;

SELECT * FROM hr.emp;
SELECT * FROM hr.dept;

CREATE OR REPLACE VIEW hr.emp_details
AS
SELECT e.id, e.sal, e.dept_id, d.dept_name, d.total_sal
FROM hr.emp e, hr.dept d
WHERE e.dept_id = d.dept_id;

desc hr.emp_details;

INSERT INTO hr.emp_details(id,sal,dept_id,dept_name)
VALUES(300,2000, 60,'IT');

INSERT INTO hr.emp_emp(id,sal,dept_id)
VALUES(300,2000, 60);

UPDATE hr.dept
SET total_sal = total_sal + 2000
WHERE dept_id = 60;

select * from hr.emp;
select * from hr.dept;

CREATE OR REPLACE TRIGGER hr.emp_details_trigger
INSTEAD OF
INSERT OR UPDATE OR DELETE ON hr.emp_details
FOR EACH ROW
BEGIN
      IF INSERTING THEN        
            INSERT INTO hr.emp(id,sal,dept_id)
            VALUES(:new.id,:new.sal,:new.dept_id);
            
            UPDATE hr.dept
            SET total_sal = total_sal + :new.sal
            WHERE dept_id = :new.dept_id;
      ELSIF UPDATING('sal') THEN
            UPDATE hr.emp
            SET sal = :new.sal
            WHERE id = :old.id;
            
            UPDATE hr.dept
            SET total_sal = total_sal + (:new.sal - :old.sal)
            WHERE dept_id = :old.dept_id;
      
      END IF;
END emp_details_trigger;
/

select * from hr.emp_details WHERE id = 200;

UPDATE hr.emp_details
SET sal = 2000
WHERE id = 200;

UPDATE hr.emp
SET sal = 2000
WHERE id = 200;

UPDATE hr.dept
SET total_sal = total_sal + (2000 - 4000)
WHERE dept_id = 10;

select * from hr.emp_details WHERE id = 200;
SELECT * FROM hr.emp WHERE id = 200;
SELECT * FROM hr.dept WHERE dept_id = 10;

rollback;
desc hr.emp;

CREATE OR REPLACE TRIGGER hr.emp_details_trigger
INSTEAD OF
INSERT OR UPDATE OR DELETE ON hr.emp_details
FOR EACH ROW
BEGIN
      IF INSERTING THEN        
            INSERT INTO hr.emp(id,sal,dept_id)
            VALUES(:new.id,:new.sal,:new.dept_id);
            
            UPDATE hr.dept
            SET total_sal = total_sal + :new.sal
            WHERE dept_id = :new.dept_id;
      ELSIF UPDATING('sal') THEN
            UPDATE hr.emp
            SET sal = :new.sal
            WHERE id = :old.id;
            
            UPDATE hr.dept
            SET total_sal = total_sal + (:new.sal - :old.sal)
            WHERE dept_id = :old.dept_id;
            
      ELSIF UPDATING('dept_id') THEN
            UPDATE hr.emp
            SET dept_id = :new.dept_id
            WHERE id = :old.id;
            
            UPDATE hr.dept
            SET total_sal = total_sal - :old.sal
            WHERE dept_id = :old.dept_id;
            
            UPDATE hr.dept
            SET total_sal = total_sal + :new.sal
            WHERE dept_id = :new.dept_id;
            
        ELSIF DELETING THEN
      
            DELETE FROM hr.emp WHERE id = :old.id;
                                                          
            UPDATE hr.dept
            SET total_sal = total_sal - :old.sal
            WHERE dept_id = :old.dept_id;
            
      END IF;
END emp_details_trigger;
/

rollback;

UPDATE hr.emp_details
SET dept_id = 20
WHERE id = 200;

UPDATE hr.emp
SET dept_id = 20
WHERE id = 200;

UPDATE hr.dept
SET total_sal = total_sal - 4400
WHERE dept_id = 10;

UPDATE hr.dept
SET total_sal = total_sal + 4400
WHERE dept_id = 20;


UPDATE hr.emp_details
SET dept_id = 20
WHERE id = 200;

select * from hr.emp_details;
select * from hr.emp_details WHERE id = 200;
SELECT * FROM hr.emp WHERE id = 200;
SELECT * FROM hr.dept WHERE dept_id = 10;
SELECT * FROM hr.dept WHERE dept_id = 20;

DELETE FROM hr.emp_details WHERE id = 200;

GRANT SELECT,INSERT,UPDATE,DELETE ON hr.emp_details TO anna;

DROP TABLE hr.dept PURGE;

DROP TABLE hr.emp PURGE;

TRUNCATE TABLE hr.dept;

CREATE TABLE hr.emp AS SELECT * FROM hr.employees;

CREATE TABLE hr.emp AS SELECT * FROM hr.employees;

TRUNCATE TABLE hr.emp;

DROP TABLE hr.emp;

CREATE TABLE hr.emp
AS
SELECT * FROM hr.employees;

ALTER TABLE hr.emp MODIFY last_name varchar2(50);

ALTER TABLE hr.emp DROP COLUMN first_name;

ALTER TABLE hr.emp ADD first_name varchar2(30);

TRUNCATE TABLE hr.emp;

DROP TABLE hr.emp PURGE;

PURGE RECYCLEBIN;