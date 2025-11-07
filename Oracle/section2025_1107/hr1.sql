DECLARE
    TYPE tab_char_type IS TABLE OF varchar2(10) INDEX BY pls_integer;
    v_city tab_char_type;
BEGIN
    v_city(1) := '서울';
    v_city(2) := '부산';
    v_city(3) := '광주';
    v_city(4) := '대구';
    
    dbms_output.put_line(v_city(1));
    dbms_output.put_line(v_city(2));
    dbms_output.put_line(v_city(3));
    dbms_output.put_line(v_city(4));
END;
/

DECLARE
    TYPE tab_char_type IS TABLE OF varchar2(10) INDEX BY pls_integer;
    v_city tab_char_type;
BEGIN
--    v_city(2) := '서울';
    v_city(1) := '부산';
    v_city(4) := '광주';
    v_city(3) := '대구';
    
    dbms_output.put_line(v_city.count);
    dbms_output.put_line(v_city.first);
    dbms_output.put_line(v_city.last);
    dbms_output.put_line(v_city.next(1));
    dbms_output.put_line(v_city.prior(3));
END;
/

DECLARE
    TYPE tab_char_type IS TABLE OF varchar2(10) INDEX BY pls_integer;
    v_city tab_char_type;
BEGIN
    v_city(1) := '서울';
    v_city(2) := '부산';
    v_city(3) := '광주';
    v_city(4) := '대구';
    
    FOR i IN v_city.first..v_city.last LOOP
        dbms_output.put_line(v_city(i));
    END LOOP;
    
END;
/

DECLARE
    TYPE tab_char_type IS TABLE OF varchar2(10) INDEX BY pls_integer;
    v_city tab_char_type;
BEGIN
    v_city(1) := '서울';
    v_city(2) := '부산';
    v_city(3) := '광주';
    v_city(4) := '대구';
    
    v_city.delete(3);
    
    FOR i IN v_city.first..v_city.last LOOP
        IF v_city.exists(i) THEN
            dbms_output.put_line(v_city(i));
        ELSE
            dbms_output.put_line(i||' key-value가 존재하지 않습니다.');
        END IF;
    END LOOP;
    
END;
/

UPDATE hr.employees
SET salary = salary * 1.1
WHERE employee_id = 100;

UPDATE hr.employees
SET salary = salary * 1.1
WHERE employee_id = 110;

UPDATE hr.employees
SET salary = salary * 1.1
WHERE employee_id = 120;


DECLARE
    TYPE tab_id_type IS TABLE OF number INDEX BY pls_integer;
    v_tab tab_id_type;
BEGIN
    v_tab(1) := 100;
    v_tab(2) := 110;
    v_tab(3) := 120;
    
    UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = v_tab(1);
    
    UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = v_tab(2);
    
    UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = v_tab(3);
    
    ROLLBACK;
END;
/


DECLARE
    TYPE tab_id_type IS TABLE OF number INDEX BY pls_integer;
    v_tab tab_id_type;
BEGIN
    v_tab(1) := 100;
    v_tab(2) := 110;
    v_tab(3) := 120;
    
    FOR i IN v_tab.first..v_tab.last LOOP   
        UPDATE hr.employees
        SET salary = salary * 1.1
        WHERE employee_id = v_tab(i);
    END LOOP;
    
    ROLLBACK;
END;
/

DECLARE
    TYPE tab_id_type IS TABLE OF number INDEX BY pls_integer;
    v_tab tab_id_type;
BEGIN
    v_tab(1) := 100;
    v_tab(2) := 110;
    v_tab(3) := 120;
    v_tab(5) := 130;

    
    FOR i IN v_tab.first..v_tab.last LOOP
        IF v_tab.exists(i) THEN
            UPDATE hr.employees
            SET salary = salary * 1.1
            WHERE employee_id = v_tab(i);
        ELSE
            dbms_output.put_line(i || ' 요소번호는 없는 사원번호 입니다.');
        END IF;
    END LOOP;
    
    ROLLBACK;
END;
/


DECLARE
    TYPE tab_id_type IS TABLE OF number INDEX BY pls_integer;
    v_tab tab_id_type;
    TYPE tab_id_type2 IS TABLE OF number INDEX BY pls_integer;
    v_tab2 tab_id_type2;
    TYPE tab_id_type3 IS TABLE OF number INDEX BY pls_integer;
    v_tab3 tab_id_type3;
