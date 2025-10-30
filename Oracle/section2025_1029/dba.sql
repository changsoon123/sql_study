SHOW USER;

SELECT * FROM dba_sys_privs WHERE grantee = 'INSA';
SELECT * FROM dba_ts_quotas WHERE username = 'INSA';

ALTER USER insa QUOTA 10M ON users;

REVOKE create session FROM insa;
GRANT create session TO insa;

SELECT * FROM user_tables;

GRANT SELECT ON hr.employees TO insa;

SELECT * FROM dba_tab_privs WHERE grantee = 'INSA';

