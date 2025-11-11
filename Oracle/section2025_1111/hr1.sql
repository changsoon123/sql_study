

DECLARE
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = 300;
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('인출된 데이터가 없습니다.');    
    WHEN too_many_rows THEN
        dbms_output.put_line('여러행이 인출되었습니다.');    

END;
/

DECLARE
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE department_id = 20;
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('인출된 데이터가 없습니다.');    
    WHEN others THEN
        dbms_output.put_line('프로그램 종료.');    

END;
/

DROP TABLE hr.test PURGE;
CREATE TABLE hr.test(id number, name varchar2(30));
INSERT INTO hr.test(id,name) VALUES(1,'ORACLE');
COMMIT;


DECLARE
    v_rec employees%rowtype;
BEGIN
    DELETE FROM hr.test WHERE id = 1;
    
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE department_id = 20; -- ORA-01422
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name); 

EXCEPTION
    WHEN too_many_rows THEN
        dbms_output.put_line('여러행이 인출되었습니다.');

END;
/

SELECT * FROM hr.test;

rollback;

DECLARE
    v_rec employees%rowtype;
BEGIN
    
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE department_id = 20; 
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name); 

EXCEPTION
    WHEN others THEN
        dbms_output.put_line('오류가 발생해서 프로그램 종료.');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);

END;
/

SELECT * FROM user_constraints WHERE table_name IN ('EMPLOYEES','DEPARTMENTS');
SELECT * FROM user_cons_columns WHERE table_name IN ('EMPLOYEES','DEPARTMENTS');


BEGIN
    DELETE FROM hr.departments WHERE department_id = 10;
    
EXCEPTION
    WHEN others THEN
        dbms_output.put_line('오류가 발생해서 프로그램 종료.');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;
/

DECLARE
    pk_error EXCEPTION; -- 예외사항 이름 선언
    PRAGMA EXCEPTION_INIT(pk_error, -2292); -- 내가 만든 예외사항 이름과 오라클 오류번호를 연결하는 지시어

BEGIN
    DELETE FROM hr.departments WHERE department_id = 10;
    
EXCEPTION
    WHEN pk_error THEN
        dbms_output.put_line('PK값을 참조하고 있는 자식 행들이 있습니다.');
    WHEN others THEN
        dbms_output.put_line('오류가 발생해서 프로그램 종료.');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;
/

UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = 300;

DECLARE
    e_invalid EXCEPTION; -- 예외사항 이름 선언

BEGIN

    UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = 300;
    
    IF sql%notfound THEN
        RAISE e_invalid; --유저가 정의한 예외사항 발생
    END IF;

EXCEPTION
    WHEN e_invalid THEN
        dbms_output.put_line('수정된 데이터가 없습니다.');
        dbms_output.put_line(sqlcode);
        dbms_output.put_line(sqlerrm);
END;
/

BEGIN

    UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = 300;
    
    IF sql%notfound THEN
        RAISE_APPLICATION_ERROR(-20000, '수정된 데이터가 없습니다.');
    END IF;

END;
/

DECLARE
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = 300;
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20000, '사원은 존재하지 않습니다.',FALSE);
    
END;
/

DECLARE
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = 300;
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20000, '사원은 존재하지 않습니다.',TRUE);
    
END;
/

        SELECT employee_id, last_name 
        FROM hr.employees
        WHERE employee_id = 100;

DECLARE
    
    TYPE v_rec_type IS TABLE OF number;
    v_rec v_rec_type := v_rec_type(100,300,102,105);
    
    TYPE v_ta_type IS RECORD(
        id number,
        name varchar2(30)
    );
    
    v_ta v_ta_type;
    
BEGIN
    FOR i IN v_rec.first..v_rec.last LOOP
        BEGIN
            SELECT employee_id, last_name 
            INTO v_ta.id, v_ta.name
            FROM hr.employees
            WHERE employee_id = v_rec(i);
            
            dbms_output.put_line(v_ta.id || ' ' || v_ta.name);
            
            EXCEPTION
            WHEN no_data_found THEN
                DBMS_OUTPUT.PUT_LINE( v_rec(i) ||'사원은 존재하지 않습니다.');
    
        END;
        
    END LOOP;
    
        
END;    
/

CREATE OR REPLACE PROCEDURE emp_proc
IS
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20000, '사원은 존재하지 않습니다.',TRUE);
    
END;
/

SELECT * FROM session_privs;

show error;

execute emp_proc;

BEGIN
    emp_proc;
END;
/

CREATE OR REPLACE PROCEDURE emp_proc
(p_id IN number)
IS
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = p_id;
    
    dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);

EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20000, '사원은 존재하지 않습니다.',TRUE);
    
END;
/

commit;

show error;

execute emp_proc(100);

BEGIN
    emp_proc(100);
END;
/

SELECT text FROM user_source WHERE name = 'EMP_PROC' ORDER BY line;

CREATE OR REPLACE PROCEDURE raise_salary
(p_id IN number,
p_percent IN number)
IS
BEGIN
    UPDATE hr.employees
    SET salary = salary * (1 + p_percent/100)
    WHERE employee_id = p_id;
END raise_salary;
/

rollback;
exec raise_salary(100,10);

select salary from hr.employees WHERE employee_id = 100;

BEGIN
    FOR v_rec IN (SELECT employee_id FROM hr.employees) LOOP
            raise_salary(v_rec.employee_id,10);
    END LOOP;
END;
/

rollback;



CREATE OR REPLACE PROCEDURE emp_proc
(p_id IN number,
p_name OUT varchar2,
p_sal OUT number)
IS
BEGIN
    SELECT last_name, salary
    INTO p_name, p_sal
    FROM hr.employees
    WHERE employee_id = p_id;
    
EXCEPTION
    WHEN no_data_found THEN
        RAISE_APPLICATION_ERROR(-20000, '사원은 존재하지 않습니다.',TRUE);
    
END emp_proc;
/

desc emp_proc;

DECLARE
    v_name varchar2(30);
    v_sal number;
BEGIN
    emp_proc(100,v_name,v_sal);
    dbms_output.put_line(v_name || ' ' || v_sal);
END;
/

SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME IN ('EMPLOYEES','DEPARTMENTS');
SELECT * FROM USER_CONS_COLUMNS WHERE TABLE_NAME IN ('EMPLOYEES','DEPARTMENTS');

