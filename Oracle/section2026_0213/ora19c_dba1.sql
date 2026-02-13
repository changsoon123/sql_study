select  a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_optimizer_cost_model';

select * from sys.aux_stats$;

execute dbms_stats.gather_system_stats(gathering_mode=>'start')

execute dbms_stats.gather_system_stats(gathering_mode=>'stop')

execute dbms_stats.gather_system_stats(gathering_mode=>'noworkload')

begin
    dbms_stats.set_system_stats('SREADTIM', 1.2);
    dbms_stats.set_system_stats('MREADTIM', 1.3);
    dbms_stats.set_system_stats('MBRC', 16);
    dbms_stats.set_system_stats('CPUSPEED', 700);
    dbms_stats.set_system_stats('MAXTHR', 40580544);   
    dbms_stats.set_system_stats('SLAVETHR', 32224);   
end;
/

show parameter optimizer_mode;

select * from v$version;

show parameter optimizer_features_enable;

select * from v$sys_optimizer_env;

drop table hr.emp purge;

create table hr.emp tablespace users as select * from hr.employees;

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct, 1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality, c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMP'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));

exec dbms_stats.gather_table_stats('hr','emp',method_opt=>'for all columns size 1');

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct, 1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality, c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMP'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

alter system flush shared_pool;

exec dbms_stats.gather_table_stats('hr','emp',method_opt=>'for columns size 20 job_id');

select t.num_rows, c.column_name, c.num_nulls, c.num_distinct, 1/c.num_distinct selectivity, num_rows/c.num_distinct cardinality, c.histogram
from dba_tables t, dba_tab_columns c
where t.table_name = 'EMP'
and c.table_name = t.table_name
and t.owner = 'HR'
and c.owner = 'HR';

select * from sys.col_usage$;

select * from sys.obj$ where name = 'EMP';
select * from sys.user$ where name = 'HR';
select * from sys.obj$ where name = 'EMP' and owner# = 106 ;
select * from sys.col_usage$ where obj# = 75714;

select * from dba_tab_columns where owner = 'HR' and table_name = 'EMP';
select * from sys.col$ where obj# = 75714;

exec dbms_stats.gather_table_stats('hr','emp',method_opt=>'for columns size 20 job_id',no_invalidate=> true);

select  a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_optimizer_invalidation_period';

exec dbms_stats.gather_table_stats('hr','emp',method_opt=>'for columns size 20 job_id',no_invalidate=> true, cascade=>true);

select client_name, status, consumer_group, window_group from dba_autotask_client;

select * from dba_scheduler_wingroup_members where window_group_name = 'ORA$AT_WGRP_OS';

select window_name, resource_plan, repeat_interval, duration from dba_scheduler_windows;

select window_name, window_next_time, autotask_status, optimizer_stats, segment_advisor, sql_tune_advisor from dba_autotask_window_clients;

EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE('FRIDAY_WINDOW',   'repeat_interval','freq=daily;byday=FRI;byhour=05;byminute=0; bysecond=0');

EXECUTE DBMS_SCHEDULER.SET_ATTRIBUTE(name => 'MONDAY_WINDOW', attribute => 'duration', value => numtodsinterval(5, 'hour'));

select client_name, job_status, job_start_time, job_duration from dba_autotask_job_history;

BEGIN
DBMS_AUTO_TASK_ADMIN.DISABLE(
        client_name => 'auto optimizer stats collection',
        operation => NULL,
        window_name => NULL);
END;
/

BEGIN
DBMS_AUTO_TASK_ADMIN.ENABLE(
        client_name => 'auto optimizer stats collection',
        operation => NULL,
        window_name => NULL);
END;
/

show parameter statistics_level;

select * from dba_tables where owner='HR' and table_name = 'EMP';

exec dbms_stats.delete_table_stats('hr','emp')
exec dbms_stats.gather_table_stats('hr','emp')
exec dbms_stats.gather_table_stats('hr','emp',degree=>2)

drop table hr.emp purge;

create table hr.emp tablespace users as select employee_id, last_name, salary from hr.employees;

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed 
from dba_tables 
where owner='HR' and table_name='EMP';

select * from dba_tab_modifications where table_name = 'EMP' and table_owner='HR';

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed , stale_stats
from dba_tab_statistics
where owner='HR' and table_name='EMP';

exec dbms_stats.flush_database_monitoring_info;

exec dbms_stats.set_table_prefs('hr','emp','stale_percent','40')

select * from dba_tab_stat_prefs where owner = 'HR' and table_name = 'EMP';

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed , 
       stale_stats, stattype_locked
from dba_tab_statistics
where owner='HR' and table_name='TAB';

exec dbms_stats.lock_table_stats('hr','emp')

exec dbms_stats.gather_table_stats('hr','emp',degree=>2)

exec dbms_stats.unlock_table_stats('hr','emp')

create table hr.tab(col1 number, col2 number) tablespace users;

insert into hr.tab(col1,col2) select level, level from dual connect by level <= 100;

commit;

select column_name, num_distinct, num_nulls, num_buckets, histogram 
from dba_tab_columns 
where owner='HR' and table_name='TAB';

exec dbms_stats.gather_table_stats('hr','tab',method_opt=>'for all columns size auto')

select * from dba_tab_stats_history where owner='HR' and table_name = 'TAB';

exec dbms_stats.create_stat_table('hr','tab_sta','users')

select * from hr.tab_sta;

desc hr.tab_sta

exec dbms_stats.export_table_stats(ownname=>'hr',tabname=>'tab',stattab=>'tab_sta');

insert into hr.tab(col1,col2) select mod(level,2), level from dual connect by level <= 1000;

commit;

exec dbms_stats.gather_table_stats('hr','tab',method_opt=>'for columns col1 size 254')

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed , 
       stale_stats, stattype_locked
from dba_tab_statistics
where owner='HR' and table_name='TAB';

select * from dba_tab_stats_history where owner='HR' and table_name = 'TAB';

select column_name, num_distinct, num_nulls, num_buckets, histogram 
from dba_tab_columns 
where owner='HR' and table_name='TAB';

set long 100000

select * from table(dbms_stats.diff_table_stats_in_stattab('hr','tab','tab_sta'));

exec dbms_stats.import_table_stats('hr','tab',stattab=>'tab_sta')

exec dbms_stats.restore_table_stats('hr','tab','26/02/13 02:11:59.658319000 +09:00')

select dbms_stats.get_stats_history_availability from dual;

select num_rows, blocks, avg_row_len, to_char(last_analyzed,'yyyy-mm-dd hh24:mi:ss') last_analyzed , 
       stale_stats, stattype_locked
from dba_tab_statistics
where owner='HR' and table_name='TAB';

select dbms_stats.get_stats_history_retention from dual;

select column_name, num_distinct, num_nulls, num_buckets, histogram
from dba_tab_columns
where owner='HR' and table_name='TAB';

select dbms_stats.get_stats_history_availability from dual;

select dbms_stats.get_stats_history_retention from dual;

exec dbms_stats.alter_stats_history_retention(7)

select dbms_stats.get_stats_history_retention from dual;