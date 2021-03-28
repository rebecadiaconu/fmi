-- RECAP TRIGGERI


create or replace package PdepDate as
    type r_dep is record (
    cod_dep emp.department_id%type,
    nr_ang number(4)
    );
    v_record r_dep;
    type t_dep is table of r_dep index by binary_integer;
    deps_info t_dep;
    v_NrIntrari binary_integer := 0;
end PdepDate;
/

select employee_id, hire_date from emp;

create or replace trigger get_dep_info
before insert or update of department_id on emp
for each row
declare
    
begin
    for id_dep in (select department_id from dept) loop
        PdepDate.v_NrIntrari := PdepDate.v_NrIntrari + 1;
        select department_id, count(*) into PdepDate.v_record
        from emp
        where department_id = id_dep
        group by department_id;
        
        PdepDate.deps_info(PdepDate.v_NrIntrari) := PdepDate.v_record;
        /*
        if deps_info(v_NrIntrari) > 50 then
            look_at(v_NrIntrari) := 0;
        else
            look_at(v_NrIntrari) := 1;
        end if;*/
    end loop;
end;
/

create or replace trigger check_limit
before insert or update of department_id on emp
for each row
declare
begin
    for i in 1..PdepDate.v_NrIntrari loop
        if(:new.department_id = PdepDate.deps_info(i).cod_dep) then
            PdepDate.deps_info(i).nr_ang := PdepDate.deps_info(i).nr_ang + 1;
            if(PdepDate.deps_info(i).nr_ang > 50) then
                raise_application_error(-20002, 'Angajatul cu ID-ul ' || :new.employee_id ||' nu poate fi introdus'
                || 'in departamentul cu ID-ul' || :new.department_id || ' deoarece s-a depasit limita de 50 ang!');
            end if;
        end if;
    end loop;
    PdepDate.v_NrIntrari := 0;
end;


-- Ex 10 LABORATOR
-- S? se implementeze cu ajutorul unui declan?ator restric?ia c? într-un departament pot lucra
-- maximum 50 de angaja?i. 

-- pas 1 -> creare pachet
create or replace package deptPachet
as
    type dept_tab is table of departments.department_id%type
    index by binary_integer;
    type emp_tab is table of employees.employee_id%type
    index by binary_integer;
    
    v_depts dept_tab;
    v_emps emp_tab;
    v_nrIntrari binary_integer := 0;
end;
/

-- pas 2 -> creare trigger la nivel de linie care foloseste tabelele indexate din pachet
create or replace trigger limitaDept
before insert or update of department_id on emp
for each row
begin
    deptPachet.v_nrIntrari := deptPachet.v_nrIntrari + 1;
    deptPachet.v_depts(deptPachet.v_nrIntrari) := :NEW.department_id;
    deptPachet.v_emps(deptPachet.v_nrIntrari) := :NEW.employee_id;
end;
/

-- pas 3 -> rezolvare cerinta, folosind un trigger la nivel de INSTRUCTIUNE, 
-- in loc de unul la nivel de linie
create or replace trigger limitaEmp
after insert or update of department_id on emp
declare
    nrMax constant number := 50;
    nrCurent number := 0;
    cod_emp number;
    cod_dept number;
begin
    for index_emp in 1..deptPachet.v_nrIntrari loop
        cod_emp := deptPachet.v_emps(index_emp);
        cod_dept := deptPachet.v_depts(index_emp);
        
        select count(*) into nrCurent
        from emp
        where department_id = cod_dept;
        
        if nrCurent + 1 > nrMax then
            raise_application_error(-20002, 'Departamentul ' || cod_dept || ' a depasit numarul de 50 de locuri odata cu introducerea angajatului ' || cod_emp);
        end if;
    end loop;
    deptPachet.v_nrIntrari := 0;
end;
/
alter table dept drop column total_sal;

insert into dept values(15, 'alabala', 100, 1000);

insert into emp(employee_id, last_name, first_name, department_id, email, hire_date, job_id) 
select SEQ_EMP.nextval, last_name, first_name, 15, email, sysdate, job_id
from emp 
where rownum <= 50;

insert into emp(employee_id, last_name, first_name, department_id, email, hire_date, job_id) 
values(701, 'aa', 'bbbbb', 15, 'email1@yahoo.com', sysdate, 10);


-- Ex 3 Model Test 2 link
-- e caz de table mutating
-- update enunt: pune in loc angajatul cu cea mai mare vechime din specializarea respectiva

create or replace package pachet
as
    type managerTab is table of employees.manager_id%type
    index by binary_integer;
    type jobTab is table of employees.job_id%type
    index by binary_integer;
    
    v_manageri managerTab;
    v_joburi jobTab;
    nrIntrari binary_integer := 0;
