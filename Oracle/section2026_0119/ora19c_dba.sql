select * from v$log;

drop table hr.reorg_test purge;

create table hr.reorg_test(id number, name varchar2(100)) tablespace users;

begin
    for i in 1..10000 loop
        insert into hr.reorg_test(id, name) values(i, 'table/index reorganization example');
    end loop;
        commit;
end;
/

select count(*) from hr.reorg_test;

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';
select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

ALTER TABLE hr.reorg_test add constraint reorg_id_pk primary key(id);

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';

exec dbms_stats.gather_table_stats('hr','reorg_test');

select
 a.tablespace_name,
 b.file_name,
 a.status,
 b.bytes/1024/1024 as "total size(mb)",
(b.bytes - c.free_bytes)/1024/1024 as "used size(mb)",
c.free_bytes/1024/1024 as "free size(mb)",
b.autoextensible
from
 dba_tablespaces a,
 dba_data_files b,
 ( select tablespace_name, file_id, sum(bytes) as free_bytes
 from dba_free_space
 group by tablespace_name, file_id
 ) c
where a.tablespace_name = b.tablespace_name
and a.tablespace_name = c.tablespace_name
and b.file_id = c.file_id
order by b.file_id;

delete from hr.reorg_test where id > 100;

select object_id, data_object_id from dba_objects where object_name = 'REORG_TEST';

alter table hr.reorg_test move tablespace users;
alter table hr.reorg_test move;

alter index hr.reorg_id_pk rebuild online;




drop table hr.reorg_test purge;

create table hr.reorg_test(id number, name varchar2(100)) tablespace users;

begin
    for i in 1..10000 loop
        insert into hr.reorg_test(id, name) values(i, 'table/index reorganization example');
    end loop;
        commit;
end;
/

select count(*) from hr.reorg_test;

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';
select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

ALTER TABLE hr.reorg_test add constraint reorg_id_pk primary key(id);

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';

exec dbms_stats.gather_table_stats('hr','reorg_test');

select
 a.tablespace_name,
 b.file_name,
 a.status,
 b.bytes/1024/1024 as "total size(mb)",
(b.bytes - c.free_bytes)/1024/1024 as "used size(mb)",
c.free_bytes/1024/1024 as "free size(mb)",
b.autoextensible
from
 dba_tablespaces a,
 dba_data_files b,
 ( select tablespace_name, file_id, sum(bytes) as free_bytes
 from dba_free_space
 group by tablespace_name, file_id
 ) c
where a.tablespace_name = b.tablespace_name
and a.tablespace_name = c.tablespace_name
and b.file_id = c.file_id
order by b.file_id;

delete from hr.reorg_test where id > 100;

select object_id, data_object_id from dba_objects where object_name = 'REORG_TEST';

create table hr.reorg_test_temp tablespace users as select * from hr.reorg_test;

exec dbms_stats.gather_table_stats('hr','reorg_test');

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';
select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';

drop table hr.reorg_test;

alter table hr.reorg_test add constraint reorg_id_pk primary key(id);

commit;

select row_movement from dba_tables where owner = 'HR' and table_name = 'REORG_TEST';

alter table hr.reorg_test enable row movement;

alter table hr.reorg_test shrink space compact;

alter table hr.reorg_test shrink space;

alter table hr.reorg_test disable row movement;

alter index hr.reorg_id_pk rebuild online;

select object_name, object_id, 
data_object_id, to_char(created,'yyyy-mm-dd hh24:mi:ss') create_date, 
to_char(last_ddl_time, 'yyyy-mm-dd hh24:mi:ss') ddl_date, timestamp, status
from dba_objects 
where object_name = 'REORG_TEST';

create table hr.reorg_test_temp tablespace users as select * from hr.reorg_test where 1 = 2;

alter table hr.reorg_test_temp add constraint reorg_temp_id_pk primary key(id);

select constraint_name, constraint_type, index_name from dba_constraints where table_name='REORG_TEST_TEMP';

select object_name, object_id, 
data_object_id, to_char(created,'yyyy-mm-dd hh24:mi:ss') create_date, 
to_char(last_ddl_time, 'yyyy-mm-dd hh24:mi:ss') ddl_date, timestamp, status
from dba_objects 
where object_name in ('REORG_TEST','REORG_TEST_TEMP');

exec dbms_redefinition.can_redef_table('hr','reorg_test',dbms_redefinition.cons_use_pk);

select count(*) from hr.reorg_test_temp;

exec dbms_redefinition.start_redef_table('hr','reorg_test','reorg_test_temp');

