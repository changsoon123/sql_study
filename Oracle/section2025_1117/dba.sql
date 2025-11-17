

CREATE OR REPLACE TRIGGER no_drop_truncate
BEFORE
DROP OR TRUNCATE ON DATABASE
BEGIN
    RAISE_APPLICATION_ERROR(-20000,'DROP OR TRUNCATE 할 수 없습니다.');
END no_drop_truncate;
/

DROP TABLE hr.dept PURGE;

DROP TABLE hr.emp PURGE;

DROP TRIGGER no_drop_truncate;

CREATE OR REPLACE TRIGGER hr_drop_truncate
BEFORE
DROP OR TRUNCATE ON hr.schema
BEGIN
RAISE_APPLICATION_ERROR(-20000,'DROP OR TRUNCATE 할 수 없습니다.');
END hr_drop_truncate;
/

TRUNCATE TABLE hr.emp;

DROP TABLE hr.emp;

SELECT * FROM dba_triggers WHERE trigger_name = 'HR_DROP_TRUNCATE';

DROP TRIGGER hr_drop_truncate;

CREATE TABLE ddl_obj_log
(ddl_user varchar2(30),
obj_user varchar2(30),
obj_name varchar2(30),
obj_type varchar2(30),
ddl_time timestamp,
sql_text varchar2(100))
TABLESPACE users;

CREATE OR REPLACE TRIGGER ddl_trigger
BEFORE
CREATE OR ALTER OR DROP OR TRUNCATE ON DATABASE
DECLARE
    sql_text ora_name_list_t;
    n pls_integer;
    v_stmt varchar2(100);
BEGIN
        n := ora_sql_txt(sql_text);
        FOR i IN 1..n LOOP
            v_stmt := v_stmt || sql_text(i);            
        END LOOP;
        
        INSERT INTO sys.ddl_obj_log(ddl_user, obj_user , obj_name, obj_type, ddl_time, sql_text)
        VALUES(ora_login_user, ora_dict_obj_owner, ora_dict_obj_name,ora_dict_obj_type, systimestamp,v_stmt);
    
END ddl_trigger;
/


SELECT * FROM ddl_obj_log;

SELECT * FROM dba_segments WHERE segment_name = 'DDL_OBJ_LOG';