SELECT * FROM user_tab_privs;
SELECT * FROM all_objects WHERE object_name = 'ID_SEQ';
SELECT * FROM all_sequences WHERE sequence_name = 'ID_SEQ';
SELECT * FROM hr.seq_test;

INSERT INTO hr.seq_test(id,name,day) VALUES(hr.id_seq.nextval, 'owen', localtimestamp);
COMMIT;
SELECT * FROM hr.seq_test;

INSERT INTO hr.seq_test(id,name,day) VALUES(hr.id_seq.nextval, 'abcabc', localtimestamp);

SELECT * FROM user_tab_privs;

SELECT * FROM ec;

SELECT * FROM all_synonyms WHERE table_owner = 'HR' AND table_name = 'EMP_COPY_2025';

SELECT * FROM hr.emp_copy_2025;
