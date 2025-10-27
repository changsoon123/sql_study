


SELECT
    to_char(hire_date, 'yyyy') 년도,
    sum(decode(to_char(hire_date,'q'), 1, salary)) "1분기",
    sum(decode(to_char(hire_date,'q'), 2, salary)) "2분기",
    sum(decode(to_char(hire_date,'q'), 3, salary)) "3분기",
    sum(decode(to_char(hire_date,'q'), 4, salary)) "4분기"
FROM hr.employees
GROUP BY to_char(hire_date,'yyyy')
ORDER BY 1;

SELECT
    to_char(hire_date, 'yyyy') 년도,
    sum(case to_char(hire_date,'q') when '1' then salary END) "1분기",
    sum(case to_char(hire_date,'q') when '2' then salary END) "2분기",
    sum(case to_char(hire_date,'q') when '3' then salary END) "3분기",
    sum(case to_char(hire_date,'q') when '4' then salary END) "4분기"
FROM hr.employees
GROUP BY to_char(hire_date,'yyyy')
ORDER BY 1;

SELECT *
    FROM(
    SELECT to_char(hire_date, 'yyyy') 년도, to_char(hire_date,'q') 분기, salary
    FROM hr.employees
    )
PIVOT(sum(salary) FOR 분기 IN('1' as "1분기",'2' as "2분기",'3' as "3분기",'4' as "4분기"))
ORDER BY 1;

SELECT *
    FROM(
    SELECT to_char(hire_date, 'yyyy') 년도, to_char(hire_date,'q') 분기, sum(salary) 총액
    FROM hr.employees
    GROUP BY to_char(hire_date, 'yyyy'),to_char(hire_date,'q')
    )
PIVOT(max(총액) FOR 분기 IN('1' as "1분기",'2' as "2분기",'3' as "3분기",'4' as "4분기"))
ORDER BY 1;


SELECT *
FROM hr.employees
WHERE (manager_id, department_id) IN (SELECT manager_id, department_id
                                      FROM hr.employees
                                      WHERE first_name = 'John');

SELECT *
FROM hr.employees
WHERE manager_id IN (SELECT manager_id
                                      FROM hr.employees
                                      WHERE first_name = 'John')
AND department_id IN (SELECT department_id
                                      FROM hr.employees
                                      WHERE first_name = 'John');
                                      
        

SELECT *
FROM hr.employees
WHERE (department_id,salary) IN (SELECT
                                    department_id,salary
                                FROM hr.employees
                                WHERE commission_pct IS NOT NULL);

SELECT *
FROM hr.employees
WHERE (nvl(department_id,0),salary) IN (SELECT
                                    nvl(department_id,0),salary
                                FROM hr.employees
                                WHERE commission_pct IS NOT NULL);

SELECT *
FROM hr.employees
WHERE nvl(department_id,0) IN (SELECT
                                   nvl(department_id,0)
                                FROM hr.employees
                                WHERE commission_pct IS NOT NULL)
AND salary IN          (SELECT salary
                                FROM hr.employees
                                WHERE commission_pct IS NOT NULL);
                                
                                
                                
                                
SELECT *
FROM hr.employees
WHERE (salary,nvl(commission_pct,0)) IN (SELECT e.salary,nvl(e.commission_pct,0)
                                FROM hr.employees e, hr.departments l
                                WHERE e.department_id = l.department_id
                                AND l.location_id = 1700
                                );
                                
SELECT *
FROM hr.employees
WHERE salary IN (SELECT e.salary
                                FROM hr.employees e, hr.departments l
                                WHERE e.department_id = l.department_id
                                AND l.location_id = 1700
                                )
AND nvl(commission_pct,0) IN (SELECT nvl(e.commission_pct,0)
                                FROM hr.employees e, hr.departments l
                                WHERE e.department_id = l.department_id
                                AND l.location_id = 1700
                                );
                                
                                
                                
SELECT e.employee_id, e.department_id, d.department_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id
ORDER BY 2,3;

SELECT distinct department_id
FROM hr.employees;

SELECT employee_id, department_id, (SELECT department_name
                                    FROM hr.departments
                                    WHERE department_id = e.department_id)
FROM hr.employees e
ORDER BY 2;

SELECT distinct department_id
FROM hr.employees;

