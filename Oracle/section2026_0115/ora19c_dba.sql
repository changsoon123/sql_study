drop table hr.test purge;

create table hr.test(
    id number constraint test_id_pk primary key,
    sal number constraint sal_ck check(sal > 1000)
) tablespace users;

select * from dba_constraints where owner='HR' and table_name='TEST';

select * from dba_indexes where owner='HR' and table_name='TEST';

insert into hr.test(id,sal) values(1,2000);
insert into hr.test(id,sal) values(1,2001);

select * from hr.test;

insert into hr.test(id,sal) values(2,1000);

rollback;

-- disable novalidate(disable ±âº»°ª)
alter table hr.test disable novalidate constraint test_id_pk;

alter table hr.test disable novalidate constraint sal_ck;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

insert into hr.test(id,sal) values(1,2000);
insert into hr.test(id,sal) values(1,2001);
select * from hr.test;
insert into hr.test(id,sal) values(2,1000);
select * from hr.test;
rollback;

-- disable validate

alter table hr.test disable validate constraint test_id_pk;
alter table hr.test disable validate constraint sal_ck;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

insert into hr.test(id,sal) values(1,2000);
insert into hr.test(id,sal) values(1,2001);
select * from hr.test;
insert into hr.test(id,sal) values(2,1000);
select * from hr.test;
rollback;

-- test

alter table hr.test enable validate constraint test_id_pk;
alter table hr.test enable validate constraint sal_ck;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

insert into hr.test(id,sal) values(1,2000);
insert into hr.test(id,sal) values(1,2001);
insert into hr.test(id,sal) values(2,1000);
select * from hr.test;
insert into hr.test(id,sal) values(2,1000);
insert into hr.test(id,sal) values(3,500);
select * from hr.test;
rollback;

commit;
select * from hr.test;

create table exceptions(row_id urowid,
                        owner varchar2(128),
                        table_name varchar2(128),
                        constraint varchar2(128));
                        
select * from hr.exceptions;

select rowid, id, sal from hr.test;

alter table hr.test enable validate constraint test_id_pk exceptions into hr.exceptions;
alter table hr.test enable validate constraint sal_ck;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

select rowid, id, sal from hr.test where rowid in (select row_id from hr.exceptions);

update hr.test set id = 3 where rowid = 'AAASGWAAHAAAAI0AAB';

commit;

select * from hr.exceptions;
truncate table hr.exceptions;
select * from hr.test;

alter table hr.test enable validate constraint test_id_pk exceptions into hr.exceptions;
alter table hr.test enable validate constraint sal_ck exceptions into hr.exceptions;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

select rowid, id, sal from hr.test where rowid in (select row_id from hr.exceptions);

update hr.test set sal = 1001 where rowid = 'AAASGWAAHAAAAI0AAC';

alter table hr.test add constraint test_id_pk primary key(id) exceptions into hr.exceptions;

alter table hr.test add constraint sal_ck check(sal > 1000);

drop table hr.test purge;

create table hr.test(
    id number ,
    sal number) 
tablespace users;

select * from dba_constraints where owner='HR' and table_name='TEST';
insert into hr.test(id,sal) values(1,2000);
insert into hr.test(id,sal) values(1,2001);
insert into hr.test(id,sal) values(2,1000);

select * from hr.test;

alter table hr.test add constraint test_id_pk primary key(id) disable;
select * from dba_constraints where owner='HR' and table_name='TEST';

alter table hr.test enable validate constraint test_id_pk;
truncate table hr.exceptions;

alter table hr.test add constraint test_id_pk primary key(id) exceptions into hr.exceptions;
select * from hr.exceptions;

select rowid, id, sal from hr.test where rowid in (select row_id from hr.exceptions);

alter table hr.test add constraint sal_ck check(sal > 1000);

drop table hr.test purge;

create table hr.test(
    id number constraint test_id_pk primary key deferrable initially immediate,
    sal number constraint sal_ck check(sal > 1000) deferrable initially immediate
) tablespace users;

alter table hr.test enable validate constraint test_id_pk;

select * from dba_constraints where owner='HR' and table_name='TEST';
select index_name, uniqueness, status from dba_indexes where owner='HR' and table_name='TEST';

insert into hr.test(id,sal) values(1,2000);
insert into hr.test(id,sal) values(1,2001);
insert into hr.test(id,sal) values(2,1000);

select * from hr.test;
commit;
rollback;

set constraint all deferred;
set constraint all immediate;

set constraint hr.sal_ck deferred;
set constraint all immediate;

select * from dba_constraints where owner='HR' and table_name='TEST';
select index_name, uniqueness, status from dba_indexes where owner='HR' and table_name='TEST';

select * from hr.test;

delete from hr.test where name = 'LUCAS';
insert into hr.test(id, name, phone) values(5,'oracle','010-0001-0001');

DROP index hr.test_id_pk;
rollback;

truncate table hr.exceptions;

alter table hr.test enable validate constraint test_id_pk exceptions into hr.exceptions;

select rowid from hr.exceptions;
select rowid, id, name, phone from hr.test where rowid in (select row_id from hr.exceptions);

update hr.test set id = 4 where rowid = 'AAASHMAAHAAAAIzAAC';

commit;

select * from hr.test;

select * from dba_constraints where owner='HR' and table_name='TEST';
select index_name, uniqueness, status from dba_indexes where owner='HR' and table_name='TEST';

drop table hr.test purge;

create table hr.test(
    id number constraint test_id_pk primary key,
    name varchar2(30),
    phone varchar2(20)
) tablespace users;

select * from dba_constraints where owner='HR' and table_name='TEST';
select * from dba_indexes where owner='HR' and table_name='TEST';

select * from hr.test;
select * from dba_constraints where owner='HR' and table_name='TEST';
select index_name, uniqueness, status from dba_indexes where owner='HR' and table_name='TEST';