select count(*) from hr.reorg_test_temp;

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST_TEMP';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';
select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';

select * from hr.reorg_test where id = 50;
select * from hr.reorg_test_temp where id = 50;

update hr.reorg_test set name = 'ITWILL' where id = 50;
commit;

select * from hr.reorg_test where id = 1;
select * from hr.reorg_test_temp where id = 1;

delete from hr.reorg_test where id = 1;

commit;

exec dbms_redefinition.sync_interim_table('hr','reorg_test','reorg_test_temp');

select object_name, object_id, 
data_object_id, to_char(created,'yyyy-mm-dd hh24:mi:ss') create_date, 
to_char(last_ddl_time, 'yyyy-mm-dd hh24:mi:ss') ddl_date, timestamp, status
from dba_objects 
where object_name in ('REORG_TEST','REORG_TEST_TEMP');

exec dbms_redefinition.finish_redef_table('hr','reorg_test','reorg_test_temp')

select constraint_name,constraint_type, index_name from dba_constraints where table_name = 'REORG_TEST';
select constraint_name,constraint_type, index_name from dba_constraints where table_name = 'REORG_TEST_TEMP';

drop table hr.reorg_test purge;
drop table hr.reorg_test_temp purge;

create table hr.reorg_test(id number, name varchar2(100)) tablespace users;

begin
    for i in 1..10000 loop
        insert into hr.reorg_test(id, name) values(i, 'table/index reorganization example');
    end loop;
        commit;
end;
/

select count(*) from hr.reorg_test;

select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_TEST';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_TEST';
select num_rows, blocks, avg_row_len from dba_tables where table_name = 'REORG_TEST';

ALTER TABLE hr.reorg_test add constraint reorg_id_pk primary key(id);
delete from hr.reorg_test where id = 1;
commit;
select extents, blocks,bytes/1024/1024 mb from dba_segments where segment_name = 'REORG_ID_PK';
select tablespace_name, extent_id, bytes from dba_extents where segment_name = 'REORG_ID_PK';

exec dbms_stats.gather_table_stats('hr','reorg_test');

select
 a.tablespace_name,
 b.file_name,
 a.status,
 b.bytes/1024/1024 as "total size(mb)",
(b.bytes - c.free_bytes)/1024/1024 as "used size(mb)",
c.free_bytes/1024/1024 as "free size(mb)",
b.autoextensible
from
 dba_tablespaces a,
 dba_data_files b,
 ( select tablespace_name, file_id, sum(bytes) as free_bytes
 from dba_free_space
 group by tablespace_name, file_id
 ) c
where a.tablespace_name = b.tablespace_name
and a.tablespace_name = c.tablespace_name
and b.file_id = c.file_id
order by b.file_id;

delete from hr.reorg_test where id > 100;

delete from hr.reorg_test where id = 1;
select object_id, data_object_id from dba_objects where object_name = 'REORG_TEST';

commit;

create table hr.reorg_test_temp(content varchar2(60), emp_id number constraint reorg_temp_id_pk primary key)
tablespace users;

exec dbms_redefinition.can_redef_table('hr','reorg_test',dbms_redefinition.cons_use_pk);

create table hr.reorg_test_temp(content varchar2(60), emp_id number constraint reorg_temp_id_pk primary key)
tablespace users;

select count(*) from hr.reorg_test_temp;
exec dbms_redefinition.can_redef_table('hr','reorg_test',dbms_redefinition.cons_use_pk);
exec dbms_redefinition.start_redef_table('hr','reorg_test','reorg_test_temp','id emp_id, name content');
exec dbms_redefinition.sync_interim_table('hr','reorg_test','reorg_test_temp');
exec dbms_redefinition.finish_redef_table('hr','reorg_test','reorg_test_temp');

BEGIN
FOR sel_c_r IN 
   ( select owner, segment_name, bytes, partition_name, 
             decode(partition_name,null,null,'.'||partition_name) is_part,
             tablespace_name
 from dba_segments
 where segment_type= 'TABLE'
   and owner ='HR'
   )
LOOP
   if (dbms_space.verify_shrink_candidate(sel_c_r.owner,
                                          sel_c_r.segment_name,
                                          'TABLE',
                                          sel_c_r.bytes,  
                                          sel_c_r.partition_name ))
   then
         dbms_output.put_line(' ==> '||sel_c_r.owner||'.'||sel_c_r.segment_name
         || sel_c_r.is_part||', '||sel_c_r.bytes||'byte ,  TS NAME :'||sel_c_r.tablespace_name);

   end if;
 END LOOP;
END;
/