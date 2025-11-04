SELECT *
FROM v$reserved_words
WHERE reserved = 'Y';


ALTER SYSTEM FLUSH SHARED_POOL;

SELECT sql_id, sql_text, parse_calls, loads, executions, hash_value, plan_hash_value
FROM v$sql
WHERE sql_text like '%employees%'
AND sql_text not like '%v$sql%';

SELECT * FROM table(dbms_xplan.display_cursor('8nwhz4d5y0198'));
SELECT * FROM table(dbms_xplan.display_cursor('7s0rxjt3f50a9'));
SELECT * FROM table(dbms_xplan.display_cursor('01udx79f4fart'));
SELECT * FROM table(dbms_xplan.display_cursor('6dm3gu5ja6h0v'));

SELECT *
FROM v$reserved_words
WHERE reserved = 'Y';



var b_total number


DECLARE
               /* local variable(지역변수) : 선언된 블록 프로그램에서만 수행하는 변수*/
                 v_sal number := 10000;
                 v_comm number := 1000;
BEGIN
                 :b_total := v_sal + v_comm;
                 dbms_output.put_line(:b_total); 
END;
/

print :b_total
print b_total?

SELECT * FROM hr.employees WHERE salary > :b_total;

