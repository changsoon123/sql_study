CREATE OR REPLACE FUNCTION verify_function_itwill
(username varchar2,
  new_password varchar2,
  old_password varchar2)
  RETURN boolean
IS
   m integer;
   differ integer;
   isdigit boolean;
   ischar  boolean;
   isUpper boolean;
   isSpecial boolean;
   db_name varchar2(40);
   digitarray varchar2(20);
   chararray varchar2(52);
   upperarray varchar2(26);
   specialarray varchar2(10);
   simple_password varchar2(10);
   reverse_user varchar2(32);

BEGIN
   digitarray:= '0123456789';
   chararray:= 'abcdefghijklmnopqrstuvwxyz';
   upperarray := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   specialarray := '~!#$%^&*?';

   IF length(new_password) < 8 THEN
      raise_application_error(-20001, 'Password length less than 8');
   END IF;

   IF NLS_LOWER(new_password) = NLS_LOWER(username) THEN
     raise_application_error(-20002, 'Password same as or similar to user');
   END IF;
   FOR i IN 1..1000 LOOP
        IF NLS_LOWER(username)|| to_char(i) = NLS_LOWER(new_password) THEN
            raise_application_error(-20005, 'Password same as or similar to user name ');
        END IF;
    END LOOP;

 
   FOR i in REVERSE 1..length(username) LOOP
     reverse_user := reverse_user || substr(username, i, 1);
   END LOOP;
   IF NLS_LOWER(new_password) = NLS_LOWER(reverse_user) THEN
     raise_application_error(-20003, 'Password same as username reversed');
   END IF;

   
   SELECT name INTO db_name FROM SYS.v$database;
   IF NLS_LOWER(db_name) = NLS_LOWER(new_password) THEN
      raise_application_error(-20004, 'Password same as or similar to db name');
   END IF;
   FOR i IN 1..1000 LOOP
      IF NLS_LOWER(db_name)|| to_char(i) = NLS_LOWER(new_password) THEN
        raise_application_error(-20005, 'Password same as or similar to db name');
      END IF;
    END LOOP;

   IF NLS_LOWER(new_password) IN ('welcome1', 'database1', 'account1', 'user1234', 'password1', 'oracle123', 'computer1', 'abcdefg1', 'change_on_install','happy1234') THEN
      raise_application_error(-20006, 'Password too simple');
   END IF;


    simple_password := 'oracle';
    FOR i IN 1..1000 LOOP
      IF simple_password || to_char(i) = NLS_LOWER(new_password) THEN
        raise_application_error(-20007, 'Password too simple');
      END IF;
    END LOOP;

   simple_password := 'itwill';
    FOR i IN 1..1000 LOOP
      IF simple_password || to_char(i) = NLS_LOWER(new_password) THEN
        raise_application_error(-20007, 'Password too simple');
      END IF;
    END LOOP;
   
 
   isdigit:=FALSE;
   m := length(new_password);
   FOR i IN 1..10 LOOP
      FOR j IN 1..m LOOP
         IF substr(new_password,j,1) = substr(digitarray,i,1) THEN
            isdigit:=TRUE;
             GOTO findchar;
         END IF;
      END LOOP;
   END LOOP;

   IF isdigit = FALSE THEN
      raise_application_error(-20008, 'Password must contain at least one digit, one character');
   END IF;
 
   <<findchar>>
   ischar:=FALSE;
   FOR i IN 1..length(chararray) LOOP
      FOR j IN 1..m LOOP
         IF substr(new_password,j,1) = substr(chararray,i,1) THEN
            ischar:=TRUE;
             GOTO findUpper;
         END IF;
      END LOOP;
   END LOOP;
   IF ischar = FALSE THEN
      raise_application_error(-20009, 'Password must contain at least one digit, and one character');
   END IF;

   <<findUpper>>
   isUpper := FALSE;
   FOR i IN 1..LENGTH(upperarray) LOOP
      FOR j IN 1..LENGTH(new_password) LOOP
         IF SUBSTR(new_password,j,1) = SUBSTR(upperarray,i,1) THEN
            isUpper := TRUE;
            GOTO findSpecial;
         END IF;
      END LOOP;
   END LOOP;
   IF isUpper = FALSE THEN
      raise_application_error(-20010, 'Password must contain at least one digit, and one upper character');
   END IF;

  <<findSpecial>>
   isSpecial := FALSE;
   FOR i IN 1..LENGTH(specialarray) LOOP
      FOR j IN 1..LENGTH(new_password) LOOP
         IF SUBSTR(new_password,j,1) = SUBSTR(specialarray,i,1) THEN
            isSpecial := TRUE;
            GOTO endsearch;
         END IF;
      END LOOP;
   END LOOP;
   IF isSpecial = FALSE THEN
      raise_application_error(-20011, 'Password must contain at least one digit, and one special character');
   END IF;

   <<endsearch>>
 
   IF old_password IS NOT NULL THEN
     differ := length(old_password) - length(new_password);

     differ := abs(differ);
     IF differ < 3 THEN
       IF length(new_password) < length(old_password) THEN
         m := length(new_password);
       ELSE
         m := length(old_password);
       END IF;

       FOR i IN 1..m LOOP
         IF substr(new_password,i,1) != substr(old_password,i,1) THEN
           differ := differ + 1;
         END IF;
       END LOOP;

       IF differ < 3 THEN
         raise_application_error(-20012, 'Password should differ from the old password by at least 3 characters');
       END IF;
     END IF;
   END IF;
   
   RETURN(TRUE);
