-- RECAPITULARE 1

-- Ex 1
select denumire
from excursie
where id_excursie = (select cod_excursie
                    from achizitioneaza
                    where data_achizitie = (select min(data_achizitie)
                                            from achizitioneaza));
         
                                            
-- Ex 2
select id_excursie, denumire, 
(select count (*) from achizitioneaza where cod_excursie = id_excursie)
from excursie group by id_excursie, denumire;


-- Ex 3
select id_agentie, denumire, oras, 
(select count(*) from excursie where cod_agentie = id_agentie),
(select avg(pret) from excursie where cod_agentie = id_agentie)
from agentie
group by id_agentie, denumire, oras;


-- Ex 4
-- a)
select nume, prenume
from turist
where id_turist in (select cod_turist
                    from achizitioneaza
                    group by cod_turist
                    having count(*) >= 2);

-- b)
select count(*)
from turist
where 2 <= (select count(*)
            from achizitioneaza
            where cod_turist = id_turist);


-- Ex 5
select id_turist, nume, prenume
from turist
where id_turist not in (select cod_turist
                        from achizitioneaza e join excursie a on (e.cod_excursie = a. id_excursie)
                        where lower(destinatie) = 'paris');
                        
                        
-- Ex 6
select t.id_turist, t.nume
from turist t
where 2 <= (select count(distinct cod_excursie)
            from achizitioneaza 
            where cod_turist = t.id_turist);


-- Ex 7
select ag.denumire, sum(e.pret - e.pret * nvl(a.discount, 0)) "Profit"
from agentie ag join excursie e on (ag.id_agentie = e.cod_agentie)
                join achizitioneaza a on (e.id_excursie = a.cod_excursie)
group by ag.denumire;

-- Ex 8
select denumire, oras
from agentie
where 3 <= (select count(distinct id_excursie)
            from excursie
            where pret < 2000 and cod_agentie = id_agentie);
            
            
-- Ex 9
select id_excursie, denumire, destinatie
from excursie
where id_excursie not in (select distinct cod_excursie
                            from achizitioneaza);

-- sau
SELECT id_excursie
FROM excursie
MINUS
SELECT cod_excursie
FROM achizitioneaza;


-- Ex 10
select * from excursie;

select e.id_excursie, e.denumire, e.destinatie,
case
when e.cod_agentie is null then 'agentie necunoscuta'
else ag.denumire
end "Nume agentie"
from excursie e left outer join agentie ag on (e.cod_agentie = ag.id_agentie);

-- sau
SELECT e.id_excursie, NVL(a.denumire, 'Agentie necunoscuta')
FROM excursie e LEFT JOIN agentie a ON (e.cod_agentie = a.id_agentie);


-- Ex 11
select id_excursie
from excursie
where pret > (select pret
                from excursie
                where lower(denumire) = 'orasul luminilor' and cod_agentie = 10);


-- Ex 12
select distinct t.id_turist, t.nume, t.prenume
from turist t join achizitioneaza a on (t.id_turist = a.cod_turist)
where a.data_end - a.data_start + 1 > 10;


-- Ex 13
select distinct id_excursie
from excursie e join achizitioneaza a on (e.id_excursie  = a.cod_excursie)
                join turist t on (a.cod_turist = t.id_turist)
where months_between(sysdate, t.data_nastere)/12 <= 40;


-- Ex 14
select id_turist, nume, prenume
from turist t
where not exists (select a.cod_excursie
                  from achizitioneaza a join excursie e on (e.id_excursie = a.cod_excursie)
                                    join agentie ag on (e.cod_agentie = ag.id_agentie)
                  where a.cod_turist = id_turist and ag.oras = 'Bucuresti');


-- Ex 15
select nume, prenume, id_turist
from turist t
where exists (select e.id_excursie
              from excursie e join achizitioneaza a on (e.id_excursie = a.cod_excursie)
                              join agentie ag on (e.cod_agentie  = ag.id_agentie)
              where a.cod_turist = t.id_turist 
              and lower(e.denumire) like '%1 mai%'
              and ag.oras = 'Bucuresti');
              

-- Ex 16
select distinct t.nume, t.prenume, e.id_excursie, e.denumire
from turist t join achizitioneaza a on (t.id_turist = a.cod_turist)
              join excursie e on (a.cod_excursie = e.id_excursie)
              join agentie ag on (e.cod_agentie = ag.id_agentie)
where lower(ag.denumire) = 'smart tour';


-- Ex 17
select *
from excursie e
where 0 = (select count(*)
           from achizitioneaza a
           where a.cod_excursie = e.id_excursie and a.data_start = '14-AUG-2011');


-- Ex 18
select a.cod_turist, a.cod_excursie
from achizitioneaza a
where a.data_achizitie = (select max(data_achizitie)
                          from achizitioneaza e
                          where e.cod_turist = a.cod_turist)
order by 1;


-- Ex 19
select id_excursie, denumire, pret
from (select * from excursie order by pret desc)
where rownum <= 5;


-- Ex 20
select nume, prenume
from turist t
where to_char(data_nastere, 'MON') in (select to_char(data_start, 'MON')
                                        from achizitioneaza
                                        where cod_turist = t.id_turist);


-- Ex 21
select *
from turist
where id_turist in (select cod_turist
                    from achizitioneaza a join excursie e on (e.id_excursie = a.cod_excursie)
                                          join agentie ag on (e.cod_agentie = ag.id_agentie)
                    where e.nr_locuri = 2 and ag.oras = 'Constanta');


-- Ex 22
select cod_excursie "ID excursie",
case 
when data_end - data_start <= 5 then 'excursie cu durata mica'
when data_end - data_start between 6 and 19 then 'excursie cu durata medie'
else 'excursie cu durata lunga'
end "Tip excursie",
data_end - data_start "Durata"
from (select distinct cod_excursie, data_start, data_end from achizitioneaza order by (data_end - data_start));


-- Ex 23
select 
(select count(*)
 from excursie) "Numar excursii",
(select count(*) 
 from excursie e join agentie a on (e.cod_agentie = a.id_agentie) 
 where a.oras = 'Constanta') "Nr. ex Constanta",
(select count(*)
 from excursie e join agentie a on (e.cod_agentie = a.id_agentie)
 where a.oras = 'Bucuresti') "Nr. ex Bucuresti"
from dual;


-- Ex 24
select denumire
from excursie e 
where not exists (select id_turist
                  from turist 
                  where months_between(sysdate, data_nastere)/12 = 24
                  minus
                  select cod_turist
                  from achizitioneaza a
                  where e.id_excursie = a.cod_excursie);
                  
                  
-- Ex 25
select cod_agentie, destinatie, sum(pret), grouping(cod_agentie), grouping(destinatie)
from excursie
group by rollup(cod_agentie, destinatie);


-- Ex 26
select ag.id_agentie, avg(e.pret)
from agentie ag join agentie ag_1 using (oras)
                join excursie e on (e.cod_agentie = ag_1.id_agentie)
where ag.id_agentie != ag_1.id_agentie
group by ag.id_agentie;






