select * from dba_roles;

select * from user$;

drop role prog;

drop role mgr;

select * from dba_users where username = 'INSA';
SELECT * FROM dba_sys_privs where grantee = 'INSA';
SELECT * FROM dba_tab_privs where grantee = 'INSA';

create role prog;
create role mgr;
select * from dba_roles;
grant create view, create trigger, create procedure to prog;
grant select any table to mgr;
grant select on hr.departments to prog;

select * from dba_sys_privs where grantee = 'PROG';
select * from dba_sys_privs where grantee = 'MGR';

select * from dba_tab_privs where grantee = 'PROG';

select * from dba_role_privs where grantee = 'INSA';

grant prog, mgr to insa;
revoke prog,mgr from insa;

select * from dba_tab_privs where grantee = 'INSA';
revoke select on hr.departments from insa;

select distinct privilege from dba_sys_privs where privilege like '%ANY%';

alter user insa default role none;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role all;

alter user insa default role prog;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role prog;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role all except mgr;

alter user insa default role prog, mgr;

drop role mgr;

select * from dba_role_privs where grantee = 'INSA';

create role mgr identified by oracle;

select * from dba_roles where role = 'MGR';

grant select any table to mgr;

grant mgr to insa;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role all;

select * from dba_role_privs where grantee = 'INSA';

alter role mgr not identified;

alter role mgr identified by oracle;

select * from dba_role_privs where grantee = 'INSA';

drop table hr.emp purge;

create table hr.emp(id number, name varchar2(30), sal number) tablespace users;

create table insa.emp(id number, name varchar2(30), sal number) tablespace users;

alter user insa quota 10m on users;

select * from dba_ts_quotas where username = 'INSA';

create or replace procedure priv_mgr
authid current_user
is
begin
    if to_char(sysdate,'hh24:mi') between '14:00' and '14:05' then
        dbms_session.set_role('sec_app_role');
    else
        dbms_session.set_role('all');
    end if;
end priv_mgr;
/

create role sec_app_role identified using priv_mgr;

select * from dba_roles where role = 'SEC_APP_ROLE';

grant select any dictionary to sec_app_role;

select * from dba_sys_privs where grantee = 'SEC_APP_ROLE';

grant execute on priv_mgr to insa;

grant execute on priv_mgr to hr;

revoke inherit privileges on user insa from public;

grant inherit privileges on user insa to public;

select username, profile from dba_users;

select * from dba_profiles where profile = 'DEFAULT';

SELECT * FROM v$parameter where name like '%failed%';

select * from dba_profiles where profile = 'DEFAULT';

alter profile default limit
FAILED_LOGIN_ATTEMPTS 3
PASSWORD_LOCK_TIME unlimited;

SELECT * FROM dba_users where username = 'INSA';

alter session set nls_date_format = 'yyyy-mm-dd hh24:mi:ss';

alter user insa account unlock;

alter user insa identified by oracle account unlock password expire;