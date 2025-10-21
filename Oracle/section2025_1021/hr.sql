SELECT
    sysdate,
    systimestamp,
    current_date,
    current_timestamp,
    localtimestamp
FROM dual;

ALTER SESSION SET TIME_ZONE = '+09:00';

SELECT
    sysdate + 100,
    sysdate - 100
FROM dual;

SELECT
    employee_id,
    hire_date,
    trunc(sysdate - hire_date),
    sysdate + sysdate --오류 발생
FROM hr.employees;

SELECT
    systimestamp,
    to_char(systimestamp + 10/24,'yyyy-mm-dd hh24:mi:ss'),
    to_char(localtimestamp + 10/24,'yyyy-mm-dd hh24:mi:ss'),
    to_char(current_timestamp + 10/24,'yyyy-mm-dd hh24:mi:ss')
FROM dual;

SELECT
    employee_id,
    hire_date,
    trunc(sysdate - hire_date), --근무일수
    trunc(months_between(sysdate,hire_date)) --근무 개월수
FROM hr.employees;

SELECT
    sysdate,
    add_months(sysdate, 5),
    add_months(sysdate, -5)
FROM dual;

SELECT * FROM nls_session_parameters;
SELECT
    sysdate,
    next_day(sysdate, '금요일')
FROM dual;

SELECT
    sysdate,
    last_day(sysdate)
FROM dual;

SELECT
    sysdate,
    last_day(add_months(sysdate,1))
FROM dual;

SELECT
    systimestamp,
    trunc(systimestamp, 'month'), --달의 시작일
    trunc(systimestamp, 'year'), --년의 시작일
    to_char(trunc(systimestamp), 'yyyy-mm-dd hh24:mi:ss.sssss') -- 그날의 자정
FROM dual;

SELECT
    sysdate,
    round(sysdate, 'month'), 
    round(sysdate, 'year'), 
    to_char(round(sysdate), 'yyyy-mm-dd hh24:mi:ss.sssss') 
FROM dual;

SELECT
    employee_id,
    trunc(months_between(sysdate,hire_date)/12)
FROM hr.employees
WHERE trunc(months_between(sysdate,hire_date))/12 >= 20;

SELECT
    last_name,
    hire_date,
    next_day(add_months(sysdate,6),'월요일') as "REVIEW"
FROM hr.employees;

SELECT * FROM nls_session_parameters;
SELECT
    sysdate,
    to_char(sysdate,'yyyy-mm-dd hh24:mm:ss.sssss')
FROM dual;

SELECT
    sysdate,
    to_char(sysdate,'mm mon month')
FROM dual;

SELECT
    sysdate,
    to_char(sysdate,'d dd ddd')
FROM dual;

SELECT
    sysdate,
    to_char(sysdate,'hh hh12 hh24')
FROM dual;

SELECT
    to_char(sysdate, 'day dy d' )
FROM dual;

SELECT
    to_char(sysdate, 'ww w' )
FROM dual;

SELECT
    to_char(sysdate, 'q' ),
    to_char(sysdate,'q')||'분기',
    to_char(sysdate,'q"분기"')
FROM dual;

SELECT
    sysdate,
    to_char(sysdate, 'ddsp' ),
    to_char(sysdate, 'ddth' ),
    to_char(sysdate, 'ddthsp' )
FROM dual;

SELECT
    employee_id,
    to_char(hire_date,'day') as day
FROM hr.employees
ORDER BY day; -- 문자열 기준

SELECT
    employee_id,
    to_char(hire_date,'day')
FROM hr.employees
ORDER BY to_char(hire_date,'d'); --숫자요일 기준

SELECT
    employee_id,
    to_char(hire_date,'day')
FROM hr.employees
ORDER BY to_char(hire_date-1,'d');

SELECT
    salary,
    to_char(salary, '$999,999.00'),
    to_char(salary, '$000,999.00'),
    to_char(salary, '$999G999D00'),
    to_char(salary, '$000G999D00'),
    to_char(salary, 'L000G999D00')
FROM hr.employees;

SELECT * FROM nls_session_parameters;

SELECT
    100,
    -100,
    to_char(-100,'999mi'),
    to_char(-100,'999pr'),
    to_char(-100,'s999')
FROM dual;

ALTER SESSION SET nls_language = american;
ALTER SESSION SET nls_territory = america;

ALTER SESSION SET nls_language = korean;
ALTER SESSION SET nls_territory = korea;

ALTER SESSION SET nls_language = japanese;
ALTER SESSION SET nls_territory = japan;

ALTER SESSION SET nls_language = french;
ALTER SESSION SET nls_territory = france;

SELECT * FROM nls_session_parameters;

SELECT
    employee_id,
    salary,
    hire_date,
    to_char(hire_date, 'day month mon'),
    to_char(salary, 'L999G999D00')
FROM hr.employees;

SELECT
    employee_id
FROM hr.employees
WHERE to_char(hire_date, 'yyyy') = 2006
AND mod(to_char(hire_date,'mm'),2) = 1;

SELECT *
FROM hr.employees
WHERE hire_date >= to_date('2006-01-01', 'yyyy-mm-dd')
AND hire_date < to_date('2007-01-01', 'yyyy-mm-dd')
AND mod(to_number(to_char(hire_date,'mm')),2) = 1;

SELECT
    to_char(hire_date,'mm'),
    to_number(to_char(hire_date,'mm'))
FROM hr.employees;

SELECT
    to_number('1') + 2,
    to_number('1','9') + 2
FROM dual;

SELECT
    to_char(to_date('95-10-27','yy-mm-dd'),'yyyy-mm-dd'),
    to_char(to_date('95-10-27','rr-mm-dd'),'yyyy-mm-dd')
FROM dual;

SELECT * FROM nls_session_parameters;

SELECT
    employee_id,
    salary,
    commission_pct,
    salary * 12 + salary * 12 * commission_pct ann_sal_1,
    salary * 12 + salary * 12 * nvl(commission_pct,0) ann_sal_2
FROM hr.employees;

SELECT
    employee_id,
    salary,
    commission_pct,
    nvl(commission_pct,0),
    nvl(to_char(commission_pct), 'no comm')
FROM hr.employees;

SELECT
    employee_id,
    salary,
    commission_pct,
    nvl2(commission_pct, salary * 12 + salary * 12 * commission_pct, salary * 12) ann_sal_3,
    nvl2(commission_pct, to_char(salary * 12) , 'no comm')
FROM hr.employees;

SELECT
    employee_id,
    salary,
    commission_pct,
    coalesce(salary * 12 + salary * 12 * commission_pct, salary * 12 , 0) ann_sal
FROM hr.employees;