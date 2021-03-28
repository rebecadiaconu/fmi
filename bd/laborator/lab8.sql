-- LABORATOR 8


-- Ex 1
create table angajati_rdi (cod_ang number(4),
                           nume varchar2(20),
                           prenume varchar2(20),
                           email char(15),
                           data_ang date,
                           job varchar2(10),
                           cod_sef number(4),
                           salariu number(8, 2),
                           cod_dep number(2),
                           constraint p_key_rdi primary key(cod_ang) -- constrangere la nivel de tabel
                           );

drop table angajati_rdi;

create table angajati_rdi (cod_ang number(4) constraint p_key_rdi primary key, -- constrangere la nivel de coloana
                           nume varchar2(20) constraint nume_rdi not null,
                           prenume varchar2(20) constraint prenume_rdi not null,
                           email char(15),
                           data_ang date,
                           job varchar2(10),
                           cod_sef number(4),
                           salariu number(8, 2) constraint salariu_rdi not null,
                           cod_dep number(2)
                           );
                           
                           
-- Ex 2
insert into angajati_rdi (cod_ang, nume, prenume, job, salariu, cod_dep)
values (100, 'Nume1', 'Prenume1', 'Director', 20000, 10);

insert into angajati_rdi 
values (101, 'Nume2', 'Prenume2', 'Nume2', to_date('02-02-2004', 'DD-MM-YYYY'), 'Inginer', 100, 10000, 10, null);

insert into angajati_rdi 
values (102, 'Nume3', 'Prenume3', 'Nume3', to_date('05-06-2000', 'DD-MM-YYYY'), 'Analist', 101, 5000, 20, null);

insert into angajati_rdi (cod_ang, nume, prenume, job, cod_sef, salariu, cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
                           
insert into angajati_rdi
values (104, 'Nume5', 'Prenume5', 'Nume5', null, 'Analist', 101, 3000, 30, null);
rollback;
select * from angajati_rdi;
                           
                           
-- Ex 3
create table angajati10_rdi as select * from angajati_rdi where cod_dep = 10;
select * from angajati10_rdi;

desc angajati10_rdi;
desc angajati_rdi;


-- Ex 4
alter table angajati_rdi
add (comision number(4, 2));


-- Ex 5
-- incercam sa modificam salariu de la number(8,2) la number(6,2)
-- EROARE pentru ca coloana nu este goala
alter table angajati_rdi
modify (salariu number(6, 2));

-- in schimb putem creste precizia coloanei indiferent daca aceasta are doar null sau nu
alter table angajati_rdi
modify (salariu number(9, 2));


-- Ex 6
alter table angajati_rdi
modify (salariu default 222);

select * from angajati_rdi;


-- Ex 7
alter table angajati_rdi
modify (salariu number (10, 2), comision number (2, 2));


-- Ex 8
update angajati_rdi
set comision = 0.1
where lower(job) like 'a%';


-- Ex 9
alter table angajati_rdi
modify (email varchar2(20));


-- Ex 10
alter table angajati_rdi
add (nr_telefon varchar2(12) default '5722-233-345');


-- Ex 11
select * from angajati_rdi;

alter table angajati_rdi
drop column nr_telefon;


-- Ex 12
rename angajati_rdi to angajati3_rdi;


-- Ex 13
select * from tab; --tab = lista tabelelor

rename angajati3_rdi to angajati_rdi;


-- Ex 14
truncate table angajati10_rdi;


-- Ex 15
create table departamente_rdi (cod_dep number(2),
                               nume varchar2(15) constraint nume_dep_rdi not null,
                               cod_director number(4));

desc departamente_rdi;


-- Ex 16
insert into departamente_rdi
values (10, 'Administrativ', 100);

insert into departamente_rdi
values (20, 'Proiectare', 101);

insert into departamente_rdi (cod_dep, nume)
values (30, 'Programare');

select * from departamente_rdi;


-- Ex 17
alter table departamente_rdi
modify (cod_dep constraint p_key_dep_rdi primary key);


-- Ex 18
alter table angajati_rdi
add constraint fk_ang_dept_rdi foreign key(cod_dep) references departamente_rdi (cod_dep);

alter table angajati_rdi
add constraint kf_ang_sef_rdi foreign key(cod_sef) references angajati_rdi (cod_ang);

alter table angajati_rdi
add constraint np_unique_rdi unique (nume, prenume);

alter table angajati_rdi
add constraint email_unique_rdi unique (email);

alter table angajati_rdi
modify (nume constraint nume_nnull_rdi not null);

alter table angajati_rdi
add constraint verif_cod_dep check (cod_dep > 0);

alter table angajati_rdi
add constraint verif_salariu check (salariu > comision * 100);


--Ex 19
-- a)
select table_name, constraint_name, constraint_type
from user_constraints
where lower(table_name) in ('angajati_rdi', 'departamente_rdi');

-- b)
select table_name, constraint_name, column_name
from user_cons_columns
where lower(table_name) in ('angajati_rdi', 'departamente_rdi');


-- Ex 20
insert into angajati_rdi (cod_ang, nume, prenume, salariu, cod_dep)
values (203, 'Oprisan', 'Raul', 10000, null);

desc departamente_rdi;


-- Ex 21
insert into departamente_rdi
values (60, 'aAnaliza', null);
commit;


-- Ex 22
delete from departamente_rdi
where cod_dep = 20;


-- Ex 23
delete from departamente_rdi
where cod_dep = 60;

rollback;
SELECT * FROM departamente_rdi;

-- Ex 24
-- anularea constrangerii ref dde cod_dep
alter table angajati_rdi
drop constraint fk_ang_dept_rdi;

alter table angajati_rdi
add constraint fk_ang_dept_rdi foreign key(cod_dep)
references departamente_rdi(cod_dep) on delete cascade;


-- Ex 25
rollback;


-- Ex 26
alter table angajati_rdi
add constraint verif_limita_salariu_rdi check (salariu < 30001);


-- Ex 27
update angajati_rdi
set salariu = 35000
where cod_ang = 100;


-- Ex 28
alter table angajati_rdi
drop constraint verif_limita_salariu_rdi;

-- sau
ALTER TABLE angajati_rdi DISABLE CONSTRAINT verif_limita_salariu_rdi;

select * from angajati_rdi;