END verify_function_itwill;
/



select username, profile from dba_users;
select * from dba_profiles where profile = 'DEFAULT';

create profile insa_profile limit
failed_login_attempts 3
password_lock_time 1/1440
password_verify_function verify_function_itwill;

select * from dba_profiles where profile = 'INSA_PROFILE';
SELECT * FROM dba_users where username = 'INSA';

alter user insa profile insa_profile;

select * from dba_users where username = 'INSA';

ALTER SESSION SET nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

ALTER USER insa password expire;

select * from dba_users where username = 'INSA';

alter profile insa_profile limit
password_verify_function null;

select * from dba_profiles where profile = 'INSA_PROFILE';

alter user insa identified by oracle account unlock;

drop profile insa_profile cascade;

select * from dba_users where username = 'INSA';

create profile insa_profile limit
password_life_time 5/1440
password_grace_time 5/1440;

alter user insa profile insa_profile;

select * from dba_profiles where profile = 'INSA_PROFILE';

select * from dba_users where username = 'INSA';

select * from dba_users where username = 'INSA';


alter profile insa_profile limit
password_life_time unlimited
password_grace_time unlimited
password_reuse_time 1/1440
password_reuse_max 1;

select * from dba_profiles where profile = 'INSA_PROFILE';

select * from dba_users where username = 'INSA';

alter user insa identified by oracle;

alter profile insa_profile limit
password_life_time unlimited
password_grace_time unlimited
password_reuse_time unlimited
password_reuse_max unlimited;

select * from dba_profiles where profile = 'INSA_PROFILE';

select * from dba_users where username = 'INSA';

alter profile insa_profile limit
sessions_per_user default
idle_time 1;

select * from v$parameter where name = 'resource_limit';

drop profile insa_profile cascade;

select * from user$;

show parameter os_authent_prefix;

create user ops$jack
identified externally
default tablespace users
temporary tablespace temp
quota 1m on users;

select * from dba_users;

grant create session, select any table to ops$jack;

select * from dba_sys_privs where grantee = 'OPS$JACK';

select * from v$session where username = 'OPS$JACK';

alter system kill session '30,26328' immediate;

drop user ops$jack cascade;

select * from v$parameter where name = 'audit_trail';

select * from dba_stmt_audit_opts where audit_option = 'TABLE';

select * from aud$;

select * from dba_audit_object;

select username, owner, obj_name, action_name, decode(returncode,0,'sucess',returncode) sess, timestamp
from dba_audit_object;

create table insa.dept as select * from hr.departments;

select * from dba_ts_quotas where username = 'INSA';

SELECT * FROM DBA_DATA_FILES;

alter user insa quota 10m on insa_tbs;

create table insa.dept as select * from hr.departments;

select * from dba_stmt_audit_opts where audit_option = 'TABLE';

select * from aud$;

delete from aud$;

rollback;

truncate table aud$;

revoke prog, mgr from insa;
drop table hr.emp purge;

create table hr.emp
as
select employee_id id, last_name name, salary sal
from hr.employees;

select * from hr.emp;

grant select, insert, update, delete on hr.emp to insa, insa_buha;

select * from dba_tab_privs where grantee in ('INSA','INSA_BUHA');

audit select, insert, update, delete on hr.emp;

select * from dba_obj_audit_opts where owner = 'HR';

select owner, object_name, object_type, sel, ins, upd, del from dba_obj_audit_opts where owner = 'HR';

select * from aud$;

select username, owner, obj_name, action_name, decode(returncode,0,'sucess',returncode) sess, timestamp
from dba_audit_object;

noaudit select, insert, update, delete on hr.emp;

select * from aud$;

truncate table aud$;

select * from dba_sys_privs where privilege = 'SELECT ANY TABLE';

grant select any table to insa, insa_buha;

select * from dba_sys_privs where privilege = 'SELECT ANY TABLE';

audit select any table by insa, insa_buha;

select * from dba_stmt_audit_opts where audit_option = 'SELECT ANY TABLE';

select username, owner, obj_name, action_name, decode(returncode,0,'sucess',returncode) sess, timestamp
from dba_audit_object;

noaudit select any table by insa, insa_buha;
audit select any table by insa, insa_buha;

select * from aud$;

truncate table aud$;

select username, owner, obj_name, action_name, decode(returncode,0,'sucess',returncode) sess, timestamp
from dba_audit_object;

audit create table by insa;

select * from v$parameter where name = 'audit_trail';

alter system set audit_trail = db,extended  scope = spfile;

audit table;
noaudit table;
truncate table aud$;

audit select, insert, update, delete on hr.emp;

select * from aud$;

select username, owner, obj_name, action_name, decode(returncode,0,'sucess',returncode) sess, timestamp, sql_text, sql_bind
from dba_audit_object;