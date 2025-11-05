
var v_number number;

DECLARE
    v_co varchar2(30);
BEGIN

v_co := CASE 
                WHEN :v_number > 0 THEN '양수 입니다.'
                WHEN :v_number = 0 THEN '0 입니다.'
                WHEN :v_number < 0 THEN '음수입니다.'
                END;
    dbms_output.put_line('이 숫자는 ' || v_co );
END;
/



DECLARE
    v_num number := :b_id;
    BEGIN
    IF v_num > 0 THEN
    dbms_output.put_line('양수');
    ELSIF v_num = 0 THEN
    dbms_output.put_line('음수');
    ELSE
    dbms_output.put_line('0');
   END IF;
   END;
/

DECLARE
    v_num number := :b_id;
    BEGIN
    IF v_num > 0 THEN
    dbms_output.put_line('양수');
    ELSE
        IF v_num < 0 THEN
            dbms_output.put_line('음수');
        ELSE
            dbms_output.put_line('0');
        END IF;
    END IF;
   END;
/

DECLARE
    v_num number := :b_id;
    BEGIN
        CASE 
            WHEN v_num > 0 THEN
                dbms_output.put_line('양수');
            WHEN v_num = 0 THEN
                dbms_output.put_line('음수');
            ELSE
                dbms_output.put_line('0');
        END CASE;
   END;
/

DECLARE
    v_cnt number := 1;
BEGIN
    LOOP
            dbms_output.put_line(v_cnt);
            IF v_cnt = 10 THEN
                EXIT;
            END IF;
            v_cnt := v_cnt + 1;
    END LOOP;
    dbms_output.put_line('종료');
END;
/

DECLARE
    v_cnt number := 1;
BEGIN
    LOOP
        IF v_cnt NOT IN(4,8) THEN
        dbms_output.put_line(v_cnt);
        END IF;
            IF v_cnt = 10 THEN
                EXIT;
            END IF;
            v_cnt := v_cnt + 1;        
    END LOOP;
    dbms_output.put_line('종료');
END;
/

DECLARE
    v_cnt number := 1;
BEGIN
    LOOP
        IF v_cnt IN(4,8) THEN
            v_cnt := v_cnt + 1;
            CONTINUE;
        END IF;
        dbms_output.put_line(v_cnt);    
        v_cnt := v_cnt + 1;
        EXIT WHEN v_cnt > 10;
    END LOOP;
    dbms_output.put_line('종료');
END;
/

DECLARE
    v_cnt number := 0;
BEGIN
    LOOP
        v_cnt := v_cnt + 1;
        CONTINUE WHEN v_cnt IN(4,8);
        dbms_output.put_line(v_cnt);
        EXIT WHEN v_cnt = 10;
    END LOOP;
    dbms_output.put_line('종료');
END;
/

DECLARE
    v_cnt number := 1;
BEGIN
    LOOP
        IF v_cnt mod 2 = 1 THEN
        dbms_output.put_line(v_cnt);
        END IF;
        v_cnt := v_cnt + 1;
--        CONTINUE WHEN v_cnt mod 2 = 0;
        EXIT WHEN v_cnt > 10;
    END LOOP;
    dbms_output.put_line('종료');
END;
/

DECLARE
    v_cnt NUMBER := 0;
BEGIN
    LOOP
        v_cnt := v_cnt + 1;
        CONTINUE WHEN MOD(v_cnt, 2) = 0;
        DBMS_OUTPUT.PUT_LINE(v_cnt);
        EXIT WHEN v_cnt > 10;
    END LOOP;   
    DBMS_OUTPUT.PUT_LINE('종료');
END;
/

DECLARE
    v_cnt number := 2;
    v_num number := 1;
BEGIN
    LOOP
        dbms_output.put_line(v_cnt || '*' || v_num || '=' || v_cnt * v_num);
        v_num := v_num + 1;
        EXIT WHEN v_num = 10;
    END LOOP;
END;
/

DECLARE
    v_cnt number := 2;
    v_num number := 1;
BEGIN
    LOOP
        dbms_output.put_line(v_cnt || '*' || v_num || '=' || v_cnt * v_num);
        v_num := v_num + 1;
            IF v_num = 10 THEN
                v_cnt := v_cnt + 1;
                v_num := 1;
                EXIT WHEN v_cnt = 10;
            END IF;
        EXIT WHEN v_num = 10;
    END LOOP;