BEGIN
    v_tab(1) := 100;
    v_tab(2) := 101; 
    v_tab(3) := 102; 
    v_tab(4) := 103;
    v_tab(5) := 104;
    v_tab(6) := 200;
    v_tab2(1) := null;
    v_tab2(2):= null;
    v_tab2(3):= null;
    v_tab2(4):= null;
    v_tab2(5):= null;
    v_tab2(6):= null;
    v_tab3(1) := null;
    v_tab3(2):= null;
    v_tab3(3):= null;
    v_tab3(4):= null;
    v_tab3(5):= null;
    v_tab3(6):= null;
    
    
    FOR i IN v_tab.first..v_tab.last LOOP
    
        IF v_tab.exists(i) THEN
        
            SELECT trunc(months_between(sysdate,hire_date)/12), salary
            INTO v_tab2(i), v_tab3(i)
            FROM hr.employees
            WHERE employee_id = v_tab(i);
            
            dbms_output.put_line(v_tab(i) || '사원의 ' || v_tab2(i) || ' 근무년수,' || ' 전 급여: ' || v_tab3(i));
            
            IF v_tab2(i) >= 20 THEN
                UPDATE hr.employees
                SET salary = salary * 1.1
                WHERE employee_id = v_tab(i);
                
                SELECT salary
                INTO v_tab3(i)
                FROM hr.employees
                WHERE employee_id = v_tab(i);
                
                dbms_output.put_line(v_tab(i) || '사원의 급여를 인상했습니다.' || ' 후 급여: ' || v_tab3(i) );
            ELSE
                dbms_output.put_line(v_tab(i) || '사원의 급여는 그대로 입니다.' || ' 후 급여: ' || v_tab3(i) );
            END IF;
            
        ELSE
            dbms_output.put_line('없는 사원입니다.');
        END IF;
    END LOOP;
    
    ROLLBACK;
    

END;
/

DECLARE

    /* 레코드 변수*/
    TYPE rec_type IS RECORD(id number, name varchar2(30), mgr number, loc number);
    v_rec rec_type;
BEGIN

    SELECT *
    INTO v_rec
    FROM hr.departments
    WHERE department_id = 10;
    
    dbms_output.put_line(v_rec.id);
    dbms_output.put_line(v_rec.name);
    dbms_output.put_line(v_rec.mgr);
    dbms_output.put_line(v_rec.loc);

END;
/

DECLARE
    /* 레코드 변수*/
    v_rec departments%rowtype;
BEGIN
    
    FOR i IN 1..5 LOOP    
        SELECT *
        INTO v_rec
        FROM hr.departments
        WHERE department_id = 10*i;
    
    dbms_output.put_line(v_rec.department_id);
    dbms_output.put_line(v_rec.department_name);
    dbms_output.put_line(v_rec.manager_id);
    dbms_output.put_line(v_rec.location_id);
    END LOOP;
    
END;
/

DECLARE
    /* 레코드 변수*/
    v_rec departments%rowtype;
BEGIN
    
    FOR i IN 1..5 LOOP    
        SELECT *
        INTO v_rec
        FROM hr.departments
        WHERE department_id = 10*i;
    END LOOP;   
    dbms_output.put_line(v_rec.department_id);
    dbms_output.put_line(v_rec.department_name);
    dbms_output.put_line(v_rec.manager_id);
    dbms_output.put_line(v_rec.location_id);
 
    
END;
/

DECLARE
   /* 2차원 배열 변수 */
   TYPE tab_type IS TABLE OF departments%rowtype INDEX BY pls_integer;
   
    v_tab tab_type;
BEGIN
    
    FOR i IN 1..5 LOOP    
        SELECT *
        INTO v_tab(i) -- 2차원 배열 변수
        FROM hr.departments
        WHERE department_id = 10*i;
    END LOOP; 
    
    FOR j IN v_tab.first..v_tab.last LOOP
        dbms_output.put_line(v_tab(j).department_id);
        dbms_output.put_line(v_tab(j).department_name);
        dbms_output.put_line(v_tab(j).manager_id);
        dbms_output.put_line(v_tab(j).location_id);
    END LOOP; 
    
END;
/

DECLARE

    /* 레코드 변수*/
    TYPE rec_type IS RECORD(id number, name varchar2(30), mgr number, loc number);
    
    /* 2차원 배열타입 선언 */
    TYPE tab_type IS TABLE OF rec_type INDEX BY pls_integer;
    v_tab tab_type; --2차원 배열 변수
