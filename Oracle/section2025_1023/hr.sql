SELECT
    e.last_name, e.job_id, c.department_name, d.city
FROM hr.employees e, hr.departments c, hr.locations d
WHERE e.department_id = c.department_id --조인조건술어
AND d.location_id = c.location_id --조인조건술어
AND e.department_id = 80; --비조인조건술어

SELECT
    e.last_name, e.job_id, c.department_name
FROM hr.employees e, hr.departments c
WHERE e.department_id = c.department_id
AND e.department_id = 20;

SELECT count(*) FROM hr.employees WHERE department_id = 20;
SELECT * FROM hr.departments WHERE department_id = 20;

SELECT e.last_name, e.job_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id(+);

SELECT e.last_name, e.job_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id(+) = d.department_id;

SELECT e.last_name, e.job_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id(+) = d.department_id(+);

SELECT
    e.last_name, e.job_id, d.department_name, l.city
FROM hr.employees e, hr.departments d, hr.locations l
WHERE e.department_id = d.department_id(+)
AND d.location_id = l.location_id(+);

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w, hr.employees m
WHERE w.manager_id = m.employee_id(+);

SELECT employee_id, salary, j.grade_level
FROM hr.employees e, hr.job_grades j
WHERE e.salary >= j.lowest_sal
AND e.salary <= j.highest_sal;

SELECT employee_id, salary, j.grade_level
FROM hr.employees e, hr.job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

SELECT employee_id, salary, j.grade_level, d.department_name
FROM hr.employees e, hr.job_grades j, hr.departments d
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal
AND e.department_id = d.department_id;

SELECT employee_id, salary, j.grade_level, d.department_name
FROM hr.employees e, hr.job_grades j, hr.departments d
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal
AND e.department_id = d.department_id(+);

SELECT d.department_name, l.city
FROM hr.departments d, hr.locations l
WHERE d.location_id = l.location_id;

SELECT d.department_name, l.city
FROM hr.departments d NATURAL JOIN hr.locations l;

SELECT e.employee_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id
AND e.manager_id = d.manager_id;

SELECT e.employee_id, d.department_name
FROM hr.employees e NATURAL JOIN hr.departments d;

SELECT e.employee_id,e.last_name,e.job_id,d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id
AND e.employee_id = d.manager_id;

SELECT e.employee_id, location_id, d.department_name
FROM hr.employees e NATURAL JOIN hr.departments d;

SELECT e.employee_id, d.department_name
FROM hr.employees e NATURAL JOIN hr.departments d;

SELECT e.employee_id,d.department_name
FROM hr.employees e JOIN hr.departments d
USING(department_id);

SELECT e.employee_id,d.department_id,d.department_name
FROM hr.employees e JOIN hr.departments d
USING(department_id);

SELECT e.employee_id,d.department_name
FROM hr.employees e JOIN hr.departments d
USING(department_id)
WHERE department_id IN (10,20);

SELECT e.employee_id, department_id ,d.department_name, l.city
FROM hr.employees e JOIN hr.departments d
USING(department_id)
JOIN hr.locations l
USING(location_id)
WHERE department_id IN (10,20);

SELECT e.employee_id, d.department_name
FROM hr.employees e, hr.departments d
WHERE e.department_id = d.department_id;

SELECT e.employee_id, d.department_name
FROM hr.employees e JOIN hr.departments d
ON e.department_id = d.department_id;

SELECT e.employee_id, d.department_name, l.city
FROM hr.employees e JOIN hr.departments d
ON e.department_id = d.department_id
JOIN hr.locations l
ON d.location_id = l.location_id
WHERE e.department_id IN (10,20,30);

SELECT employee_id, salary, j.grade_level
FROM hr.employees e, hr.job_grades j
WHERE e.salary >= j.lowest_sal
AND e.salary <= j.highest_sal;

SELECT employee_id, salary, j.grade_level
FROM hr.employees e, hr.job_grades j
WHERE e.salary BETWEEN j.lowest_sal AND j.highest_sal;

SELECT employee_id, salary, j.grade_level
FROM hr.employees e JOIN  hr.job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

SELECT employee_id, salary, j.grade_level
FROM hr.employees e, hr.job_grades j
WHERE e.salary >= j.lowest_sal
AND e.salary <= j.highest_sal;

SELECT employee_id, salary, j.grade_level
FROM hr.employees e JOIN hr.job_grades j
ON e.salary >= j.lowest_sal
AND e.salary <= j.highest_sal;

SELECT employee_id,last_name, salary, j.grade_level
FROM hr.employees e JOIN hr.job_grades j
ON e.salary >= j.lowest_sal
AND e.salary <= j.highest_sal
WHERE last_name LIKE '%a%';

