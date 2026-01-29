select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') day, a.sid, vss.username, a.name, a.value
    from (
    select vst.sid,vst.value,vsn.name,vsn.statistic#
    from v$statname vsn, v$sesstat vst
    where vsn.statistic# = vst.statistic#
    order by vst.value desc) a, v$session vss
    where a.sid = vss.sid
    and vss.username = 'HR'
    and a.name =  'table fetch continued row';
    
select /*+ index(t mig_table_idx) */ count(l_name) 
from hr.mig_table t 
where id > 0;

drop table hr.mig_table;

create table hr.mig_table(id number, l_name varchar2(2000), f_name varchar2(2000)) tablespace users;

insert into hr.mig_table(id,l_name,f_name)
select level,
        decode(mod(level,3), 1, null, rpad('x',2000,'x')),
        decode(mod(level,3), 1, null, rpad('x',1000,'x'))
from dual
connect by level <= 1000;

commit;

select num_rows, blocks, chain_cnt from dba_tables where table_name = 'MIG_TABLE';

execute dbms_stats.gather_table_stats('hr','mig_table');

create index mig_table_idx on hr.mig_table(id) tablespace users;

update hr.mig_table
set l_name = rpad('x',2000,'x'), f_name = rpad('x',2000,'x')
where mod(id,3) = 1;

commit;

select * from v$sysstat where name = 'table fetch continued row';

select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') day, a.sid, vss.username, a.name, a.value
    from (
    select vst.sid,vst.value,vsn.name,vsn.statistic#
    from v$statname vsn, v$sesstat vst
    where vsn.statistic# = vst.statistic#
    order by vst.value desc) a, v$session vss
    where a.sid = vss.sid
    and vss.username = 'HR'
    and a.name =  'table fetch continued row';
    
select s.prev_sql_id, s.prev_child_number, v.sql_text
from v$session s, v$sql v
where s.username='HR'
and s.prev_sql_id = v.sql_id
and s.prev_child_number = v.child_number;

select * from table(dbms_xplan.display_cursor('4y2m5q8hhv0r4'));

analyze table hr.mig_table compute statistics;

select num_rows, blocks, chain_cnt from dba_tables where table_name = 'MIG_TABLE';

analyze table hr.mig_table compute statistics;

select num_rows, blocks, chain_cnt from dba_tables where table_name = 'MIG_TABLE';

alter table hr.mig_table move;

select index_name, status from dba_indexes where table_name = 'MIG_TABLE';

alter index mig_table_idx rebuild online;

select index_name, status from dba_indexes where table_name = 'MIG_TABLE';

analyze table hr.mig_table compute statistics;

select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') day, a.sid, vss.username, a.name, a.value
    from (
    select vst.sid,vst.value,vsn.name,vsn.statistic#
        from v$statname vsn, v$sesstat vst
    where vsn.statistic# = vst.statistic#
    order by vst.value desc) a, v$session vss
    where a.sid = vss.sid
    and vss.username = 'HR'
    and a.name =  'table fetch continued row';