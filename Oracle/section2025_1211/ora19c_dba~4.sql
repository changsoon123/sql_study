drop table hr.dept purge;

select * from dba_data_files;

drop tablespace audit_aux including contents and datafiles;

select * from aud$;

alter system set audit_trail = db scope = spfile;

cd /u01/app/oracle/admin/ora19c/adump
