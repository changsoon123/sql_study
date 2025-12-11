drop table hr.emp purge;

create table hr.emp
as
select employee_id id, last_name name, salary sal, commission_pct comm, department_id dept_id
from hr.employees;

select * from hr.emp;

select * from hr.emp where dept_id = 80;

begin
    dbms_fga.add_policy(
        object_schema => 'hr',
        object_name => 'emp',
        policy_name => 'emp_fga',
        audit_condition => 'dept_id = 80',
        audit_column => 'sal,comm',
        audit_column_opts => dbms_fga.any_columns,
        statement_types => 'select, insert, update, delete',
        enable => true);

end;
/

select * from dba_audit_policies;
select * from sys.fga_log$;
select * from dba_fga_audit_trail;

select sal,comm from hr.emp where dept_id = 80;

begin
    dbms_fga.drop_policy(object_schema => 'hr' , object_name => 'emp' , policy_name => 'emp_fga');
end;
/

select * from dba_audit_policies;

select * from sys.fga_log$;

truncate table sys.fga_log$;

CREATE TABLE hr.fga_emp_log(
    object_schema varchar2(30),
    object_name varchar2(30),
    policy_name varchar2(30),
    user_name varchar2(30),
    sql_text varchar2(4000),
    sql_bind varchar2(100),
    day timestamp
);

create or replace procedure hr.fga_trail_proc(
    object_schema in varchar2,
    object_name in varchar2,
    policy_name in varchar2
)
is
    pragma autonomous_transaction;
begin
    insert into hr.fga_emp_log(object_schema,object_name, policy_name, user_name, sql_text,sql_bind,day)
    values(object_schema,object_name, policy_name, sys_context('userenv','session_user'), sys_context('userenv','current_sql'),sys_context('userenv','current_bind'),localtimestamp);
    commit;
end fga_trail_proc;
/

select  sys_context('userenv','session_user')
from dual;

begin
    dbms_fga.add_policy(
        object_schema => 'hr',
        object_name => 'emp',
        policy_name => 'emp_fga',
        statement_types => 'select,insert,update,delete',
        handler_schema => 'hr',
        handler_module => 'fga_trail_proc',
        enable => true);
end;
/

select * from dba_audit_policies;

select * from sys.fga_log$;

select * from hr.fga_emp_log;

begin
    dbms_fga.drop_policy(object_schema => 'hr' , object_name => 'emp' , policy_name => 'emp_fga');
end;
/

begin
    dbms_fga.disable_policy(object_schema => 'hr' , object_name => 'emp' , policy_name => 'emp_fga');
end;
/

select * from dba_audit_policies;

select * from sys.fga_log$;

truncate table fga_emp_log;

select * from hr.fga_emp_log;

begin
    dbms_fga.enable_policy(object_schema => 'hr' , object_name => 'emp' , policy_name => 'emp_fga');
end;
/

begin
    dbms_fga.drop_policy(object_schema => 'hr' , object_name => 'emp' , policy_name => 'emp_fga');
end;
/

select table_name, tablespace_name
from dba_tables
where table_name in ('AUD$','FGA_LOG$');

select * from dba_data_files;

create tablespace audit_aux
datafile '/u01/app/oracle/oradata/ORA19C/audit_aux01.dbf' size 10m autoextend on
extent management local uniform size 1m
segment space management auto;

begin
    dbms_audit_mgmt.set_audit_trail_location(
    audit_trail_type => dbms_audit_mgmt.audit_trail_aud_std ,
    audit_trail_location_value => 'audit_aux');
end;
/

select table_name, tablespace_name
from dba_tables
where table_name in ('AUD$','FGA_LOG$');

begin
    dbms_audit_mgmt.set_audit_trail_location(
        audit_trail_type => dbms_audit_mgmt.audit_trail_fga_std ,
        audit_trail_location_value => 'audit_aux');
end;
/

begin
    dbms_fga.add_policy(
        object_schema => 'hr',
        object_name => 'emp',
        policy_name => 'emp_fga',
        statement_types => 'select,insert,update,delete',
        handler_schema => 'hr',
        handler_module => 'fga_trail_proc',
        enable => true);
end;
/

select * from dba_audit_policies;

select * from sys.fga_log$;

truncate table fga_emp_log;

begin
    dbms_audit_mgmt.set_audit_trail_location(
        audit_trail_type => dbms_audit_mgmt.audit_trail_fga_std ,
        audit_trail_location_value => 'system');
end;
/

select table_name, tablespace_name
from dba_tables
where table_name in ('AUD$','FGA_LOG$');

select * from sys.fga_log$;

begin
    dbms_audit_mgmt.set_audit_trail_location(
    audit_trail_type => dbms_audit_mgmt.audit_trail_aud_std ,
    audit_trail_location_value => 'system');
end;
/