
SELECT username, account_status
FROM   dba_users
WHERE  username in('SYS','SYSTEM','HR');

select username, default_tablespace, temporary_tablespace, profile, account_status
from dba_users
where username = 'HR';

SELECT username,
       expiry_date
FROM   dba_users;