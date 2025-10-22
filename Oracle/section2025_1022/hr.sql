SELECT
    employee_id,
    length(last_name),
    length(first_name),
    nullif(length(last_name),length(first_name))
FROM hr.employees;

SELECT *
FROM hr.employees
WHERE department_id <> 50;

SELECT *
FROM hr.employees
WHERE department_id = 50
OR department_id is null;

SELECT *
FROM hr.employees
WHERE LNNVL(department_id <> 50);

SELECT
    employee_id,
    salary,
    job_id,
    decode(job_id, 'IT_PROG',salary * 1.1,'ST_CLERK', salary * 1.2, 'SA_REP', salary *1.3, salary) as pre_salary
FROM hr.employees;

SELECT
    employee_id,
    salary,
    job_id,
    decode(job_id, 'IT_PROG', decode(to_char(hire_date,'yyyy'),'2005',salary * 1.15, salary*1.1),
                   'ST_CLERK', salary * 1.2, 'SA_REP', salary *1.3, salary) as pre_salary
FROM hr.employees;

SELECT
    employee_id,
    salary,
    job_id,
    hire_date,
    case job_id
        when 'IT_PROG' then case when to_char(hire_date,'yyyy') = '2005' then salary * 1.15 else salary * 1.1 end
        when 'ST_CLERK' then salary * 1.2
        when 'SA_REP' then salary *1.3
        else salary 
    end pre_salary
FROM hr.employees;

SELECT
    employee_id,
    salary,
    job_id,
    case 
        when salary <= 4999 then 'low'
        when salary between 5000 and 9999 then 'medium'
        when salary between 10000 and 19999 then 'good'
        else 'excellent'        
    end as grade
FROM hr.employees;

SELECT
    employee_id,
    salary,
    commission_pct,
    salary * 12 + salary * 12 * nvl(commission_pct,0) ann_sal_1,
    nvl2(commission_pct, salary * 12 + salary * 12 * commission_pct, salary * 12) ann_sal_2
FROM hr.employees;

SELECT
    employee_id,
    salary,
    commission_pct,
    salary * 12 + salary * 12 * nvl(commission_pct,0) ann_sal_1,
    nvl2(commission_pct, salary * 12 + salary * 12 * commission_pct, salary * 12) ann_sal_2,
    decode(commission_pct, null, salary*12, salary * 12 + salary * 12 * commission_pct) ann_sal_3,
    case when commission_pct is null then salary*12 else salary * 12 + salary * 12 * commission_pct END
FROM hr.employees;

SELECT count(*) FROM hr.employees;

SELECT count(department_id) FROM hr.employees;

SELECT count(commission_pct) FROM hr.employees;

SELECT count(distinct department_id) FROM hr.employees;
SELECT count(unique department_id) FROM hr.employees;

SELECT count(*)
FROM hr.employees
WHERE department_id = 50;

SELECT sum(salary) FROM hr.employees;

SELECT avg(salary) FROM hr.employees;

SELECT avg(salary) 
FROM hr.employees
WHERE department_id = 50; 

SELECT avg(commission_pct) FROM hr.employees;
SELECT avg(nvl(commission_pct,0)) FROM hr.employees;

SELECT median(salary) FROM hr.employees;

SELECT variance(salary) FROM hr.employees;

SELECT stddev(salary) FROM hr.employees;


SELECT max(salary) , min(salary), max(salary) - min(salary) 범위
FROM hr.employees;

SELECT
    count(last_name),
    count(hire_date),
    max(last_name),
    max(hire_date),
    min(last_name),    
    min(hire_date)
FROM hr.employees;


SELECT department_id, sum(salary)
FROM hr.employees
GROUP BY department_id;

SELECT department_id,job_id,sum(salary)
FROM hr.employees
GROUP BY department_id,job_id;

SELECT department_id,job_id job,sum(salary)
FROM hr.employees
GROUP BY department_id,job;

SELECT department_id,job_id,sum(salary)
FROM hr.employees
WHERE sum(salary) >= 15000
GROUP BY department_id,job_id;

SELECT department_id,job_id,sum(salary)
FROM hr.employees
GROUP BY department_id,job_id
HAVING sum(salary) >= 15000;

SELECT department_id, count(*)
FROM hr.employees
GROUP BY department_id;

SELECT department_id, sum(salary)
FROM hr.employees
GROUP BY department_id
HAVING count(*) >= 5;

SELECT department_id, sum(salary)
FROM hr.employees
GROUP BY department_id
HAVING sum(salary) >= 10000;

SELECT department_id, sum(salary)
FROM hr.employees
WHERE last_name like '%i%'
GROUP BY department_id
HAVING sum(salary) >= 10000
ORDER BY 1;

SELECT department_id, max(sum(salary))
FROM hr.employees
GROUP BY department_id;

SELECT max(sum(salary))
FROM hr.employees
GROUP BY department_id;

SELECT department_id, sum(salary)
FROM hr.employees
GROUP BY department_id
HAVING department_id in (50,60,70);

SELECT job_id, count(*)
FROM hr.employees
WHERE hire_date >= to_date('2008-01-01','yyyy-mm-dd') AND hire_date < to_date('2009-01-01','yyyy-mm-dd')
Group BY job_id
ORDER BY count(*) DESC;

SELECT to_char(hire_date,'yyyy'), count(*)
FROM hr.employees
Group BY to_char(hire_date,'yyyy');

SELECT 
    count(*) TOTAL,
    count(case when to_char(hire_date,'yyyy') = '2001' then 'x' end) "2001년",
    count(decode(to_char(hire_date,'yyyy'),'2002','x')) "2002년",
    count(decode(to_char(hire_date,'yyyy'),'2003','x')) "2003년"
FROM hr.employees;

SELECT count(*) from hr.employees;
SELECT count(*) from hr.departments;

SELECT employee_id, department_name
FROM hr.employees, hr.departments;

SELECT e.employee_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id; 

SELECT e.employee_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, d.department_name, p.city
FROM hr.employees e, hr.departments d, hr.locations p
WHERE e.department_id = d.department_id
AND p.location_id = d.location_id
AND e.department_id = 90; 

SELECT e.employee_id, d.department_name, p.city, o.country_name
FROM hr.employees e, hr.departments d, hr.locations p, hr.countries o
WHERE e.department_id = d.department_id
AND p.location_id = d.location_id
AND o.country_id = p.country_id;

select sum(salary)
from hr.employees;