SELECT
    employee_id,
    salary,
    commission_pct,
    salary * 12 + salary * 12 * commission_pct annual_salary_1,
    salary * 12 + salary * 12 * nvl(commission_pct,0) annual_salary_2,
    get_annual_sal(salary,commission_pct) annual_salary_3
FROM hr.employees;

CREATE OR REPLACE FUNCTION get_annual_sal
(p_sal IN number,
 p_pct IN number := 0)
RETURN number
IS
    v_sal number;
BEGIN
    v_sal := p_sal * 12 + p_sal * 12 * nvl(p_pct,0);
    RETURN v_sal;

EXCEPTION
    WHEN others THEN
        dbms_output.put_line('잘못 되었습니다.');
        RETURN v_sal;

END get_annual_sal;
/

select text FROM user_source WHERE name = 'GET_ANNUAL_SAL' ORDER BY line;

desc get_annual_sal;

SELECT
    employee_id,
    salary,
    commission_pct,
    salary * 12 + salary * 12 * commission_pct annual_salary_1,
    salary * 12 + salary * 12 * nvl(commission_pct,0) annual_salary_2,
    get_annual_sal(salary,commission_pct) annual_salary_3,
    get_annual_sal(p_sal=>salary,p_pct=>commission_pct) annual_salary_4,
    get_annual_sal(p_sal=>salary ) annual_salary_5,
    get_annual_sal(salary ) annual_salary_6    
FROM hr.employees;

CREATE OR REPLACE FUNCTION query_call(p_id IN number)
RETURN number
IS
    v_sal number;
BEGIN
    SELECT salary
    INTO v_sal
    FROM hr.employees
    WHERE employee_id = p_id;
    
    RETURN v_sal;
    
EXCEPTION
    WHEN no_data_found THEN
        RETURN v_sal;
    
END query_call;
/

execute dbms_output.put_line(query_call(100));

SELECT employee_id, query_call(employee_id) FROM hr.employees;

UPDATE hr.employees
SET salary = query_call(101) * 1.1
WHERE employee_id = 101;

SELECT max(commission_pct)
    FROM hr.employees;

CREATE OR REPLACE FUNCTION validate_comm(p_comm IN number)
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
/

CREATE OR REPLACE PROCEDURE reset_comm(p_comm IN number)
IS
    v_comm number := 0.1;
BEGIN
    IF validate_comm(p_comm) THEN
        dbms_output.put_line('OLD : ' || v_comm);
        v_comm := p_comm;
        dbms_output.put_line('NEW : ' || v_comm);
    ELSE
        raise_application_error(-20000, '기존 최고값을 넘을 수 없습니다.');
    END IF;
        
END reset_comm;
/

execute reset_comm(0.4);

CREATE OR REPLACE PACKAGE comm_pkg
IS
    g_comm number := 0.1;
    PROCEDURE reset_comm(p_comm IN number);
    
END comm_pkg;
/

exec dbms_output.put_line(comm_pkg.g_comm);
exec comm_pkg.g_comm := 0.5;
exec dbms_output.put_line(comm_pkg.g_comm);

CREATE OR REPLACE PACKAGE comm_pkg
IS
    g_comm number := 0.1;  
    PROCEDURE reset_comm(p_comm IN number);
    
END comm_pkg;
/

CREATE OR REPLACE PACKAGE BODY comm_pkg
IS
    
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

select text FROM user_source WHERE name = 'COMM_PKG' AND TYPE = 'PACKAGE' ORDER BY line;
select text FROM user_source WHERE name = 'COMM_PKG' AND TYPE = 'PACKAGE BODY' ORDER BY line;

CREATE OR REPLACE PACKAGE BODY comm_pkg
IS
    
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

    
END comm_pkg;
/

----------------------------------------------------------------------------------------------

CREATE OR REPLACE PACKAGE comm_pkg
IS
    g_comm number := 0.1;  
    PROCEDURE reset_comm(p_comm IN number);
    
END comm_pkg;
/

CREATE OR REPLACE PACKAGE BODY comm_pkg
IS
    
    FUNCTION validate_comm(p_comm IN number)
    RETURN boolean;
    
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
    
END comm_pkg;
/

CREATE OR REPLACE PACKAGE pack_over
IS
    TYPE date_tab_type IS TABLE OF date INDEX BY pls_integer;
    TYPE num_tab_type IS TABLE OF number INDEX BY pls_integer;
    
    PROCEDURE init(tab OUT date_tab_type, n IN number);
    PROCEDURE init(tab OUT num_tab_type, n IN number);
    
    
END pack_over;
/

CREATE OR REPLACE PACKAGE BODY pack_over
IS

    PROCEDURE init(tab OUT date_tab_type, n IN number)
    IS
    BEGIN
        FOR i IN 1..n LOOP
            tab(i) := sysdate;
        END LOOP;
        
    END init;
    
    PROCEDURE init(tab OUT num_tab_type, n IN number)
    IS
    BEGIN
        
        FOR i IN 1..n LOOP
            tab(i) := i;
        END LOOP;
    
    END init;
    
    
END pack_over;
/


DECLARE
    /* 1차원 날짜 배열 변수 */
    date_tab pack_over.date_tab_type;
    /* 1차원 숫자 배열 변수 */
    num_tab pack_over.num_tab_type;
    
BEGIN
    pack_over.init(date_tab, 5 );

    pack_over.init(num_tab, 10);
    
    FOR i IN 1..5 LOOP
        dbms_output.put_line(date_tab(i));
    END LOOP;
    
    FOR i IN 1..10 LOOP
        dbms_output.put_line(num_tab(i));
    END LOOP;
END;
/

CREATE OR REPLACE PACKAGE emp_find
IS

    PROCEDURE find(n IN number);
    PROCEDURE find(n IN varchar2);
    
END emp_find;
/

CREATE OR REPLACE PACKAGE BODY emp_find
IS

    PROCEDURE find(n IN number)
    IS
        v_num number;
        v_name varchar2(30);
    BEGIN
        SELECT employee_id, first_name
        INTO v_num, v_name
        FROM hr.employees
        WHERE employee_id = n;
        
        dbms_output.put_line(v_num || ' ' || v_name);
        
        
        EXCEPTION
            WHEN no_data_found THEN
                dbms_output.put_line( n ||' 번 사원은 존재하지 않습니다.');
    END;
    
    
    PROCEDURE find(n IN varchar2)
    IS
        CURSOR emp_cur IS
            SELECT employee_id, last_name
            FROM hr.employees
            WHERE last_name = initcap(n);
        
        v_cnt number := 0;
    BEGIN
        FOR v_rec IN emp_cur LOOP
            dbms_output.put_line(v_rec.employee_id || ' ' || v_rec.last_name);
            v_cnt := emp_cur%rowcount;
        END LOOP;
            
        IF v_cnt = 0 THEN
            dbms_output.put_line(n ||'  사원은 존재하지 않습니다.');
        END IF;
        
        
        EXCEPTION
            WHEN no_data_found THEN
                dbms_output.put_line( n ||'  사원은 존재하지 않습니다.');
    END;
    
END emp_find;
/

execute emp_find.find(100);
execute emp_find.find('Kingedafssfdee');

SELECT employee_id, first_name
            FROM hr.employees
            WHERE last_name = 'King';
