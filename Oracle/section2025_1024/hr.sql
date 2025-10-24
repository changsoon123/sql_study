SELECT *
FROM hr.employees
WHERE salary = (SELECT min(salary)
                FROM hr.employees
                );
                
SELECT *
FROM hr.employees
WHERE salary = (SELECT min(salary)
                FROM hr.employees
                GROUP BY department_id );
                
SELECT *
FROM hr.employees
WHERE salary IN (SELECT min(salary)
                FROM hr.employees
                GROUP BY department_id );

SELECT *
FROM hr.employees
WHERE salary > (SELECT salary -- 9000, 6000, 4800, 4800, 4200
                FROM hr.employees
                WHERE job_id = 'IT_PROG' );
                
SELECT *
FROM hr.employees
WHERE salary > ANY (SELECT salary -- 9000, 6000, 4800, 4800, 4200
                FROM hr.employees
                WHERE job_id = 'IT_PROG' ); 
                
SELECT *
FROM hr.employees
WHERE salary > ALL (SELECT salary -- 9000, 6000, 4800, 4800, 4200
                FROM hr.employees
                WHERE job_id = 'IT_PROG' );

SELECT *
FROM hr.employees
WHERE salary = ANY (SELECT salary -- 9000, 6000, 4800, 4800, 4200
                FROM hr.employees
                WHERE job_id = 'IT_PROG' );

SELECT *
FROM hr.employees
WHERE salary = ALL (SELECT salary -- 9000, 6000, 4800, 4800, 4200
                FROM hr.employees
                WHERE job_id = 'IT_PROG' );  
                

SELECT e.employee_id, e.last_name, e.salary, e.manager_id
FROM hr.employees e
WHERE e.employee_id IN (SELECT d.manager_id
                        FROM hr.employees d);
                        
SELECT e.employee_id, e.last_name, e.salary, e.manager_id
FROM hr.employees e
WHERE e.employee_id NOT IN (SELECT d.manager_id
                        FROM hr.employees d);

SELECT *
FROM hr.employees e
WHERE e.employee_id NOT IN (SELECT d.manager_id
                        FROM hr.employees d
                        WHERE d.manager_id IS NOT NULL);
                        
SELECT *
FROM hr.employees e
WHERE e.salary >     (SELECT avg(d.salary)
                        FROM hr.employees d
                        WHERE d.department_id =  e.department_id
                        );
                        
SELECT department_id, avg(salary)
FROM hr.employees
GROUP BY department_id;

SELECT *
FROM hr.employees e
WHERE EXISTS (SELECT 'x'
                        FROM hr.employees d
                        WHERE manager_id = e.employee_id);
                        
                        SELECT *
FROM hr.employees e
WHERE NOT EXISTS (SELECT 'x'
                        FROM hr.employees d
                        WHERE manager_id = e.employee_id);
        
SELECT * 
FROM hr.departments d
WHERE NOT EXISTS (SELECT 'x'
                        FROM hr.employees e
                        WHERE d.department_id = e.department_id);
                        
SELECT *
FROM hr.departments d 
WHERE EXISTS (SELECT 'x'
                        FROM hr.employees e
                        WHERE d.department_id = e.department_id);

SELECT department_id, avg(salary)
FROM hr.employees
GROUP BY department_id;


SELECT e1.department_id, e1.avg_sal
FROM (SELECT department_id, avg(salary) avg_sal
        FROM hr.employees
        GROUP BY department_id) e1, hr.employees e2
WHERE e1.department_id = e2.department_id
AND e2.salary > e1.avg_sal;

SELECT
    count(case when e2.department_id=10 then 'x' end) as "10",
    count(case when e2.department_id=20 then 'x' end) as "20",
    count(case when e2.department_id=30 then 'x' end) as "30",
    count(case when e2.department_id=40 then 'x' end) as "40",
    count(case when e2.department_id=50 then 'x' end) as "50",
    count(case when e2.department_id=60 then 'x' end) as "60",
    count(case when e2.department_id=70 then 'x' end) as "70",
    count(case when e2.department_id=80 then 'x' end) as "80",
    count(case when e2.department_id=90 then 'x' end) as "90",
    count(case when e2.department_id=100 then 'x' end) as "100",
    count(case when e2.department_id=110 then 'x' end) as "110",
    count(case when e2.department_id IS NULL then 'x' end) as "부서가 없는 사원"    
FROM(
SELECT department_id
FROM hr.departments
GROUP BY department_id
) e1, hr.employees e2
WHERE e1.department_id(+) = e2.department_id;

SELECT
       max(decode(dept_id, 10, cnt)) "10",
       max(decode(dept_id, 20, cnt)) "20",
       max(decode(dept_id, 30, cnt)) "30",
       max(decode(dept_id, 40, cnt)) "40",
       max(decode(dept_id, 50, cnt)) "50",
       max(decode(dept_id, 60, cnt)) "60",
       max(decode(dept_id, 70, cnt)) "70",
       max(decode(dept_id, 80, cnt)) "80",
       max(decode(dept_id, 90, cnt)) "90",
       max(decode(dept_id, 100, cnt)) "100",
       max(decode(dept_id, 110, cnt)) "110",
       max(decode(dept_id, null, cnt)) "부서가 없는 사원"
FROM (SELECT department_id dept_id, count(*) cnt
      FROM hr.employees
      GROUP BY department_id);

SELECT *
FROM(SELECT department_id
     FROM hr.employees
     )
PIVOT(count(*) FOR department_id IN(10,20,30,40,50,60,70,80,90,100,110,NULL as "부서가 없는 사원"));

SELECT department_id, sum(salary)
FROM hr.employees
GROUP BY department_id;

SELECT sum(salary)
from hr.employees
where depatment_id = 10;

SELECT *
FROM(SELECT department_id,salary
     FROM hr.employees
     )
PIVOT(sum(salary) FOR department_id IN(10,20,30,40,50,60,70,80,90,100,110,NULL as "부서가 없는 사원"));

SELECT *
FROM(SELECT department_id,sum(salary) sum_sal
     FROM hr.employees
     GROUP BY department_id
     )
PIVOT(sum(sum_sal) FOR department_id IN(10,20,30,40,50,60,70,80,90,100,110,NULL as "부서가 없는 사원"));

SELECT *
FROM(SELECT to_char(hire_date,'yyyy') year
     FROM hr.employees)
PIVOT(count(*) FOR year IN('2001' "2001",2002,2003,2004,2005,2006,2007,2008));

SELECT count(*)
FROM(SELECT to_char(hire_date,'yyyy') year
     FROM hr.employees)
WHERE year = 2001;

SELECT *
FROM(SELECT to_char(hire_date,'yyyy') year, count(*) cnt
     FROM hr.employees
     GROUP BY to_char(hire_date,'yyyy'))
PIVOT(max(cnt) FOR year IN(2001,2002,2003,2004,2005,2006,2007,2008));

SELECT *
FROM (
SELECT *
FROM(SELECT to_char(hire_date,'yyyy') year, count(*) cnt
     FROM hr.employees
     GROUP BY to_char(hire_date,'yyyy'))
PIVOT(max(cnt) FOR year IN(2001,2002,2003,2004,2005,2006,2007,2008)))
UNPIVOT(인원수 FOR 년도 IN("2001","2002","2003","2004","2005","2006","2007","2008"));