SELECT
     l.department_name,sum(salary),avg(salary)
FROM hr.employees e, hr.departments l
WHERE e.department_id = l.department_id
GROUP BY l.department_name;

SELECT
    d.department_name,e.sum_sal,e.avg_sal
FROM (SELECT department_id,sum(salary) sum_sal, avg(salary) avg_sal
                            FROM hr.employees
                            GROUP BY department_id) e, hr.departments d
WHERE e.department_id = d.department_id;

SELECT
    d.department_name,
    (SELECT sum(e.salary)
        FROM hr.employees e
        WHERE e.department_id = d.department_id) as "sum",
        (SELECT avg(e.salary)
        FROM hr.employees e
        WHERE e.department_id = d.department_id) as "avg"
FROM hr.departments d;

SELECT department_name,substr(sal,1,10) sum_sal, substr(sal,11) avg_sal
FROM(
        SELECT
            d.department_name,
            (SELECT lpad(sum(salary),10) || lpad(round(avg(salary)),10)
                FROM hr.employees
                WHERE department_id = d.department_id) sal
        FROM hr.departments d)
WHERE sal IS NOT NULL;

SELECT
    e.employee_id, e.last_name
FROM hr.employees e, hr.departments l
WHERE e.department_id = l.department_id
ORDER BY department_name ASC;

SELECT
    employee_id,
    last_name,
    (SELECT department_name
    FROM hr.departments
    WHERE department_id = e.department_id)
FROM hr.employees e
ORDER BY 3;

SELECT
    employee_id,
    last_name
FROM hr.employees e
ORDER BY (SELECT department_name
    FROM hr.departments
    WHERE department_id = e.department_id);

SELECT employee_id, job_id, salary
FROM hr.employees
UNION
SELECT employee_id, job_id, NULL
FROM hr.job_history;

SELECT employee_id, job_id, salary
FROM hr.employees
UNION
SELECT employee_id, job_id, 0
FROM hr.job_history;

SELECT employee_id, job_id, salary
FROM hr.employees
UNION ALL
SELECT employee_id, job_id, 0
FROM hr.job_history;

SELECT employee_id, job_id
FROM hr.employees
INTERSECT
SELECT employee_id, job_id
FROM hr.job_history;

SELECT *
FROM hr.employees
WHERE employee_id = 176;

SELECT employee_id
FROM hr.employees
MINUS
SELECT employee_id
FROM hr.job_history;

SELECT employee_id, job_id, salary
FROM hr.employees
MINUS
SELECT employee_id id, job_id, NULL
FROM hr.job_history
ORDER BY id;

SELECT e.employee_id, e.last_name, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
UNION
SELECT e.employee_id, e.last_name, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.employee_id, e.last_name, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
UNION ALL
SELECT null,null,department_name
FROM hr.departments d
WHERE NOT EXISTS (SELECT 'x' FROM hr.employees WHERE department_id = d.department_id);

SELECT e.employee_id, e.last_name, d.department_name
FROM hr.employees e FULL OUTER JOIN hr.departments d
ON e.department_id = d.department_id;

SELECT e.employee_id, e.last_name, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+)
UNION ALL
SELECT null,null,department_name
FROM hr.departments d
WHERE NOT EXISTS (SELECT 'x' FROM hr.employees WHERE department_id = d.department_id);

-- 방법 1: INTERSECT
SELECT employee_id, job_id
FROM hr.employees
INTERSECT
SELECT employee_id, job_id
FROM hr.job_history;

-- 방법 2: EXISTS (완전히 동일한 결과)
SELECT e.employee_id, e.job_id
FROM hr.employees e
WHERE EXISTS (
    SELECT 1 FROM hr.job_history jh
    WHERE jh.employee_id = e.employee_id
      AND jh.job_id = e.job_id
);

-- MINUS와 동일 (중복 제거)
SELECT employee_id, job_id
FROM hr.employees
MINUS
SELECT employee_id, job_id
FROM hr.job_history;

-- 중복을 포함하고 싶다면 NOT EXISTS 사용
SELECT e.employee_id, e.job_id
FROM hr.employees e
WHERE NOT EXISTS (
    SELECT 1 FROM hr.job_history jh
    WHERE jh.employee_id = e.employee_id
      AND jh.job_id = e.job_id
);