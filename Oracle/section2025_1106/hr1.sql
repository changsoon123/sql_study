
BEGIN
    SELECT last_name, salary, hire_date
    FROM hr.employees
    WHERE employee_id = 100;
END;
/

SELECT last_name, salary, hire_date
    FROM hr.employees
    WHERE employee_id = 100;

DECLARE
    v_name varchar2(30);
    v_sal number;
    v_date date;
BEGIN
    SELECT last_name, salary, hire_date
    INTO v_name, v_sal, v_date
    FROM hr.employees
    WHERE department_id = 300;
    
    dbms_output.put_line(v_name || ' ' || v_sal || ' ' || v_date );
END;
/

DECLARE
    v_name varchar2(30);
    v_sal number;
    v_date date;
BEGIN
    SELECT last_name, salary, hire_date
    INTO v_name, v_sal, v_date
    FROM hr.employees
    WHERE department_id = 20;
    
    dbms_output.put_line(v_name || ' ' || v_sal || ' ' || v_date );
END;
/

DESC employees;

DECLARE
    v_lname varchar2(30);
    v_fname varchar2(30);
    v_sal number;
    v_date date;
BEGIN
    SELECT last_name,first_name,salary, hire_date
    INTO v_lname,v_fname, v_sal, v_date
    FROM hr.employees
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_lname || ' ' || v_fname ||' '|| v_sal || ' ' || v_date );
END;
/

DECLARE
    v_lname employees.last_name%type;
    v_fname v_lname%type;
    v_sal employees.salary%type;
    v_date employees.hire_date%type;
BEGIN
    SELECT last_name,first_name,salary, hire_date
    INTO v_lname,v_fname, v_sal, v_date
    FROM hr.employees
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_lname || ' ' || v_fname ||' '|| v_sal || ' ' || v_date );
END;
/

DECLARE
    v_avg number;
BEGIN
    SELECT avg(salary)
    INTO v_avg
    FROM hr.employees;
    dbms_output.put_line('전체 사원의 평균 급여 : ' || round(v_avg)); 
END;
/

SELECT *
FROM hr.employees
WHERE salary > v_avg; -- 오류 발생 v_avg 변수는 local variable 이기 때문에 프로그램 바깥쪽에서 사용할 수 없다.

var b_avg number

DECLARE
    v_avg number;
BEGIN
    SELECT avg(salary)
    INTO :b_avg
    FROM hr.employees;
    dbms_output.put_line('전체 사원의 평균 급여 : ' || round(:b_avg)); 
END;
/

SELECT *
FROM hr.employees
WHERE salary > :b_avg;



DECLARE
    lname hr.employees.last_name%type;
    sal hr.employees.salary%type;
    hdate hr.employees.hire_date%type;
BEGIN

    SELECT last_name, salary, hire_date
    INTO lname,sal,hdate
    FROM hr.employees e
    WHERE e.employee_id = 100;
    
    dbms_output.put_line('이름 : ' || lname); 
    dbms_output.put_line('급여 : ' || sal); 
    dbms_output.put_line('입사일 : ' ||hdate);     
END;
/

DECLARE
    lname hr.employees.last_name%type;
    sal hr.employees.salary%type;
    hdate hr.employees.hire_date%type;
BEGIN

    SELECT last_name, salary, hire_date
    INTO lname,sal,hdate
    FROM hr.employees e
    WHERE e.employee_id = :b_id;
    
    dbms_output.put_line('이름 : ' || upper(lname)); 
    dbms_output.put_line('급여 : ' || trim(to_char(sal,'l999,999.00'))); 
    dbms_output.put_line('입사일 : ' || to_char(hdate,'yyyy"년" fmmm"월" dd"일"'));     
    dbms_output.put_line('입사일 : ' || to_char(hdate,'DL'));     
END;
/

SELECT sysdate, to_char(sysdate, 'dl') from dual;
SELECT sysdate, to_char(sysdate, 'ds') from dual;

DECLARE
    v_name employees.last_name%TYPE;
    v_sal  employees.salary%TYPE;
    v_date employees.hire_date%TYPE;
BEGIN
    SELECT last_name, salary, hire_date
    INTO v_name, v_sal, v_date
    FROM hr.employees
    WHERE employee_id = :b_id;
    dbms_output.put_line('이름 : ' || UPPER(v_name));
    dbms_output.put_line('급여 : ' || TO_CHAR(v_sal, '999,999.00'));    
    dbms_output.put_line('입사일 : ' || TO_CHAR(v_date, 'yyyy"년" mm"월" dd"일"'));
