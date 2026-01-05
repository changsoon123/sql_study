begin
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo03.log',options=>dbms_logmnr.new);
    dbms_logmnr.add_logfile(logfilename=>'/u01/app/oracle/oradata/ORA19C/redo02.log',options=>dbms_logmnr.addfile);
end;
/

execute dbms_logmnr.start_logmnr(options=>dbms_logmnr.dict_from_online_catalog);

select filename from v$logmnr_logs;

select timestamp, operation, sql_redo, sql_undo
from v$logmnr_contents
where seg_name = 'HR';

execute dbms_logmnr.end_logmnr;