end;
/


create or replace trigger deleteManager
before delete on emp
for each row
begin
    pachet.nrIntrari := pachet.nrIntrari + 1;
    pachet.v_manageri(pachet.nrIntrari) := :old.employee_id;
    pachet.v_joburi(pachet.nrIntrari) := :old.job_id;
end;
/


create or replace trigger updateManager
after delete on emp
declare
    cod_job emp.job_id%type;
    cod_manager emp.manager_id%type;
    managerNou emp.manager_id%type;
begin
    for index_emp in 1..pachet.nrIntrari loop
        cod_job := pachet.v_joburi(index_emp);
        cod_manager := pachet.v_manageri(index_emp);
        
        select employee_id into managerNou
        from emp
        where hire_date = (select min(hire_date)
                           from emp
                           where job_id = cod_job);
                           
        update emp set manager_id = managerNou where manager_id = cod_manager and job_id = cod_job;
        dbms_output.put_line(sql%rowcount);
    end loop;
    pachet.nrIntrari := 0;
end;
/

-- cautam managerii existenti
select distinct manager_id from emp;

-- vedem ce specializare/job are
select job_id from emp where employee_id = 124;

-- cu ce angajat va fi inlocuit
select employee_id, hire_date
from emp
where employee_id != 124 and hire_date = (select min(hire_date)
                   from emp
                   where job_id = 'ST_MAN');

-- ce randuri trebuie actualizate
select employee_id from emp where manager_id = 124;

-- in urma cautarii vom sterge angajatul cu id ul 124  => acesta va fi inlocuit cu 122
delete from emp where employee_id = 124;
rollback;
set serveroutput on;

-- verificam
select employee_id from emp where manager_id = 122;

-- alter trigger database_trigg disable;
-- select * from user_errors where type = 'TRIGGER' and name = 'UPDATEMANAGER';


-- Ex1 RECAPITULARE
-- S? se creeze un trigger care s? nu permit? m?rirea pre?ului unei excursii dac? achizi?ia este
-- efectuat? de cel mai vârstnic turist, respectiv mic?orarea pre?ului unei excursii dac? achizi?ia este
-- efectuat? de cel mai tânar turist. 

create or replace trigger updatePret
before update of pret on excursie
for each row
declare
    id_varstaMax number;
    id_varstaMin number;
    v_nr number := 0;
begin
    select id_turist into id_varstaMax
    from turist
    where data_nastere = (select min(data_nastere)
                          from turist);
                          
    select id_turist into id_varstaMin
    from turist
    where data_nastere = (select max(data_nastere)
                          from turist);
                          
    select count(*) into v_nr
    from ACHIZITIONEAZA
    where cod_excursie = :new.id_excursie and cod_turist = id_varstamax;
    
    if :new.pret < :old.pret and v_nr >= 1 then
        raise_application_error(-20002, 'prea batran, nu cresti pretul!');
    end if;
    
    select count(*) into v_nr
    from ACHIZITIONEAZA
    where cod_excursie = :new.id_excursie and cod_turist = id_varstamin;
    
    if :new.pret > :old.pret and v_nr >= 1 then
        raise_application_error(-20002, 'prea tanar, nu scazi pretul!');
    end if;
end;
/


set serveroutput on;

select * from turist order by data_nastere;
select * from achizitioneaza where cod_turist in (6,3);
select * from excursie where id_excursie in (1, 101, 301, 303);

update excursie set pret = pret + 100 where id_excursie = 101;

rollback;


-- alt trigger pe schema excursie
-- Definiti un trigger care sa permita achizitionarea doar daca mai exista locuri in acea excursie.
create or replace trigger achizitie
before insert on achizitioneaza
for each row
declare
    locuri number := 0;
begin
    select nr_locuri into locuri
    from excursie
    where id_excursie = :new.cod_excursie;
    
    if locuri <= 0 then
        raise_application_error(-20003, 'nu mai sunt locuri in aceasta excursie!');
    end if;
end;
/

select nr_locuri, id_excursie from excursie;
select id_turist from turist;

update excursie set nr_locuri = 0 where id_excursie = 102;

insert into achizitioneaza values(102, 2, sysdate - 5, sysdate, sysdate - 7, 0);



-- Ex 2 RECAPITULARE
-- Trigger care la ?tergerea unui angajat care este manager de specializare, pune în locul
-- acestuia angajatul care a avut cei mai mul?i pacien?i dintre personalul cu specializarea
-- respectiv? (se consider? c? acesta este unic).

create or replace package pacientiPack
as
    type personalTab is table of personal.id_salariat%type
    index by binary_integer;
    type specTab is table of personal.ID_specializare%type
    index by binary_integer;
    
    angajati personalTab;
    specs specTab;
    nrIntrari binary_integer := 0;
    