END;
/

var b_name varchar2(30)
var b_sal number
var b_date varchar2(30)
var b_id number
execute :b_id := 100

BEGIN
    SELECT last_name, salary, hire_date
    INTO :b_name, :b_sal, :b_date
    FROM hr.employees
    WHERE employee_id = :b_id;
    
    dbms_output.put_line('이름 : ' || UPPER(:b_name));
    dbms_output.put_line('급여 : ' || TO_CHAR(:b_sal, 'l999,999.00'));    
    dbms_output.put_line('입사일 : ' || to_char(:b_date,'yyyy-mm-dd'));
END;
/

DROP TABLE hr.test PURGE;

CREATE TABLE hr.test(id number, name varchar2(30), day date) TABLESPACE users;

INSERT INTO hr.test(id,name,day) VALUES(1,'ORACLE',SYSDATE);

SELECT * FROM hr.test;

ROLLBACK;

BEGIN
    INSERT INTO hr.test(id,name,day) VALUES(1,'ORACLE',SYSDATE);
END;
/

SELECT * FROM hr.test;

ROLLBACK;


BEGIN
    INSERT INTO hr.test(id,name,day) VALUES(:b_id, :b_name, to_date(:b_day,'yyyy-mm-dd'));
END;
/

SELECT * FROM hr.test;

DECLARE
    v_id number := :b_id;
    v_name varchar2(30) := :b_name;
    v_day date := to_date(:b_day,'yyyy-mm-dd');
BEGIN
    INSERT INTO hr.test(id,name,day) VALUES(v_id, v_name, v_day);
END;
/

BEGIN
    INSERT INTO hr.test(id,name,day)
    SELECT employee_id, last_name, hire_date
    FROM hr.employees;
    
    dbms_output.put_line(sql%rowcount || '행이 입력되었습니다.'); 
END;
/

rollback;

SELECT * FROM hr.test;

commit;

UPDATE hr.test
SET day = sysdate
WHERE id IN (100,101);

BEGIN
    UPDATE hr.test
    SET day = sysdate
    WHERE id = 300;
    
    IF sql%found THEN
        dbms_output.put_line(sql%rowcount || '행이 수정되었습니다.'); 
    ELSE
        dbms_output.put_line('사원이 존재하지 않습니다.');
    END IF;
    ROLLBACK;
END;
/

BEGIN
    DELETE FROM hr.test WHERE id = 300;
    IF sql%found THEN
        dbms_output.put_line(sql%rowcount || '행이 삭제 되었습니다.'); 
    ELSE
        dbms_output.put_line('사원이 존재하지 않습니다.');
    END IF;
    ROLLBACK;
END;
/


BEGIN
    DELETE FROM hr.test WHERE day < to_date('2005-01-01','yyyy-mm-dd');
    IF sql%found THEN
        dbms_output.put_line(sql%rowcount || '행이 삭제 되었습니다.'); 
    ELSE
        dbms_output.put_line('사원이 존재하지 않습니다.');
    END IF;
    ROLLBACK;
END;
/

SELECT months_between(day,sysdate) FROM hr.test;

DECLARE
    b_id number := 100;
BEGIN    
    UPDATE hr.employees
    SET salary = salary * 1.1
    WHERE employee_id = (SELECT hire_date
                        FROM hr.employees e
                        WHERE trunc(months_between(sysdate,hire_date)/12) >= 20
                        AND e.employee_id = b_id);
    IF sql%found THEN
        dbms_output.put_line('인상 되었습니다.'); 
    ELSE
        dbms_output.put_line('인상 되지 않았습니다.');
    END IF;
    
    rollback;
END;
/

DECLARE
    v_day employees.hire_date%type;
    v_years number;
    v_sal_before employees.salary%type;
    v_sal_after v_sal_before%type;
BEGIN

    SELECT hire_date, trunc(months_between(sysdate,hire_date)/12), salary
    INTO v_day, v_years, v_sal_before
    FROM hr.employees
    WHERE employee_id = :b_id;
    
    dbms_output.put_line(:b_id||'사원의 입사일은 ' || to_char(v_day,'yyyy-mm-dd') || ' 근속연수는 ' || v_years || ' 년입니다.'); 
    
    IF v_years >= 20 THEN
        UPDATE hr.employees
        SET salary = salary * 1.1
        WHERE employee_id = :b_id;
    
        SELECT salary
        INTO v_sal_after
        FROM hr.employees
        WHERE employee_id = :b_id;
        
        dbms_output.put_line(:b_id || '사원의 이전 급여는 ' || v_sal_before || ' 수정된 급여는 ' || v_sal_after);
    ELSE
        dbms_output.put_line(:b_id || '사원의 급여는 수정할 수 없습니다.');
    END IF;
