SELECT * FROM dba_sys_privs;

SELECT * FROM dba_data_files;

SELECT * FROM dba_users;

SELECT * FROM dba_temp_files;


CREATE USER insa
IDENTIFIED BY oracle
DEFAULT TABLESPACE users
TEMPORARY TABLESPACE temp
QUOTA 10M ON users
ACCOUNT UNLOCK;

ALTER USER insa
QUOTA unlimited ON users;

SELECT * FROM dba_ts_quotas;

GRANT CREATE SESSION TO insa;
SELECT * FROM dba_sys_privs WHERE grantee = 'INSA';

GRANT CREATE TABLE TO insa;