end;
/

create or replace trigger deleteSal
before delete on personal
for each row
declare
    managerSpec number;
begin
    select id_manager into managerSpec
    from specializare
    where id_specializare = :old.ID_specializare;
    
    if :old.id_salariat = managerSpec then
        pacientiPack.nrIntrari := pacientiPack.nrIntrari + 1;
        pacientiPack.angajati(pacientiPack.nrIntrari) := :old.id_salariat;
        pacientiPack.specs(pacientiPack.nrIntrari) := :old.ID_specializare;
        update specializare set id_manager = null where id_manager = :old.id_salariat;
    end if;
end;
/


create or replace trigger updateSpec
after delete on personal
declare
    cod_sal number;
    cod_spec number;
    managerNou number;
    nr_count number := 0;
    pacientiMax number := 0;
begin
    for indexSal in 1..pacientiPack.nrIntrari loop
        cod_sal := pacientiPack.angajati(indexSal);
        cod_spec := pacientiPack.specs(indexSal);
        
        for ang in (select * from personal where ID_specializare = cod_spec and id_salariat != cod_sal) loop            
            select count(*) into nr_count
            from trateaza
            where id_salariat = ang.id_salariat;
            
            if nr_count > pacientiMax then
                pacientiMax := nr_count;
                managerNou := ang.id_salariat;
                update specializare set id_manager = managerNou where id_manager = cod_sal;
                
                if sql%rowcount = 1 then
                    dbms_output.put_line('DONE! ' || managerNou);
                end if;
                
            end if;
        end loop;
    end loop;
    
    pacientiPack.nrIntrari := 0;
end;
/


select distinct id_manager, id_specializare from specializare;

select id_salariat from personal where ID_specializare = 10;

-- update specializare set id_manager = 59 where id_specializare = 10;

select * from trateaza;

select count(*), id_salariat
from trateaza
group by id_salariat
having id_salariat in (60, 61, 62, 63, 64);


-- data stergem 59 atunci ar trebui inlocuit cu 63
set serveroutput on;

delete from personal where id_salariat = 59;
rollback;


-- Ex 3 RECAPITULARE
-- S? se creeze un trigger prin care la inserarea unei noi vestimenta?ii pentru o prezentare,
-- suma valorilor vestimenta?iilor r?mâne mai mic? decât suma sponsoriz?rilor. Altfel, apare o excep?ie.


create or replace trigger insertVestim
before insert on vestimentatie
for each row
declare
    sumaVestim number := 0;
    sumaSponsor number := 0;
begin
    select sum(valoare) into sumaVestim
    from vestimentatie
    where cod_prezentare = :new.cod_prezentare;
    
    select sum(suma) into sumaSponsor
    from sustine
    where cod_pr = :new.cod_prezentare;
    
    if sumaVestim + :new.valoare >= sumaSponsor then
        raise_application_error(-20002, 'Suma depasita!');
    end if;
end;
/

select distinct cod_pr
from prezentare;

select sum(suma), cod_pr
from sustine
group by cod_pr;

insert into vestimentatie values(1000, 'pinky', 22000, 4505);

select * from vestimentatie;


-- Ex 4 RECAPITULARE
-- NU E GATA, MI A FOST LENE 

create or replace package ex4recap
as
    type inreg is record(
        cod_vestim number,
        suma number
    );
    
    cursor cursor_sus return sustine%rowtype;
    function depaseste(cod_pr in prezentare.cod_pr%type) return number;
    procedure celmaibineplatit(cod_pr in sustine.cod_pr%type, cod_sp out sustine.cod_sp%type, nume_sp sponsor.nume%type);
end;
/

create or replace package body ex4recap
as
    function depaseste(cod_pr in prezentare.cod_pr%type) return number
    is
        sumaV number := 0;
        sumaS number := 0;
    begin
        select sum(valoare) into sumaS
        from vestimentatie
        where cod_prezentare = cod_pr;
        
        select sum(suma) into sumaS
        from sustine
        where cod_pr = cod_pr;
        
        if sumaV > sumaS then
            return 1;
        
        return 0;
    end;
    
    procedure celmaibineplatit(cod_pr in sustine.cod_pr%type, cod_sp out sustine.cod_sp%type, nume_sp sponsor.nume%type)
    is
        idSp number;
    begin
        select cod_sp into idSp
        from sustine
        where cod_pr = cod_pr and suma = (select max(suma)
                                          from sustine
                                          where cod_pr = cod_pr);
                                          
        select cod_sponsor, nume into cod_sp, nume_sp
        from sponsor
        where cod_sponsor = idSp;
    end;
    
begin
end;
/


