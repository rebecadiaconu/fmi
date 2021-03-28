-- RECAPITULARE 2

-- Ex 27
select e.destinatie "Excursie", ag.id_agentie "Agentie", sum(e.pret) "Valoare totala"
from excursie e join agentie ag on (e.cod_agentie = ag.id_agentie)
                join achizitioneaza a on (e.id_excursie = a.cod_excursie)
group by cube (ag.id_agentie, e.destinatie);


-- Ex 28
select ag.id_agentie "Agentie", to_char(a.data_achizitie, 'YYYY') "An", sum(e.pret) "Suma totala"
from excursie e join agentie ag on (e.cod_agentie = ag.id_agentie)
                join achizitioneaza a on (e.id_excursie = a.cod_excursie)
group by rollup((ag.id_agentie, to_char(a.data_achizitie, 'YYYY')));


-- Ex 29
select denumire, id_excursie
from excursie e
where cod_agentie is null
and not exists (select *
                from turist t join achizitioneaza a on (t.id_turist = a.cod_turist)
                where to_char(t.data_nastere, 'YYYY') = '1984'
                and e.id_excursie = a.cod_excursie);


-- Ex 30
create table turist_rdi as select * from turist;
create table achiz_rdi as select * from achizitioneaza;
create table excursie_rdi as select * from excursie;
create table agentie_rdi as select * from agentie;

-- primary key
alter table turist_rdi
add constraint pk_turist_rdi primary key(id_turist);

alter table achiz_rdi
add constraint pk_achiz_rdi primary key(data_start, cod_turist, cod_excursie);

alter table agentie_rdi
add constraint pk_agentie_rdi primary key(id_agentie);

alter table excursie_rdi
add constraint pk_excursie_rdi primary key(id_excursie);

-- foreign key
alter table achiz_rdi
add constraint fk1_achiz_turist_rdi foreign key(cod_turist) references turist_rdi(id_turist) on delete cascade;

alter table achiz_rdi
add constraint fk1_achiz_excursie_rdi foreign key(cod_excursie) references excursie_rdi(id_excursie) on delete cascade;

alter table excursie_rdi
add constraint fk1_excursie_ag_rdi foreign key(cod_agentie) references agentie_rdi(id_agentie) on delete cascade;


-- Ex 31
update achiz_rdi
set discount = (select max(discount) from achiz_rdi)
where cod_excursie in (select id_excursie 
                        from excursie_rdi
                        where pret > (select avg(pret)
                                      from excursie_rdi));
ROLLBACK;
                               

-- Ex 32
delete from excursie_rdi e
where pret < (select avg(pret)
              from excursie_rdi b
              where b.cod_agentie = e.cod_agentie);


-- Ex 33
alter table excursie_rdi
drop constraint fk1_excursie_ag_rdi;

insert into excursie_rdi
values (204, 'Ulalala', 2750, 'Bali', 10, 85, 3);


insert into excursie_rdi
values (205, 'Aloha', 3850, 'Maldives', 7, 75, 2);

select * from excursie_rdi;

update excursie_rdi
set cod_agentie = null
where cod_agentie not in (select id_agentie
                          from agentie_rdi);

rollback;


-- Ex 35
delete from achiz_rdi;
select * from achiz_rdi;
savepoint a;

select * from excursie_rdi;

-- Ex 36
insert into achiz_rdi
select cod_excursie, cod_turist, add_months(data_start, 1), add_months(data_end, 1), data_achizitie, discount
from achizitioneaza
where to_char(data_achizitie, 'YYYY') = '2010';


-- Ex 37
update achiz_rdi
set discount = 1.1 * discount
where cod_excursie in (select id_excursie
                       from excursie_rdi
                       where cod_agentie = 10);


-- Ex 38
delete from achiz_rdi
where cod_turist in (select id_turist
                    from turist_rdi
                    where data_nastere is null);
                    
          
-- Ex 39 -1
MERGE INTO achizitioneaza_mn a2
USING achizitioneaza a
ON (a.cod_excursie = a2.cod_excursie and a.cod_turist = a2.cod_turist and a.data_start = a2.data_start)
WHEN MATCHED THEN
UPDATE SET
a2.data_end = a.data_end,
a2.data_achizitie = a.data_achizitie,
a2.discount = a.discount
WHEN NOT MATCHED THEN
INSERT VALUES (a.cod_excursie, a.cod_turist, a.data_start, a.data_end, a.data_achizitie, a.discount);

ROLLBACK TO a;
ROLLBACK;
          
                    
-- Ex 39 -2
update excursie_rdi
set pret = 0.9 * pret
where id_excursie in (select cod_excursie
                      from achiz_rdi
                      group by cod_excursie
                      having count(*) = (select max(count(*))
                                         from achiz_rdi
                                         group by cod_excursie));


--Ex 40
ALTER TABLE turist_mn
MODIFY (nume VARCHAR2(25) CONSTRAINT turist_nume_mn not null);

ALTER TABLE turist_mn
ADD CONSTRAINT turist_nume_unique_mn unique (nume, prenume);


-- Ex 41
alter table achiz_rdi
add constraint verif_data_rdi check (data_start < data_end);

alter table achiz_rdi
modify (data_achizitie date default sysdate);


-- Ex 42
select *
from achiz_rdi
where data_start > sysdate and data_achizitie = (select max(data_achizitie)
                                                from achiz_rdi
                                                where data_start > sysdate)
for update; -- blocam linia pt update
           
           
update achiz_rdi
set data_achizitie = default
where data_start > sysdate and data_achizitie = (select max(data_achizitie)
                                                from achiz_rdi
                                                where data_start > sysdate);
                                     
                                                
-- Ex 43
select nume, prenume
from turist t
where not exists (select cod_excursie
                  from achizitioneaza
                  where cod_turist = (select id_turist
                                      from turist
                                      where nume = 'Stanciu')
                  minus
                  select cod_excursie
                  from achizitioneaza a
                  where a.cod_turist = t.id_turist);
                  

-- Ex 44
select nume, prenume
from turist t
where not exists (select cod_excursie
                  from achizitioneaza a
                  where a.cod_turist = t.id_turist
                  minus
                  select cod_excursie
                  from achizitioneaza
                  where cod_turist = (select id_turist
                                      from turist
                                      where nume = 'Stanciu'));
                                      
                                      
-- Ex 45
select nume, prenume
from turist t
where not exists (select cod_excursie
                  from achizitioneaza
                  where cod_turist = (select id_turist
                                      from turist
                                      where nume = 'Stanciu')
                  minus
                  select cod_excursie
                  from achizitioneaza a
                  where a.cod_turist = t.id_turist)
      and
      not exists (select cod_excursie
                  from achizitioneaza a
                  where a.cod_turist = t.id_turist
                  minus
                  select cod_excursie
                  from achizitioneaza
                  where cod_turist = (select id_turist
                                      from turist
                                      where nume = 'Stanciu'));


-- Ex 46
ACCEPT p_id_turist PROMPT "id_turist = ";
INSERT INTO turist_rdi
VALUES(&p_id_turist, &p_nume, null, to_date('28-05-2020', 'DD-MM-YYYY'));

SELECT &p_id_turist FROM dual;


-- Ex 47
UPDATE turist_mn
SET prenume = 'Ion'
WHERE id_turist = 100;

--Ex 48

DELETE 
FROM turist_mn
WHERE id_turist = 100;

SELECT nume, prenume
FROM turist_mn
WHERE id_turist = 100;