END;
/

DECLARE
    dan number := 2;
    i number;
BEGIN
    LOOP
        i := 1;
            LOOP
                dbms_output.put_line(dan || '*' || i || '=' || dan * i);
                EXIT WHEN i = 9;
                i := i + 1;
            END LOOP;
        EXIT WHEN dan = 9;
        dan := dan + 1;
    END LOOP;
END;
/

BEGIN
dbms_output.put_line('12345');
END;
/

DECLARE
    i number := 1;
BEGIN
    LOOP
        i := i + 1;
        EXIT WHEN i = 12345;
    END LOOP;
    dbms_output.put_line(i);
END;
/

DECLARE   
    i number := 1;
    v_string varchar2(10);
BEGIN
    LOOP
        v_string := v_string || i;
        EXIT WHEN i = 5;
        i := i + 1;
    END LOOP;
    dbms_output.put_line(v_string);
END;
/

DECLARE   
    i number := 1;
BEGIN
    LOOP
        dbms_output.put(i);
        EXIT WHEN i = 5;
        i := i + 1;
    END LOOP;
    dbms_output.new_line();
END;
/

DECLARE
    i number := 2;
    v number := 1;
BEGIN
    LOOP
        LOOP
            dbms_output.put(rpad(i || '*' || v || '=' || i*v ||' ',10,' '));
            EXIT WHEN i = 9;
            i := i + 1;
        END LOOP;
        dbms_output.new_line();
        EXIT WHEN v = 9;
        v := v + 1;
        i := 2; 
    END LOOP;
END;
/

DECLARE
    i number := 10;

BEGIN
    WHILE i > 0 LOOP
        dbms_output.put_line(i);
        i := i - 1;
    END LOOP;
END;
/

DECLARE
    i number := 1;
    v number := 1;
BEGIN
    WHILE i <= 9 LOOP
        i := i + 1;
        WHILE v <= 9 LOOP
            dbms_output.put_line(i || '*' || v || '=' || i*v);
            v := v + 1;
        END LOOP;
        v := 1;
    END LOOP;
END;
/

DECLARE
    i number := 1;
    v number := 1;
BEGIN
    WHILE TRUE LOOP
        i := i + 1;
        WHILE TRUE LOOP
            dbms_output.put_line(i || '*' || v || '=' || i*v);
            EXIT WHEN v = 9;
            v := v + 1;
        END LOOP;
        EXIT WHEN i = 9;
        v := 1;
    END LOOP;
END;
/


DECLARE
    i number := 2;
    v number := 1;
BEGIN
    WHILE i <= 9 LOOP
        WHILE v <= 9 LOOP
            dbms_output.put(rpad(i || '*' || v || '=' || i*v,10));
            v := v + 1;
        END LOOP;
        dbms_output.new_line();
        i := i + 1;
        v := 1;
    END LOOP;
END;
/

DECLARE
  
BEGIN

    FOR i IN 1..10 LOOP
    dbms_output.put_line(i);
    END LOOP;
END;
/

DECLARE
    v_start number := 1;
    v_end number := 10;
BEGIN

    FOR i IN v_start..v_end LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

DECLARE
    v_start number := 1;
    v_end number := 10;
BEGIN

    FOR i IN REVERSE v_start..v_end LOOP
        dbms_output.put_line(i);
    END LOOP;
END;
/

DECLARE
    v_start number := 1;
    v_end number := 9;
BEGIN

    FOR i IN REVERSE v_start..v_end LOOP
        FOR v IN REVERSE v_start..v_end LOOP
            EXIT WHEN i = 1;
            dbms_output.put_line( i || '*' || v || '=' || i * v);
        END LOOP;
    END LOOP;
END;
/

BEGIN
    FOR dan IN 2..9 LOOP
        FOR i IN 1..9 LOOP
            dbms_output.put_line(dan|| ' * ' || i ||' = ' || dan * i);
        END LOOP;
    END LOOP;
END;
/

BEGIN
    FOR i IN 1..9 LOOP
        FOR dan IN 2..9 LOOP
            dbms_output.put(dan|| ' * ' || i ||' = ' || rpad(dan * i,5));
        END LOOP;
        dbms_output.new_line();
    END LOOP;
END;
/