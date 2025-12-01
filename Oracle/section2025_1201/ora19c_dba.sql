select * from v$parameter where name = 'fast_start_mttr_target';
alter system set fast_start_mttr_target = 600;
select * from v$parameter where name = 'fast_start_mttr_target';
select * from v$parameter where name = 'log_checkpoints_to_alert';

alter system set log_checkpoints_to_alert = true;

select * from v$parameter where name = 'log_checkpoints_to_alert';

select * from v$database;
select checkpoint_change#, current_scn from v$database;
select name, checkpoint_change# from v$datafile;

select * from v$log;

select * from v$database;
select * from v$datafile;
select * from v$log;
select * from v$logfile;

select * from v$controlfile;

select * from v$parameter where name = 'control_files';

alter system set control_files = '/u01/app/oracle/oradata/ORA19C/control01.ctl','/u01/app/oracle/fast_recovery_area/ORA19C/control02.ctl',
'/home/oracle/control03.ctl' scope = spfile;