SELECT employee_id,last_name, salary, j.grade_level
FROM hr.employees e JOIN hr.job_grades j
ON (e.salary >= j.lowest_sal AND e.salary <= j.highest_sal)
WHERE last_name LIKE '%a%';

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w, hr.employees m
WHERE w.manager_id = m.employee_id(+);

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w JOIN hr.employees m
ON w.manager_id = m.employee_id(+);

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w INNER JOIN hr.employees m
ON w.manager_id = m.employee_id;

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w, hr.employees m
WHERE w.manager_id = m.employee_id(+);

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w LEFT OUTER JOIN hr.employees m
ON w.manager_id = m.employee_id;

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w, hr.employees m
WHERE w.manager_id(+) = m.employee_id;

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w RIGHT OUTER JOIN hr.employees m
ON w.manager_id = m.employee_id;

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w, hr.employees m
WHERE w.manager_id(+) = m.employee_id(+); --오류

SELECT w.employee_id, w.last_name, m.employee_id, m.last_name
FROM hr.employees w FULL OUTER JOIN hr.employees m
ON w.manager_id = m.employee_id;

SELECT
    e.last_name, e.job_id, d.department_name, l.city
FROM hr.employees e, hr.departments d, hr.locations l
WHERE e.department_id = d.department_id(+)
AND d.location_id = l.location_id(+);

SELECT e.last_name, e.job_id, d.department_name , l.city
FROM hr.employees e LEFT OUTER JOIN hr.departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN hr.locations l
ON d.location_id = l.location_id;

SELECT e.last_name, e.job_id, d.department_name
FROM hr.employees e, hr.departments d;

SELECT e.last_name, e.job_id, d.department_name
FROM hr.employees e CROSS JOIN hr.departments d;

SELECT d.department_name, round(sum(e.salary)) as "sum", round(avg(e.salary)) as "avg"
FROM hr.employees e , hr.departments d
WHERE e.department_id = d.department_id
AND e.hire_date >= to_date('2006-01-01','yyyy-mm-dd') AND e.hire_date < to_date('2007-01-01','yyyy-mm-dd')
GROUP BY d.department_name;

SELECT d.department_name, round(sum(e.salary)) as "sum", round(avg(e.salary)) as "avg"
FROM hr.employees e INNER JOIN hr.departments d
ON e.department_id = d.department_id
WHERE e.hire_date >= to_date('2006-01-01','yyyy-mm-dd') AND e.hire_date < to_date('2007-01-01','yyyy-mm-dd')
GROUP BY d.department_name;

SELECT l.city, round(sum(e.salary)) as "sum", round(avg(e.salary)) as "avg"
FROM hr.employees e , hr.departments d, locations l
WHERE e.department_id = d.department_id(+)
AND l.location_id(+) = d.location_id
AND e.hire_date >= to_date('2007-01-01','yyyy-mm-dd') AND e.hire_date < to_date('2008-01-01','yyyy-mm-dd')
GROUP BY l.city;

SELECT l.city, round(sum(e.salary)) as "sum", round(avg(e.salary)) as "avg"
FROM hr.employees e LEFT OUTER JOIN hr.departments d
ON e.department_id = d.department_id
LEFT OUTER JOIN  locations l
ON l.location_id = d.location_id
WHERE e.hire_date >= to_date('2007-01-01','yyyy-mm-dd') AND e.hire_date < to_date('2008-01-01','yyyy-mm-dd')
GROUP BY l.city;

SELECT
    e.employee_id, e.last_name,e.first_name, e.hire_date, l.last_name as "이름" , l.first_name as "성"
FROM hr.employees e, hr.employees l
WHERE e.manager_id = l.employee_id
AND e.hire_date < l.hire_date;

SELECT
    e.employee_id, e.last_name,e.first_name, e.hire_date, l.last_name as "이름" , l.first_name as "성"
FROM hr.employees e JOIN hr.employees l
ON e.manager_id = l.employee_id
AND e.hire_date < l.hire_date;


SELECT
    *
FROM hr.employees
WHERE salary > (
                SELECT salary
                FROM hr.employees
                WHERE employee_id = 110 );
                
SELECT
    *
FROM hr.employees
WHERE salary > (
                SELECT salary
                FROM hr.employees
                WHERE last_name = 'King' );
                
SELECT
    *
FROM hr.employees
WHERE salary > (
                SELECT salary
                FROM hr.employees
                WHERE last_name = 'Davies' );
                
SELECT
    *
FROM hr.employees
WHERE job_id = (
                SELECT job_id
                FROM hr.employees
                WHERE employee_id = 110 )
AND salary > (
                SELECT salary
                FROM hr.employees
                WHERE employee_id = 110 );               
                
SELECT
    e.employee_id, e.last_name,e.salary
FROM hr.employees e
WHERE salary = (
            SELECT max(salary)
            FROM hr.employees
);

SELECT
    e.employee_id, e.last_name,e.salary
FROM hr.employees e
WHERE salary = (
            SELECT min(salary)
            FROM hr.employees
);

SELECT department_id, sum(salary)
FROM hr.employees
GROUP BY department_id
HAVING sum(salary) > (SELECT min(salary) FROM hr.employees WHERE department_id = 40);

SELECT department_id, avg(salary)
FROM hr.employees
GROUP BY department_id
HAVING avg(salary) = (SELECT min(avg(salary)) FROM hr.employees GROUP BY department_id);

