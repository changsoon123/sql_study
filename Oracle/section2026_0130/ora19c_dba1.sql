select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_log_simultaneous_copies';

select name, gets 
from v$latch_children
where name = 'redo copy';

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm in ('_log_parallelism_dynamic','_log_private_mul');

select count(*) from v$latch_children where name = 'redo allocation';

select * from v$sgastat where name = 'private strands';

select name, gets from v$latch_parent where name = 'redo writing';

create table hr.redo_table(id number, name char(200)) tablespace users;

select n.name, sum(s.value)
from v$sesstat s, v$statname n
where n.name in ('redo entries','redo size', 'redo synch writes','redo writes','redo blocks written','redo log space requests','redo log space wait time')
and s.statistic# = n.statistic#
and s.sid = (select sid from v$session where username = 'HR')
group by n.name;

insert into hr.redo_table(id, name) select object_id, object_name from all_objects;


select logging from dba_tables where table_name = 'REDO_TABLE';

insert /*+ append */ into hr.redo_table(id, name) select object_id, object_name from all_objects;

alter table hr.redo_table nologging;

select logging from dba_tables where table_name = 'REDO_TABLE';

select n.name, sum(s.value)
from v$sesstat s, v$statname n
where n.name in ('redo entries','redo size', 'redo synch writes','redo writes','redo blocks written','redo log space requests','redo log space wait time')
and s.statistic# = n.statistic#
and s.sid = (select sid from v$session where username = 'HR')
group by n.name;

insert /*+ append */ into hr.redo_table(id, name) select object_id, object_name from all_objects;

select s.username,s.sid, t.xidusn, t.xidslot,t.xidsqn,t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr
and s.username = 'HR';

select segment_name, bytes/1024/1024 mb, blocks, extents from dba_segments where segment_name = 'REDO_TABLE';

truncate table hr.redo_table;


alter table hr.redo_table logging;

select logging from dba_tables where table_name = 'REDO_TABLE';

select n.name, sum(s.value)
from v$sesstat s, v$statname n
where n.name in ('redo synch writes','user commits','user rollbacks')
and s.statistic# = n.statistic#
and s.sid = (select sid from v$session where username = 'HR')
group by n.name;

select event, total_waits, time_waited
from v$session_event
where sid = (select sid from v$session where username = 'HR')
and event = 'log file sync';