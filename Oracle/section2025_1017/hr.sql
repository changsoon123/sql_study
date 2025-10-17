
SELECT a * b / c + d - e
FROM dual;

SELECT ((((a * b) / c) + d) - e)
FROM dual;

SELECT
        employee_id 사번,
        salary 급여,
        commission_pct 보너스,
        salary * 12 + salary * 12 * nvl(commission_pct,0) as "100annual_salary"
FROM hr.employees;

-- PL/SQL 문법
IF commision_pct is null THEN
    RETURN 0;
ELSE
    RETURN commission_pct;
END IF;

SELECT
        employee_id,
        last_name||first_name
FROM hr.employees;

SELECT
        1000,
        100||100
FROM dual;

SELECT
        last_name,
        salary,
        salary||'00'
FROM hr.employees;

desc hr.employees;

SELECT
        employee_id,
        q'[My name's']' ||last_name||' '||first_name "Name"
FROM hr.employees;

SELECT
        unique department_id
FROM hr.employees;

SELECT
        DISTINCT department_id, job_id
FROM hr.employees;

SELECT
        employee_id as "Emp#",
        last_name ||' '||first_name as "Employee Name"
from hr.employees;

SELECT
        last_name || ', '||job_id as "Employee and Tile"
FROM hr.employees;

SELECT
        department_name || q'['s Manager id: ]' ||manager_id as "Department and Manager"
FROM hr.departments;

desc hr.employees;

SELECT *
FROM hr.employees
WHERE employee_id = 100;

SELECT *
FROM hr.employees
WHERE last_name = 'King';

SELECT *
FROM hr.employees
WHERE UPPER(last_name) = 'KING';

SELECT *
FROM hr.employees
WHERE hire_date = '01/01/13';

SELECT *
FROM hr.employees
WHERE hire_date = '2001/01/13';

SELECT *
FROM hr.employees
WHERE hire_date = '01-01-13';

SELECT *
FROM hr.employees
WHERE hire_date = '01-JAN-13'; -- DD-MON-RR 오류 발생

SELECT *
FROM hr.employees
WHERE hire_date = to_date('2001-01-13','yyyy-mm-dd');

SELECT *
FROM hr.employees
WHERE hire_date = to_date('20010113','yyyymmdd');

SELECT *
FROM hr.employees
WHERE hire_date = to_date('010113','yymmdd');

SELECT *
FROM nls_session_parameters;

desc hr.employees;

SELECT *
FROM hr.employees
WHERE salary <= 10000;

SELECT *
FROM hr.employees
WHERE salary > 10000;

SELECT *
FROM hr.employees
WHERE employee_id <> 100;

SELECT *
FROM hr.employees
WHERE employee_id != 100;

SELECT *
FROM hr.employees
WHERE department_id = 50
OR salary >= 5000;

SELECT last_name, salary
FROM hr.employees
WHERE salary >= 2500 AND salary <=3500;

SELECT last_name, salary
FROM hr.employees
WHERE salary BETWEEN 2500 AND 3500;

SELECT last_name, salary
FROM hr.employees
WHERE NOT(salary >= 2500 AND salary <=3500);

SELECT last_name, salary
FROM hr.employees
WHERE salary NOT BETWEEN 2500 AND 3500;

SELECT last_name, salary
FROM hr.employees
WHERE salary < 2500 OR salary >3500;

SELECT last_name, salary
FROM hr.employees
WHERE last_name BETWEEN 'Abel' AND 'Austin';

SELECT *
FROM hr.employees
WHERE hire_date BETWEEN TO_DATE('2001-01','yyyy-mm') AND TO_DATE('2002-02','yyyy-mm');

SELECT *
FROM hr.employees
WHERE hire_date >= '01/01/01' AND hire_date <= '02/12/31';

SELECT *
FROM hr.employees
WHERE hire_date BETWEEN TO_DATE('2001-01','yyyy-mm') 
AND TO_DATE('2002-12-31 23:59:59','yyyy-mm-dd hh24:mi:ss');

SELECT *
FROM employees
WHERE employee_id IN (100,105,200);

SELECT *
FROM employees
WHERE employee_id = 100
OR employee_id = 105
OR employee_id = 200;

SELECT *
FROM employees
WHERE employee_id NOT IN (100,105,200);

SELECT *
FROM employees
WHERE NOT(employee_id = 100
OR employee_id = 105
OR employee_id = 200);

SELECT *
FROM employees
WHERE employee_id <> 100
AND employee_id <> 105
AND employee_id <> 200;


SELECT *
FROM hr.employees
WHERE department_id = 30
OR department_id = 50
OR department_id = 60
AND salary > 5000;

SELECT *
FROM hr.employees
WHERE (department_id = 30
OR department_id = 50
OR department_id = 60)
AND salary > 5000;

SELECT *
FROM hr.employees
WHERE department_id IN(30,50,60)
AND salary > 5000;

SELECT *
FROM hr.employees
WHERE commission_pct IS NULL;

SELECT *
FROM hr.employees
WHERE commission_pct IS NOT NULL;

SELECT *
FROM hr.employees
WHERE last_name LIKE 'K%';

SELECT *
FROM hr.employees
WHERE hire_date LIKE '02%';

SELECT JOB_ID
FROM hr.employees;

SELECT *
FROM hr.employees
WHERE job_id LIKE 'HR^%%' ESCAPE '^';

SELECT *
FROM hr.employees
WHERE job_id LIKE 'SA%' and salary >= 10000;

SELECT *
FROM hr.employees
WHERE last_name LIKE '___a' OR last_name LIKE '___e';