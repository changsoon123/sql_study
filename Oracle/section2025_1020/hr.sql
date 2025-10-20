
SELECT *
FROM hr.employees
WHERE job_id LIKE 'SA%'
AND salary >= 10000
AND hire_date BETWEEN TO_DATE('2005-01-01', 'YYYY-MM-DD') 
                    AND TO_DATE('2005-12-31 23:59:59', 'YYYY-MM-DD hh24:mi:ss');

SELECT *
FROM hr.employees
WHERE job_id in ('SA_REP','AD_PRES')
AND salary > 10000;

SELECT * FROM nls_session_parameters;

SELECT employee_id, last_name, salary
FROM hr.employees
ORDER BY salary;

SELECT employee_id, last_name, salary
FROM hr.employees
ORDER BY salary ASC;

SELECT employee_id, last_name, salary
FROM hr.employees
ORDER BY salary DESC;

SELECT employee_id, last_name, salary
FROM hr.employees
WHERE department_id = 50
ORDER BY salary * 12 DESC;

SELECT employee_id, last_name, salary , salary * 12 annual_salary
FROM hr.employees
WHERE department_id = 50
ORDER BY annual_salary DESC;

SELECT employee_id, last_name, salary , salary * 12 "annual_salary"
FROM hr.employees
WHERE department_id = 50
ORDER BY "annual_salary" DESC;

SELECT employee_id, last_name, salary , salary * 12 "annual_salary"
FROM hr.employees
WHERE department_id = 50
ORDER BY 4 DESC;

SELECT employee_id, last_name, salary , salary * 12 "annual_salary"
FROM hr.employees
ORDER BY 3 ASC, 4 DESC;

SELECT employee_id, last_name, hire_date
FROM hr.employees
WHERE hire_date BETWEEN TO_DATE('2006-01-01', 'YYYY-MM-DD') 
                    AND TO_DATE('2006-12-31 23:59:59', 'YYYY-MM-DD hh24:mi:ss')
ORDER BY last_name;

SELECT employee_id, last_name, salary
FROM hr.employees
WHERE department_id = 80
AND commission_pct = 0.2
AND job_id = 'SA_MAN'
ORDER BY last_name;

SELECT last_name, salary
FROM hr.employees
WHERE salary NOT BETWEEN 5000 AND 12000
ORDER BY salary DESC;

SELECT last_name, upper(last_name), lower(last_name), initcap(last_name)
FROM hr.employees;

SELECT *
FROM hr.employees
WHERE last_name = 'KING';

SELECT *
FROM hr.employees
WHERE upper(last_name) = 'KING';

SELECT *
FROM hr.employees
WHERE last_name = initcap('KING');

SELECT
    last_name,
    first_name,
    last_name || ' ' || first_name,
    concat(concat(last_name,' '),first_name)
FROM hr.employees;

SELECT
    last_name,
    first_name,
    upper(last_name || ' ' || first_name) name_1,
    upper(concat(concat(last_name,' '),first_name)) name_2
FROM hr.employees;

SELECT
    last_name,
    length(last_name),
    length(last_name || ' ' || first_name)
FROM hr.employees;

SELECT
    last_name,
    lengthb(last_name),
    lengthb(last_name || ' ' || first_name)
FROM hr.employees;

SELECT
    length('오라클'),
    lengthb('오라클')
FROM dual;

SELECT * FROM nls_database_parameters;

SELECT
    last_name,
    instr(last_name, 'a'),
    instr(last_name, 'a',1,1),
    instr(last_name, 'a',1,2)
FROM hr.employees;

SELECT
    instr('abc', 'a')
FROM dual;

SELECT
    last_name
FROM hr.employees
WHERE last_name LIKE '%a%a%';

SELECT
    last_name
FROM hr.employees
WHERE instr(last_name,'a',1,2) > 0;

SELECT
    last_name,
    substr(last_name, 1, 1),
    substr(last_name, 2, 1),
    substr(last_name, -1, 1),
    substr(last_name, -2, 2)
FROM hr.employees;

SELECT
    substr('abcdef',1,2),    
    substrb('abcdef',1,2),
    substr('가나다라마바',1,2),
    substrb('가나다라마바',1,6)
FROM dual;

SELECT
    'aabbcaa',
    trim('a' from 'aabbcaa'),
    trim('a' from 'aabbaacaa'),
    ltrim('aabbcaa','a'),
    rtrim('aabbcaa','a')
FROM dual;

SELECT
    '  oracle   ',
    trim(' ' from '  oracle  '),
    trim('  oracle  '),
    ltrim('  oracle  ', ' ' ),
    rtrim('   oracle  ', ' ')
FROM dual;

SELECT
    last_name, length(last_name)
FROM hr.employees
WHERE last_name LIKE 'A%' OR last_name LIKE 'M%' OR last_name LIKE 'J%'
ORDER BY last_name DESC;

SELECT
    last_name, length(last_name)
FROM hr.employees
WHERE substr(last_name, 1,1) = 'J' OR substr(last_name, 1,1) = 'A' OR substr(last_name, 1,1) = 'M'
ORDER BY last_name DESC;

SELECT
    last_name, length(last_name)
FROM hr.employees
WHERE instr(last_name,'J',1,1) = 1 OR instr(last_name,'A',1,1) = 1 OR instr(last_name,'M',1,1) = 1
ORDER BY last_name DESC;

SELECT
    last_name
FROM hr.employees
WHERE last_name LIKE '_a%'
AND department_id = 50;

SELECT
    last_name
FROM hr.employees
WHERE substr(last_name,2,1) = 'a'
AND department_id = 50;

SELECT
    last_name
FROM hr.employees
WHERE instr(last_name,'a',2,1) = 2
AND department_id = 50;

SELECT
    replace('100-001','-','%'),
    replace('100-001','-',''),
    replace('   100 001   ',' ','')
FROM dual;

SELECT
    salary,
    lpad(salary,10,'*'),
    lpad(salary,10,'0'),
    rpad(salary,10,'*')
FROM hr.employees;

SELECT
    salary,
    lpad('*',(salary/1000),'*')
FROM hr.employees;

SELECT
    45.926,
    round(46.926, 0),
    round(46.926),
    round(45.926,1),
    round(45.926,2),
    round(45.926,-1)
FROM dual;

SELECT
    45.926,
    trunc(46.926, 0),
    trunc(46.926),
    trunc(45.926,1),
    trunc(45.926,2),
    trunc(45.926,-1)
FROM dual;

SELECT
    trunc(10.1),
    ceil(10.1),
    floor(10.1),
    floor(10.0000001),
    floor(-10.000001)
FROM dual;

SELECT
    10/3,
    trunc(10/3), --몫
    mod(10,3) --나머지
FROM dual;

SELECT
    2*2*2,
    power(2,3) --거듭제곱
FROM dual;

SELECT
    abs(-100)
FROM dual;

SELECT
    sqrt(9)
FROM dual;

SELECT
    employee_id, last_name,salary, round(salary * 1.1) as "New Salary" 
FROM hr.employees;
