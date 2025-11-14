SELECT * FROM user_tab_privs;

exec dbms_output.put_line('20 mile = '|| 20*hr.global_conts.c_mile_2_kilo || 'km');

exec dbms_output.put_line('20 kilo = '|| 20*hr.global_conts.c_kilo_2_mile || 'km');

exec dbms_output.put_line('20 yard = '|| 20*hr.global_conts.c_yard_2_meter || 'km');

exec dbms_output.put_line('20 meter = '|| 20*hr.global_conts.c_meter_2_yard || 'km');

exec dbms_output.put_line(hr.mtr_to_yrd(20));