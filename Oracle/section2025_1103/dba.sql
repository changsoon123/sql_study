SELECT * FROM dba_indexes WHERE owner = 'HR' AND table_name = 'EMP';

SELECT * FROM dba_ind_columns WHERE index_owner = 'HR' AND table_name = 'EMP';

GRANT CREATE PUBLIC SYNONYM TO hr;

SELECT * FROM dba_sys_privs WHERE grantee = 'HR';

GRANT DROP PUBLIC SYNONYM TO hr;

SELECT * FROM dba_objects WHERE owner='HR' AND object_name = 'EMP';
SELECT * FROM dba_tables WHERE owner='HR' AND table_name = 'EMP';
SELECT * FROM dba_data_files WHERE tablespace_name = 'USERS';

SELECT * FROM dba_segments WHERE owner='HR' AND segment_name = 'EMP';
SELECT * FROM dba_extents WHERE owner='HR' AND segment_name = 'EMP';
