--select * from sys.user$; 오류 발생 dba 에서만 가능
SELECT e.last_name, e.hire_date, d.department_name
    FROM hr.employees e, hr.departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;

DECLARE
    /* scalar data type : 단일값만 보유하는 변수*/
    v_name varchar2(30);
    v_day date;
    v_dept_name varchar2(30);
BEGIN
    /* 암시적 커서 SELECT INTO 절 */
    SELECT e.last_name, e.hire_date, d.department_name
    INTO v_name, v_day, v_dept_name
    FROM hr.employees e, hr.departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;
    
    dbms_output.put_line(v_name);
    dbms_output.put_line(v_day);
    dbms_output.put_line(v_dept_name);
    
END;
/

DECLARE
    /* scalar data type : 단일값만 보유하는 변수*/
    v_name hr.employees.last_name%type;
    v_day hr.employees.hire_date%type;
    v_dept_name hr.departments.department_name%type;
BEGIN
    /* 암시적 커서 SELECT INTO 절 */
    SELECT e.last_name, e.hire_date, d.department_name
    INTO v_name, v_day, v_dept_name
    FROM hr.employees e, hr.departments d
    WHERE e.department_id = d.department_id
    AND e.employee_id = 100;
    
    dbms_output.put_line(v_name);
    dbms_output.put_line(v_day);
    dbms_output.put_line(v_dept_name);
    
END;
/

DECLARE
    /* record data type : 서로 다른 데이터 타입을 내부 구성 요소*/
    TYPE rec_type IS RECORD(
    name varchar2(30),
    day date,
    dept_name varchar2(30));
    
    /* 2차원 배열 */
    TYPE rec_tab IS TABLE OF rec_type INDEX BY pls_integer;
    v_tab rec_tab;
    
    /* VARRAY, 1차원 배열 */
    TYPE id_type IS VARRAY(3) OF number;
    v_id id_type := id_type(100,110,200);
BEGIN
    
    /* 암시적 커서 SELECT INTO 절 */
    FOR i IN v_id.first..v_id.last LOOP
        SELECT e.last_name, e.hire_date, d.department_name
        INTO v_tab(i)
        FROM hr.employees e, hr.departments d
        WHERE e.department_id = d.department_id
        AND e.employee_id = v_id(i);
    END LOOP;
    
    FOR j in v_tab.first..v_tab.last LOOP
        dbms_output.put_line(v_tab(j).name);
        dbms_output.put_line(v_tab(j).day);
        dbms_output.put_line(v_tab(j).dept_name);
    END LOOP;
    
END;
/

DECLARE
    v_name varchar2(30);
BEGIN
    SELECT last_name
    INTO v_name
    FROM hr.employees
    WHERE department_id = 20;
    
    dbms_output.put_line(v_name);
END;
/


DECLARE
    /* 1. 커서 선언 */
    CURSOR emp_cur IS
        SELECT last_name, salary
        FROM hr.employees
        WHERE department_id = 20;
        
    v_name varchar2(30);
    v_sal number;
BEGIN
    /* 2. 커서 OPEN */
    IF NOT emp_cur%ISOPEN THEN
        OPEN emp_cur;
        dbms_output.put_line('emp_cur 가 open 되었습니다.');
    END IF;
    
    /* 3. FETCH */
    
    LOOP
        FETCH emp_cur INTO v_name, v_sal;        
        EXIT WHEN emp_cur%notfound;
        dbms_output.put_line(v_name);
        dbms_output.put_line(v_sal);
        
    END LOOP;
    dbms_output.put_line(emp_cur%rowcount);
    
    /* 4. 커서 CLOSE */
    IF emp_cur%ISOPEN THEN
        CLOSE emp_cur;
        dbms_output.put_line('emp_cur 가 close 되었습니다.');
    END IF;
END;
/

DECLARE
    /* 1. 커서 선언 */
    CURSOR emp_cur IS
        SELECT e.employee_id id, e.last_name name, e.salary sal, d.department_name dept_name
        FROM hr.employees e, hr.departments d
        WHERE e.department_id = 20
        AND d.department_id = 20;
        
    v_cnt number := 0;
BEGIN
        FOR v_rec IN emp_cur LOOP
            dbms_output.put_line(v_rec.id ||' '||v_rec.name || ' '||v_rec.sal || ' ' || v_rec.dept_name);
            v_cnt := v_cnt + 1 ;
        END LOOP;
        dbms_output.put_line(v_cnt || ' 행이 인출되었습니다.');
END;
/

DECLARE
    v_cnt number := 0;
BEGIN
        FOR v_rec IN (SELECT e.employee_id id, e.last_name name, e.salary sal, d.department_name dept_name
        FROM hr.employees e, hr.departments d
        WHERE e.department_id = 20
        AND d.department_id = 20) LOOP
            dbms_output.put_line(v_rec.id ||' '||v_rec.name || ' '||v_rec.sal || ' ' || v_rec.dept_name);
            v_cnt := v_cnt + 1 ;
        END LOOP;
        dbms_output.put_line(v_cnt || ' 행이 인출되었습니다.');
END;
/

        
        


DECLARE
    CURSOR emp_cur IS
        SELECT l.city city, trim(to_char(sum(e.salary),'l999,999,999')) sum_sal, trim(to_char(trunc(avg(e.salary)),'l999,999,999')) avg_sal
        FROM hr.employees e, hr.departments d, hr.locations l
        WHERE e.department_id = d.department_id
        AND d.location_id = l.location_id
        AND e.hire_date >= '2006/01/01' AND e.hire_date < '2007/01/01'
        GROUP BY l.city;
        
        
BEGIN
    
        FOR v_rec IN emp_cur LOOP
            dbms_output.put_line(v_rec.city ||'도시에 근무하는 사원들의 총액급여는 '|| v_rec.sum_sal ||' 이고 평균급여는 '|| v_rec.avg_sal);
            
        END LOOP;
   
    
END;
/

SELECT employee_id, last_name, job_id
FROM hr.employees
WHERE department_id = 80
AND job_id = 'SA_MAN';

SELECT employee_id, last_name, job_id
FROM hr.employees
WHERE department_id = 50
AND job_id = 'ST_MAN';

DECLARE
    CURSOR emp_cur(p_id number, p_job varchar2) IS
        SELECT employee_id, last_name, job_id
        FROM hr.employees
        WHERE department_id = p_id
        AND job_id = p_job;
       
    v_rec emp_cur%rowtype;
BEGIN
    OPEN emp_cur(80, 'SA_MAN');
    
    LOOP
        FETCH emp_cur INTO v_rec;
        EXIT WHEN emp_cur%NOTFOUND;
        dbms_output.put_line(v_rec.employee_id ||' '||v_rec.last_name || ' '||v_rec.job_id);
        
    END LOOP;
    
    CLOSE emp_cur;
    
    FOR v_rec1 IN emp_cur(50,'ST_MAN') LOOP
        dbms_output.put_line(v_rec1.employee_id ||' '||v_rec1.last_name || ' '||v_rec1.job_id);
    END LOOP;

END;
/