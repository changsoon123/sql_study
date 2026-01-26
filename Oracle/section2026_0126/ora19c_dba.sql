select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_db_block_max_scan_pct';

select count(*) from v$latch_children where name = 'cache buffers lru chain';

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_db_block_lru_latches';

select a.bp_blksz,
       c.child#,
       a.bp_name,
       c.gets,
       c.MISSES,
       c.SLEEPS
    from x$kcbwbpd a, x$kcbwds b, v$latch_children c
 where b.set_id between a.bp_lo_sid and a.bp_hi_sid
   and c.addr = b.set_latch
 order by 1,2;
 
show parameter db_block_size;

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_db_aging_touch_time';

alter system flush buffer_cache;

select * from x$bh;

select obj, file#, dbablk, tch, state from x$bh;

select * from dba_objects where owner = 'HR';

select * from hr.employees where employee_id = 100;

select o.object_name, x.obj, x.file#, x.dbablk, x.tch, x.state
from x$bh x, dba_objects o
where o.data_object_id = x.obj
and o.owner = 'HR';

select o.object_name, x.objd, x.file#, x.block#, x.status
from v$bh x, dba_objects o
where o.data_object_id = x.objd
and o.owner = 'HR';

select * from dba_segments where segment_name = 'EMP_EMP_ID_PK';
select * from dba_extents where segment_name = 'EMP_EMP_ID_PK';

alter system flush buffer_cache;

select o.object_name, x.obj, x.file#, x.dbablk, x.tch, x.state, x.*
from x$bh x, dba_objects o
where o.data_object_id = x.obj
and o.owner = 'HR';

select * from hr.employees where employee_id = 100;

select o.object_name, x.obj, x.file#, x.dbablk, x.tch, x.state
from x$bh x, dba_objects o
where o.data_object_id = x.obj
and o.owner = 'HR';

select * from hr.employees where department_id = 20;
select * from dba_segments where segment_name = 'EMP_DEPARTMENT_IX';
select * from dba_extents where segment_name = 'EMP_DEPARTMENT_IX';

drop table hr.emp purge;

create table hr.emp(id number, name char(100)) tablespace users;

insert into hr.emp(id,name)
select level, 'oracle'||level
from dual
connect by level <= 100000
order by dbms_random.value;

commit;

select blocks, bytes/1024/1024 mb from dba_segments where owner = 'HR' and segment_name = 'EMP';

create index hr.emp_idx on hr.emp(id) tablespace users;

select blocks, bytes/1024/1024 mb from dba_segments where owner = 'HR' and segment_name = 'EMP_IDX';

alter system flush buffer_cache;

select o.object_name, x.obj, x.file#, x.dbablk, x.tch, x.state
from x$bh x, dba_objects o
where o.data_object_id = x.obj
and o.owner = 'HR';

select o.object_name, x.obj, x.file#, x.dbablk, x.tch, x.state
from x$bh x, dba_objects o
where o.data_object_id = x.obj
and o.owner = 'HR';

select o.object_name, x.objd, x.file#, x.block#, x.status
from v$bh x, dba_objects o
where o.data_object_id = x.objd
and o.owner = 'HR';

select count(*) from hr.emp;

begin
    for i in (select /*+ index(e emp_idx) */ * from hr.emp e where id >=0) loop
        null;
    end loop;
end;
/

select sid, event, total_waits, time_waited
from v$session_event
where sid in (select sid from v$session where username = 'HR');

begin
    for i in (select /*+ full(e) */ * from hr.emp e where id >=0) loop
        null;
    end loop;
end;
/

alter system flush buffer_cache;

alter session set events '10949 trace name context forever, level 1';

select sid, event, total_waits, time_waited
from v$session_event
where sid in (select sid from v$session where username = 'HR');

select s.username, t.xidusn, t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr;

update hr.employees set salary = salary * 1.1 where employee_id = 200;

select o.object_name, x.obj, x.file#, x.dbablk, x.tch, x.state
from x$bh x, dba_objects o
where o.data_object_id = x.obj
and o.owner = 'HR'
and o.object_name = 'EMPLOYEES';

select o.object_name, x.objd, x.file#, x.block#, x.status
from v$bh x, dba_objects o
where o.data_object_id = x.objd
and o.owner = 'HR';

select n.usn, n.name, s.extents, s.rssize, s.xacts, s.status
from v$rollname n, v$rollstat s
where n.usn = s.usn;

select s.username, t.xidusn, t.xidslot,t.xidsqn,t.ubafil, t.ubablk, t.used_ublk
from v$session s, v$transaction t
where s.saddr = t.ses_addr;

select xidusn, xidslot, xidsqn from v$transaction;