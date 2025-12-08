SELECT * FROM dba_users;
SELECT * FROM dba_tablespaces;

DROP TABLESPACE oltp_tbs including contents and datafiles;
DROP TABLESPACE oltp_temp including contents and datafiles;

CREATE TABLESPACE insa_tbs
datafile '/u01/app/oracle/oradata/ORA19C/insa_tbs01.dbf' size 10m autoextend on
extent management local uniform size 1m
segment space management auto;

CREATE TEMPORARY TABLESPACE insa_temp
TEMPFILE '/u01/app/oracle/oradata/ORA19C/insa_temp01.dbf' SIZE 10M AUTOEXTEND ON
EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1M
SEGMENT SPACE MANAGEMENT MANUAL;

select * from dba_data_files;
select * from dba_temp_files;

create user insa
identified by oracle
default tablespace insa_tbs
temporary tablespace insa_temp
quota 1m on insa_tbs
password expire;

select * from dba_users;
select * from dba_ts_quotas;

select * from dba_sys_privs where grantee = 'INSA';

revoke create table from insa;

grant create table to insa with admin option;

select default_tablespace, temporary_tablespace from user_users;

create user insa_buha
identified by oracle
default tablespace insa_tbs
temporary tablespace insa_temp
quota 1m on insa_tbs;

grant create session to insa_buha;

select * from dba_sys_privs where grantee = 'INSA_BUHA';
select * from dba_ts_quotas where username = 'INSA_BUHA';

select * from dba_sys_privs where grantee = 'INSA';

select * from dba_sequences where sequence_owner = 'INSA';

SELECT * FROM user_sequences WHERE sequence_name = 'BUHA_SEQ';

insert into buha(id,name) values(buha_seq.nextval,'james');

select * from dba_sys_privs where grantee in ('INSA', 'INSA_BUHA');

revoke create sequence from insa;

revoke create sequence from insa_buha;

select * from dba_sys_privs where grantee in ('INSA', 'INSA_BUHA');

grant select on hr.employees to insa with admin option;
GRANT SELECT ON hr.employees to insa with grant option;
grant select on hr.departments to insa with grant option;

select * from dba_tab_privs where grantee = 'INSA';

select * from dba_tab_privs where grantee in ('INSA', 'INSA_BUHA');

revoke select on hr.departments from insa;

select * from dba_tab_privs where grantee in ('INSA', 'INSA_BUHA');

create role prog;

select * from dba_roles where role = 'PROG';

grant create session, create procedure, create trigger, create view to prog;

select * from dba_sys_privs where grantee = 'PROG';

grant select on hr.departments to prog;

select * from dba_tab_privs where grantee = 'PROG';

grant prog to insa;

select * from dba_role_privs where grantee = 'INSA';

create role mgr;

grant select any table to mgr;

select * from dba_sys_privs where grantee = 'MGR';

grant mgr to insa;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role all;

alter user insa default role all except mgr;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role none;

alter user insa default role all except prog;

select * from dba_role_privs where grantee = 'INSA';

alter user insa default role all;

select * from dba_role_privs where grantee = 'INSA';

select * from dba_sys_privs where grantee in ('INSA', 'PROG', 'MGR');
select * from dba_tab_privs where grantee in ('INSA', 'PROG', 'MGR');

revoke select on hr.employees from insa;

select * from dba_tab_privs where grantee = 'INSA';

grant select on hr.employees to insa;

select * from dba_tab_privs where grantee = 'INSA';

grant select on hr.departments to insa;

select * from dba_tab_privs where grantee = 'INSA';

select * from dba_objects where object_name in ('EMP_VIEW', 'DEPT_VIEW');

select * from dba_views where view_name in ('EMP_VIEW', 'DEPT_VIEW');

revoke select on hr.employees from insa;

revoke select on hr.departments from insa;

grant select on hr.employees to insa;

select * from dba_tab_privs where grantee = 'INSA';

grant select on hr.departments to insa;

select * from dba_objects where object_name in ('EMP_VIEW', 'DEPT_VIEW');

select * from dba_views where view_name in ('EMP_VIEW', 'DEPT_VIEW');

grant select on hr.departments to insa;

revoke select on hr.employees from insa;

revoke select on hr.departments from insa;

SELECT * FROM dba_roles where role = 'MGR';

drop role mgr;

CREATE ROLE mgr;

create role mgr identified by oracle;

select * from dba_roles where role = 'MGR';

GRANT SELECT ANY TABLE TO mgr;

grant mgr to insa;

select * from dba_role_privs where grantee = 'INSA';

alter role mgr not identified;