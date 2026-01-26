select employee_id, rowid from hr.employees order by 1;

select * from dba_segments where segment_name = 'EMP_EMP_ID_PK';
select * from dba_extents where segment_name = 'EMP_EMP_ID_PK';

select * from hr.employees where employee_id=100;

SELECT class from v$waitstat;

select header_file, header_block
from dba_segments where segment_name = 'EMP_EMP_ID_PK';

select count(*) from v$latch_children where name = 'cache buffers chains';

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_db_block_hash_latches';

select a.ksppinm parameter, b.ksppstvl value
from x$ksppi a, x$ksppcv b
where a.indx = b.indx
and a.ksppinm = '_db_block_hash_buckets';