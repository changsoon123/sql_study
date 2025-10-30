SELECT * FROM dba_constraints WHERE owner = 'HR' and table_name = 'EMP';
SELECT * FROM dba_cons_columns WHERE owner = 'HR' and table_name = 'EMP';

SELECT * FROM dba_indexes WHERE owner = 'HR' and table_name = 'EMP';
SELECT * FROM dba_ind_columns WHERE index_owner = 'HR' and table_name = 'EMP';