rollback;
END;
/

DECLARE
    v_dept_id departments.department_id%type;
    v_dept_name departments.department_name%type;
    v_dept_mgr departments.manager_id%type;
    v_dept_loc departments.location_id%type;
BEGIN
    SELECT *
    INTO v_dept_id, v_dept_name, v_dept_mgr, v_dept_loc
    FROM hr.departments
    WHERE department_id = 10;
    dbms_output.put_line('부서번호 : ' || v_dept_id);
    dbms_output.put_line('부서이름 : ' || v_dept_name);
    dbms_output.put_line('부서장 : ' || v_dept_mgr);
    dbms_output.put_line('부서위치 : ' || v_dept_loc);      
END;
/


DECLARE
    /* 레코드 유형(scalary data type), field 구성 */
    TYPE dept_record_type IS RECORD
    (v_dept_id departments.department_id%type,
    v_dept_name departments.department_name%type,
    v_dept_mgr departments.manager_id%type,
    v_dept_loc departments.location_id%type);
    
    v_rec dept_record_type;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.departments
    WHERE department_id = 10;
    dbms_output.put_line('부서번호 : ' || v_rec.v_dept_id);
    dbms_output.put_line('부서이름 : ' || v_rec.v_dept_name);
    dbms_output.put_line('부서장 : ' || v_rec.v_dept_mgr);
    dbms_output.put_line('부서위치 : ' || v_rec.v_dept_loc);      
END;
/

DECLARE
    /* 레코드 유형(scalary data type), field 구성 */
    TYPE dept_record_type IS RECORD
    (dept_id number,
    dept_name varchar2(30),
    dept_mgr number,
    dept_loc number);
    
    v_rec dept_record_type;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.departments
    WHERE department_id = 10;
    dbms_output.put_line('부서번호 : ' || v_rec.dept_id);
    dbms_output.put_line('부서이름 : ' || v_rec.dept_name);
    dbms_output.put_line('부서장 : ' || v_rec.dept_mgr);
    dbms_output.put_line('부서위치 : ' || v_rec.dept_loc);      
END;
/


DECLARE
    
    v_rec departments%rowtype;
    
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.departments
    WHERE department_id = 10;
    dbms_output.put_line('부서번호 : ' || v_rec.department_id);
    dbms_output.put_line('부서이름 : ' || v_rec.department_name);
    dbms_output.put_line('부서장 : ' || v_rec.manager_id);
    dbms_output.put_line('부서위치 : ' || v_rec.location_id);      
END;
/

DECLARE
    TYPE rec_type IS RECORD
    (sal number,
     minsal number default 1000,
     day date,
     rec employees%rowtype);
     
     v_rec rec_type;
BEGIN
    v_rec.sal := v_rec.minsal + 500;
    v_rec.day := sysdate;
    
    SELECT *
    INTO v_rec.rec
    FROM hr.employees
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_rec.sal);
    dbms_output.put_line(v_rec.minsal);
    dbms_output.put_line(v_rec.day);    
    dbms_output.put_line(v_rec.rec.last_name);    
    dbms_output.put_line(months_between(v_rec.day , v_rec.rec.hire_date)/12);    
END;
/

CREATE TABLE hr.retired_emp
AS
SELECT *
FROM hr.employees
WHERE 1=2;

SELECT *
FROM hr.retired_emp;

DECLARE
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = 100;
    
    dbms_output.put_line(v_rec.last_name);
    
    INSERT INTO hr.retired_emp VALUES v_rec;
    COMMIT;
END;
/

SELECT * FROM hr.retired_emp;

ROLLBACK;

DECLARE
    v_rec employees%rowtype;
BEGIN
    SELECT *
    INTO v_rec
    FROM hr.employees
    WHERE employee_id = 100;
    
    v_rec.first_name := upper(v_rec.first_name);
    v_rec.last_name := upper(v_rec.last_name);
    v_rec.commission_pct := 0.1;
    v_rec.hire_date := sysdate;
    v_rec.department_id := 10;
    
    UPDATE hr.retired_emp
    SET row = v_rec
    WHERE employee_id = 100;
END;
/

rollback;