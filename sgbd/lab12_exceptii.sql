-- LABORATOR 12 - EXCEPTII

-- Ex 1
create table erori(
    cod_eroare number,
    mesaj_eroare varchar2(100)
);

set serveroutput on;

-- var 1: prinderea erorii de sistem
declare
    eroare_cod number;
    eroare_mesaj varchar2(100); 
    v_cod_dept number := &cod_dept;
    v_ang employees%rowtype;
begin
    select * into v_ang
    from (select *
          from emp
          where department_id = v_cod_dept
          order by hire_date desc)
    where rownum = 1;
    
    dbms_output.put_line(v_ang.employee_id || ' ' || v_ang.last_name || ' ' || v_ang.hire_date || ' ' || v_ang.department_id);
exception
    when others then
        eroare_cod := sqlcode;
        eroare_mesaj := substr(sqlerrm, 1, 100);
        insert into erori values(eroare_cod, eroare_mesaj);
end;
/

select department_id from emp;

select * from erori;

-- var 2: eroare definita de utilizator
declare
    eroare_cod number;
    eroare_mesaj varchar2(100); 
    v_cod_dept number := &cod_dept;
    v_ang employees%rowtype;
    
    v_count number;
    exceptie exception;
begin
    select count(*) into v_count
    from emp
    where department_id = v_cod_dept and hire_date = (select max(hire_date)
                                                      from emp
                                                      where department_id = v_cod_dept);
    
    if v_count != 1 then
        raise exceptie;
    end if;
    
    select * into v_ang
    from emp
    where department_id = v_cod_dept and hire_date = (select max(hire_date)
                                                      from emp
                                                      where department_id = v_cod_dept);
    
    dbms_output.put_line(v_ang.employee_id || ' ' || v_ang.last_name || ' ' || v_ang.hire_date || ' ' || v_ang.department_id);
exception
    when exceptie then
        eroare_cod := sqlcode;
        eroare_mesaj := substr(sqlerrm, 1, 100);
        insert into erori values(eroare_cod, eroare_mesaj);
end;
/


-- Ex 2
create table mesaje(
    rezultate varchar2(50)
);

-- drop table mesaje;

declare
    v_loc locations.location_id%type := &locatie;
    v_nume departments.department_name%type;
    v_manager departments.manager_id%type;
begin
    select d.department_name, d.manager_id into v_nume, v_manager
    from dept d
    where d.location_id = v_loc and (select count(*)
                                   from emp e
                                   where e.department_id = d.department_id) > 0;
                                   
    insert into mesaje values(v_nume || ' ' || to_char(v_manager));
exception
    when no_data_found then
        insert into mesaje values('nici un departament');
    when too_many_rows then
        insert into mesaje values('mai multe departamente');
    when others then
        insert into mesaje values('alte erori au aparut');
end;
/

select * from mesaje;

select distinct location_id from dept;


-- Ex 3
alter table dept
add constraint pk_dep primary key(department_id);

alter table emp
add constraint fk_emp_dep foreign key (department_id) references dept;

delete from dept where department_id = 30;

set verify off;

set serveroutput on;

declare
    nume_dept varchar2(50) := '&nume_dept';
    ang_exista exception;
    pragma exception_init(ang_exista, -2292);
begin
    delete from dept where department_name = nume_dept;
    commit;
exception
    when ang_exista then
        dbms_output.put_line('nu puteti sterge departamentul cu numele ' || nume_dept ||
        ' deoarece exista angajati care lucreaza in cadrul acestuia'); 
end;
/

set verify on;


-- Ex 4
variable g_mesaj varchar2(100)
set verify off;
declare
    v_count number;
    val number := &valoare;
    v_inf number := val - 1000;
    v_sup number := val + 1000;
    nobody exception;
    toomany exception;
begin
    select count(distinct department_id) into v_count
    from emp e1
    where exists (select 1
                  from emp e2
                  where e2.salary between v_inf and v_sup and e2.department_id = e1.department_id);
    
    if v_count = 0 then
        raise nobody;
    elsif v_count > 1 then
        raise toomany;
    end if;
exception
    when nobody then
        :g_mesaj := 'nu exista nici un departament';
    when toomany then
        :g_mesaj := 'exista ' || v_count || ' departamente';
end;
/

set verify on;

print g_mesaj


-- Ex 5
-- a)
begin
    delete from emp where department_id not in (select distinct department_id from dept);
    
    if sql%notfound then 
        raise_application_error(-20002, 'niciun angajat nu lucreaza intr-un departament inexistent');
    end if;
    
exception
    when no_data_found then
        raise_application_error(-20002, 'niciun angajat nu lucreaza intr-un departament inexistent');
end;
/

-- b)
declare
    nobody exception;
    pragma exception_init(nobody, -20002);