BEGIN
    FOR i IN 1..5 LOOP
        SELECT *
        INTO v_tab(i)
        FROM hr.departments
        WHERE department_id = 10 * i;
    END LOOP;
    
    FOR j IN v_tab.first..v_tab.last LOOP
        dbms_output.put_line(v_tab(j).id);
        dbms_output.put_line(v_tab(j).name);
        dbms_output.put_line(v_tab(j).mgr);
        dbms_output.put_line(v_tab(j).loc);
    END LOOP;
END;
/

SELECT d.department_name, e.last_name, e.hire_date 
        FROM hr.departments d, hr.employees e
        WHERE d.department_id = e.department_id
        AND e.employee_id = 100;

DECLARE
     
    TYPE rec_type IS RECORD(dname varchar2(30), lname varchar2(30), day date);
    TYPE tab_type IS TABLE OF rec_type INDEX BY pls_integer;
    v_tab tab_type; 
    TYPE num_type IS TABLE OF number INDEX BY pls_integer;
    v_num num_type;
BEGIN

    v_num(1) := 100;
    v_num(2) := 110;
    v_num(3) := 200;
    
    
    FOR i IN 1..3 LOOP
        SELECT d.department_name, e.last_name, e.hire_date 
        INTO v_tab(i)
        FROM hr.departments d, hr.employees e
        WHERE d.department_id = e.department_id
        AND e.employee_id = v_num(i);
    END LOOP;
    
    FOR j IN v_tab.first..v_tab.last LOOP
        dbms_output.put_line(v_tab(j).dname);
        dbms_output.put_line(v_tab(j).lname);
        dbms_output.put_line(v_tab(j).day);
    END LOOP;
END;
/

DECLARE
    /* INDEX BY TABLE, 연관배열 */
    TYPE id_type IS TABLE OF number INDEX BY pls_integer;
    v_id id_type;
BEGIN
    v_id(1) := 100;
    v_id(2) := 110;
    v_id(3) := 120;
    
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;

END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120);
BEGIN
     
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;

END;
/

DECLARE
    /* INDEX BY TABLE, 연관배열 */
    TYPE id_type IS TABLE OF number INDEX BY pls_integer;
    v_id id_type;
BEGIN
    v_id(1) := 100;
    v_id(2) := 110;
    v_id(3) := 120;
    
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
    
    dbms_output.put_line(v_id.count);
    v_id(5) := 140;
    dbms_output.put_line(v_id.count);
    
END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120);
BEGIN
     
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
    
    dbms_output.put_line(v_id.count);
    v_id(5) := 140; --여기서 오류 발생
    dbms_output.put_line(v_id.count);

END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120,130);
BEGIN
     
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
    
    dbms_output.put_line(v_id.count);
    v_id.extend;
    v_id(5) := 140; 
    dbms_output.put_line(v_id.count);
    
    v_id.extend(2);
    v_id(6) := 150;
    v_id(7) := 160;
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120);
BEGIN
    v_id.extend(3,1);     
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;

END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120);
BEGIN
    v_id(2) := 200; --요소값 수정
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;

END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120,130,140,150);
BEGIN
    v_id.delete(v_id.count); --제일 끝에 있는 요소값 삭제
    v_id.delete(v_id.last);
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120,130,140,150);
BEGIN
--    v_id.delete(v_id.count); --제일 끝에 있는 요소값 삭제
--    v_id.delete(v_id.last);
    v_id.trim;
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/

DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type;
BEGIN
    v_id := id_type(100,110,120,130,140,150);
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/

DECLARE
    /* VARRAY */
    TYPE id_type IS VARRAY(10) OF number;
    v_id id_type := id_type(100,110,120,130,140,150);
BEGIN
    dbms_output.put_line(v_id.count);
    v_id.extend;
    v_id(7) := 160;
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/


DECLARE
    /* NESTED TABLE , 오라클이 자동으로 KEY 값을 입력한다.*/
    TYPE id_type IS TABLE OF number;
    v_id id_type := id_type(100,110,120,130,140,150);
BEGIN
    v_id.delete(6);
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/

DECLARE
    /* VARRAY */
    TYPE id_type IS VARRAY(10) OF number;
    v_id id_type := id_type(100,110,120,130,140,150);
BEGIN
    dbms_output.put_line(v_id.count);
    v_id.trim;
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/

DECLARE
    /* VARRAY */
    TYPE id_type IS VARRAY(10) OF number;
    v_id id_type := id_type(100,110,120,130,140,150);
BEGIN
    dbms_output.put_line(v_id.count);
    v_id.trim(2);
    FOR i IN v_id.first..v_id.last LOOP
        dbms_output.put_line(v_id(i));
    END LOOP;
END;
/