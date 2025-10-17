SELECT * from user_users;

SELECT *
FROM hr.employees;

SELECT * FROM hr.employees;

SELECT * 
FROM employees;

SELECT employee_id, last_name, salary
FROM hr.employees;

SELECT *
FROM hr.employees
WHERE employee_id = 100;

SELECT /*+ full(e) */ *
FROM hr.employees e
WHERE employee_id = 100;

desc hr.employees;

SELECT salary, salary * 12
FROM hr.employees;

SELECT hire_date, hire_date + 100, hire_date - 100
FROM hr.employees;

SELECT a * b / c + d - e
FROM dual;

SELECT ((((a * b) / c) + d) - e)
FROM dual;

SELECT
        employee_id,
        salary,
        commission_pct,
        salary * 12 + salary * 12 * nvl(commission_pct,0)
FROM hr.employees;

-- PL/SQL ¹®¹ý
IF commision_pct is null THEN
    RETURN 0;
ELSE
    RETURN commission_pct;
END IF;