begin
    delete from emp e
    where e.salary * e.commission_pct > ((select e2.salary
                                          from emp e2
                                          where e2.employee_id = e.manager_id) - e.salary) / 2;
                                          
    if sql%notfound then
        raise nobody;
    end if;
exception
    when nobody then
        raise_application_error(-20002, 'nici o stergere!!');
end;
/


-- Ex 6
create or replace trigger sal_minim
before insert on emp
for each row
begin
    if :new.salary < 1000 then
        raise_application_error(-20005, 'salariul minim este 1000');
    end if;
end;

select max(employee_id) from emp;

set serveroutput on;
declare 
    sal_mini exception;
    pragma exception_init(sal_mini, -20003);
    cod_emp number;
begin
    select max(employee_id) + 1 into cod_emp
    from emp;
    
    insert into emp(employee_id, last_name, email, hire_date, salary) values(cod_emp, 'aa', 'abc@yhaoo.com', sysdate, 997);
exception
    when sal_mini then
        dbms_output.put_line('triggerul sal_minim a intors exceptia: ' || sqlerrm);
end;
/


-- Ex 7

-- NU VREA SA MEARGA, NU STIU DC

declare
    v_cod emp.employee_id%type := -1;
    salariu emp.salary%type := 0;
    cod_dept dept.department_id%type := &cod;
begin
    delete from mesaje;
    v_cod := -1;
    salariu := 0;
    
    <<subbloc>>
    begin
        select employee_id, salary into v_cod, salariu
        from emp
        where salary = (select min(salary)
                        from emp
                        where department_id = cod_dept);
    exception
        when no_data_found then
            raise_application_error(-20002, 'nimic gasit!');
        when too_many_rows then
            raise_application_error(-20003, 'prea multe!');
    end <<subbloc>>
    
    dbms_output.put_line('daa');
    insert into mesaje values(v_cod || ' ' || salariu);
end;
/

set serveroutput on;
select * from mesaje;


-- Ex 8
-- var 1
declare
    nume emp.last_name%type;
    sal emp.salary%type;
    vechime number(2);
    emp_cod emp.employee_id%type;
    hireDate emp.hire_date%type;
    v_count number := 1;
begin
    select last_name, salary, round((sysdate - hire_date)/365) into nume, sal, vechime
    from emp e
    where department_id in (select department_id
                           from emp
                           group by department_id
                           having avg(salary) = (select min(avg(salary))
                                                from emp
                                                group by department_id))
    and salary = (select max(salary)
                  from emp
                  where department_id = e.department_id);
    v_count := 2;
    
    select employee_id, hire_date into emp_cod, hireDate
    from emp join dept using (department_id)
             join locations using (location_id)
    where city = 'Oxford' and salary = (select max(salary)
                                       from emp join dept using (department_id)
                                                join locations using(location_id)
                                       where city = 'Oxford');
    v_count := 3;
    
    select last_name, salary into nume, sal
    from emp
    where hire_date = (select max(hire_date)
                       from emp);
    
exception
    when too_many_rows then
        insert into mesaje values('comanda ' || to_char(v_count) || ' gaseste prea multe randuri');
end;
/

-- var 2: introducerea fiecarui select intr-un subbloc + insert ul respectiv
declare
    nume emp.last_name%type;
    sal emp.salary%type;
    vechime number(2);
    emp_cod emp.employee_id%type;
    hireDate emp.hire_date%type;
begin
    begin
        -- ...
    end;
    
    begin
        -- ...
    end;
    
    begin
        -- ...
    end;
end;
/

delete from mesaje;
select * from mesaje;

-- Ex 9
declare
    v_var number(10, 3);
begin
    begin
        select salary / commission_pct into v_var
        from emp
        where hire_date = (select min(hire_date) from emp);
        
        insert into mesaje values(v_var);
    exception
        when zero_divide then
            goto eticheta;
    end;
    <<eticheta>>
    v_var := 0;
    insert into mesaje values(v_var);
end;
/

select * from mesaje;


-- Ex 10
set serveroutput on;

declare
    e2 exception;
    e1 exception;
begin
    begin
        begin
            raise e1;
        end;
        raise e2;
    exception
        when e1 then
            dbms_output.put_line('...............');
    end;
exception
    when e2 then
        dbms_output.put_line('LLlla');
end;
/


-- Ex 11
begin
    declare
        nr_dep number := 'XZY';
    begin
        select count(distinct department_id) into nr_dep
        from emp;
    exception
        when others then
            dbms_output.put_line('Eroare bloc intern: ' || sqlerrm);
    end;
exception
    when others then
        dbms_output.put_line('Eroare bloc extern ' || sqlerrm);
end;
/


-- Ex 12
declare
    e1 exception;
    e2 exception;
begin
    begin
        raise e1;
    exception
        when e1 then
            raise e2;
        when e2 then
            raise_application_error(-20002, 'interior');
    end;
exception
    when e2 then
        raise_application_error(-20003, 'exterior');
end;
/

