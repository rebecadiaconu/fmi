-- LABORATOR 7 (SUBPROGRAME) 

-- PROCEDURI LOCALE

-- Ex 1

declare
    procedure insertDEPT (dep_id dept.department_id%type, dep_name dept.department_name%type, manager_cod dept.manager_id%type, loc_cod dept.location_id%type, info dept.informatii%type)
    is 
    begin
        insert into dept values(dep_id, dep_name, manager_cod, loc_cod, info);
    end insertDEPT;
begin
    insertDEPT(800, 'IDK', 15, 87, null);
end;
/

select * from dept where department_id = 800;

rollback;


-- Ex 2
set serveroutput on;

declare
    v_rez employees.last_name%type;

    procedure numeAng (p_rezultat in out employees.last_name%type, p_comision in employees.commission_pct%type := null, p_cod in employees.employee_id%type := null)
    is
    begin
        if p_comision is null then
            select last_name into p_rezultat
            from employees
            where employee_id = p_cod;
        else
            select last_name into p_rezultat
            from employees
            where salary = (select max(salary)
                            from employees
                            where commission_pct = p_comision);
        end if;
    end numeAng;
begin
    numeAng(v_rez, 0.1, 116);
    dbms_output.put_line(v_rez);
    
    numeAng(v_rez, null, 116);
    dbms_output.put_line(v_rez);
end;
/

select * from employees where commission_pct = 0.1;

-- Ex 3
create or replace procedure dayTime is
    begin
        dbms_output.put_line('Programare PL/SQL');
        dbms_output.put_line(to_char(sysdate, 'DD-MONTH-YYYY hh24:mm:ss'));
        dbms_output.put_line(to_char(sysdate - 1, 'DD-MONTH-YYYY'));
     end dayTime;
     /
     
execute dayTime;


-- Ex 4
drop procedure dayTime;

create or replace procedure dayTime2 (p_nume in varchar2) is
    begin
        dbms_output.put_line(p_nume || ' invata programare PL/SQL');
    end dayTime2;
    /
    
execute dayTime2('Rebeca');


-- Ex 5

create table jobs2 as select * from jobs;
alter table jobs2 add constraint pk_jobs primary key(job_id);

-- b)
create or replace procedure addJob(p_id in jobs2.job_id%type, p_title in jobs2.job_title%type) is
    begin
        insert into jobs2(job_id, job_title) values(p_id, p_title);
    end addJob;
    /
    
execute addJob('DESIGN', 'BARFAAA');

select * from jobs2 where job_id = 'DESIGN';


-- Ex 6

set serveroutput on;

create or replace procedure updJob (p_id in jobs2.job_id%type, p_nume in jobs2.job_title%type) is
    begin
        update jobs2 
        set job_title = p_nume 
        where job_id = p_id;
        
        if sql%notfound then
            -- raise_application_error(-20202, 'Nici o actualizare!');
            dbms_output.put_line('Nici o actualizare!');
        end if;
    end updJob;
    /

execute updJob('AD_PRES', 'Data Administrator');
execute updJob('IT_WEB', 'Web master');

select * from jobs2;

-- Ex 7

create or replace procedure delJob (p_id in jobs2.job_id%type) is
    begin
        delete from jobs2 where job_id = p_id;
        if sql%notfound then
            raise_application_error(-20202, 'Nici o stergere!');
--            dbms_output.put_line('Nici o stergere!');
        else
            dbms_output.put_line(sql%rowcount);
        end if;
    end delJob;
    /

execute delJob('IT_DBA');
execute delJob('AD_PRES');
rollback;

-- Ex 8

create or replace procedure salMediu (p_rez out employees.salary%type) is
    begin
        select avg(salary) into p_rez
        from employees;
    end salMediu;
    /


variable g_medie number;    
execute salMediu(:g_medie);
print g_medie; 


-- Ex 9
create or replace procedure updSal (p_sal in out employees.salary%type) is
    begin
        if p_sal is null then
            p_sal := 1000;
        elsif p_sal < 3000 then
            p_sal := 1.2 * p_sal;
        elsif p_sal <= 7000 then
            p_sal := 1.15 * p_sal;
        else
            p_sal := 1.1 * p_sal;
        end if;
    end updSal;
    /

set serveroutput on;    

variable g_sal number;
accept p_sal prompt 'salariu = ?';

begin
    :g_sal := &p_sal;
--    updSal(:g_sal);
end;
/

execute updSal(:g_sal);
print g_sal;


-- Ex 10
create or replace procedure getEmp(p_id in employees.employee_id%type, p_sal out employees.salary%type, nume_job out jobs.job_title%type) is
    begin
        select salary, job_title into p_sal, nume_job
        from employees join jobs using(job_id)
        where employee_id = p_id;
        
        if sql%notfound then
            dbms_output.put_line('Nu am gasit o potrivire!');
        end if;
    exception
        when no_data_found then raise_application_error(-20202, 'Nu am gasit o potrivire!');
    end getEmp;
    /
    
variable g_sal number;
variable g_nume varchar2;

execute getEmp(100, :g_sal, :g_nume);
print g_sal;
print g_nume;

execute getEmp(null, :g_sal, :g_nume);
print g_sal;
print g_nume;


-- Ex 11
set serveroutput on;

create or replace procedure proc11 (p_cod in departments.department_id%type)
is
    function f1(p_cod departments.department_id%type)
    return number
    is
    nr_ang number(8);
    begin
        select count(*) into nr_ang
        from employees
        where department_id = p_cod;
        return nr_ang;
    end;
    
    function f2(p_cod departments.department_id%type)
    return number
    is
    suma number(8);
    begin
        select sum(salary) into suma
        from employees
        where department_id = p_cod;
        return suma;
    end;
    
    function f3(p_cod departments.department_id%type)
    return number
    is
    nr_manageri number(8);
    begin
        select count(distinct manager_id) into nr_manageri
        from employees
        where department_id = p_cod;
        return nr_manageri;
    end;
        
begin
    dbms_output.put_line(f1(p_cod));
    dbms_output.put_line(f2(p_cod));
    dbms_output.put_line(f3(p_cod));
end proc11;
/

execute proc11(50);


-- Ex 12
declare
    p_cod number := &p_cod;
    j_cod varchar2(40) := '&job';
    media_sal number(8);
    function medie (p_cod employees.department_id%type) 
    return number 
    is
        v_medie number(8);
    begin
        select avg(salary) into v_medie
        from employees
        where department_id = p_cod;
        return v_medie;
    end;
    
    function medie2 (p_cod departments.department_id%type, cod_job jobs.job_id%type)
    return number
    is
        v_medie number(8);
    begin
        select avg(salary) into v_medie
        from employees
        where department_id = p_cod and job_id = cod_job;
        return v_medie;
    end;
begin
    dbms_output.put_line(medie(p_cod));
    dbms_output.put_line(medie2(p_cod, j_cod));
end;
/


-- Ex 13
create or replace function getJob (cod_job employees.job_id%type)
return varchar2
is
    nume varchar2(50);
begin
    select job_title into nume
    from jobs
    where job_id = cod_job;
    return nume;
end;
/

var g_nume varchar2(35);
exec :g_nume := getJob('SA_REP');
print g_nume;


-- Ex 14
create or replace function nrAng (cod employees.department_id%type)
return number
is
    nrAng number;
begin
    select count(*) into nrAng
    from employees
    where department_id = cod and hire_date >= to_date('01-JAN-1996');
    return nrAng;
end;
/

-- afisare cu variabila de legatura
variable g_nr number;
exec :g_nr := nrAng(50);
print g_nr;

-- afisare printr-o comanda sql
select nrAng(50) "Nr Angajati"
from dual;

-- afisare bloc pl/sql
set serveroutput on;

declare
    v_rez number;
begin
    select nrAng(50) into v_rez
    from dual;
    
    dbms_output.put_line(v_rez);
end;
/


-- Ex 15
create or replace function getAnual (salariu employees.salary%type, comision employees.commission_pct%type)
return number
is
    sal_anual number;
begin
    sal_anual := 12 * salariu * (1 + nvl(comision, 0));
    return sal_anual;
end;
/

select employee_id, last_name, salary, getAnual(salary, commission_pct) "Salariu anual", department_id
from employees
where department_id = 50;


-- Ex 16
-- a)
create or replace function valid_deptId (p_cod employees.department_id%type) 
return boolean
is
    cursor c_emp is select department_id from employees where department_id = p_cod;
    v_emp employees.department_id%type;
begin
    open c_emp;
    fetch c_emp into v_emp;
    
    if c_emp%rowcount > 0 then
        return True;
    else
        return False;
    end if;
    
    close c_emp;
end;
/

-- b)
create or replace procedure addEmp (fname in employees.first_name%type,
                                    lname in employees.last_name%type,
                                    email in employees.email%type,
                                    cod_job in employees.job_id%type default 'SA_REP',
                                    cod_manager in employees.manager_id%type default 145,
                                    salariu in employees.salary%type default 1000,
                                    comision in employees.commission_pct%type default 0,
                                    cod_dept in employees.department_id%type default 30)
is
    v_cod employees.employee_id%type; 
    v_hire_date employees.hire_date%type;
begin
    if valid_deptId(cod_Dept) then
        v_cod := employees_seq.nextval;
        v_hire_date := trunc(sysdate);
        insert into employees
        values (v_cod, 'nume1', 'nume2', email, null, v_hire_date, cod_job, salariu, comision, cod_manager, cod_dept);
    else
        raise_application_error(-20202, 'Departamenul nu exista!');
    end if;
end addEmp;
/

-- c)
execute addEmp(lname => 'Harris', fname => 'Jane', email => 'jharris@gmail.com', cod_dept => 15);
execute addEmp(lname => 'Harris', fname => 'Jane', email => 'jharris@yahoo.com', cod_dept => 110);

rollback;


-- Ex 17
create or replace function nrPermut(n in number)
return number
is
begin
    if n = 1 then 
        return 1;
    else
        return n * nrPermut(n - 1);
    end if;
end;
/

set serveroutput on;

begin
    dbms_output.put_line(nrPermut(4));
end;
/


-- Ex 18
set serveroutput on;

create or replace function valMedie return number
is
    v_medie number;
begin
    select avg(salary) into v_medie
    from employees;
    
    return v_medie;
end;

variable g_med number;
exec :g_med := valMedie;
print g_med;

select last_name, salary, job_id
from employees
where salary >= :g_med;


-- Ex 19
-- a)
SELECT OBJECT_NAME, OBJECT_TYPE, STATUS
FROM USER_OBJECTS
WHERE OBJECT_TYPE IN ('PROCEDURE','FUNCTION'); 

-- b)
SELECT TEXT
FROM USER_SOURCE
WHERE NAME = 'GETJOB'
ORDER BY LINE; 

-- c)
describe getJob;


-- EXERCITII PROPUSE

-- Ex 1
create or replace procedure ex1 (sal_nou in employees.salary%type, dept in employees.department_id%type)
is
    medie number;
    function medieDept (cod_dept in employees.department_id%type)
    return number
    is
        v_medie number := 0;
    begin
        select avg(salary) into v_medie
        from employees
        where department_id = cod_dept;
        
        return v_medie;
    exception
        when no_data_found then raise_application_error(-20202, 'Departamentul nu exista!');
    end;
begin
    medie := medieDept(dept);
    
    update employees
    set salary = salary + sal_nou
    where commission_pct is null and salary < medie;
end ex1;
/

execute ex1(100, 80);


-- Ex 2
create or replace function hireDate (cod_m employees.manager_id%type)
return number
is
    nr number := 0;
begin
    select count(*) into nr
    from employees
    where hire_date > (select max(hire_date)
                       from employees
                       where manager_id = cod_m);
    return nr;
end hireDate;
/

set serveroutput on;

declare
    cod_m employees.manager_id%type := &cod;
begin
    dbms_output.put_line(hireDate(cod_m));
end;
/


-- Ex 3
declare
    v_loc locations%rowtype;
    procedure insertNew (loc locations%rowtype) is
    begin
        insert into locations values (loc.location_id, loc.street_address, loc.postal_code, loc.city, loc.state_province, loc.country_id);
    end insertNew;
begin
    v_loc.location_id := 123;
    v_loc.street_address := null;
    v_loc.postal_code := '117120';
    v_loc.city := 'Pitesti';
    v_loc.state_province := null;
    v_loc.country_id := 'IT';
    
    insertNew(v_loc);
end;
/

select * from locations;
rollback;


-- Ex 4
set serveroutput on;

declare
    v_rez number;
    procedure pro4 (p_rez out number, job_idd in jobs2.job_id%type default null, p_titlu in jobs2.job_title%type default null) 
    is
    begin
        if job_idd is not null then
            select count(*) into p_rez
            from employees
            where job_id = job_idd;
        else 
            select count(*) into p_rez
            from employees join jobs using (job_id)
            where upper(job_title) = upper(p_titlu);
        end if;
    exception
        when no_data_found then raise_application_error(-20202, 'Nu exista niciun job cu acest titlu!!');
    end pro4;
begin
    pro4(v_rez, 'IT_PROG', 'Designer');
    dbms_output.put_line(v_rez);
    pro4(v_rez, null, 'Finance Manager');
    dbms_output.put_line(v_rez);
    pro4(v_rez, null, 'Designer');
    dbms_output.put_line(v_rez);
end;
/

select * from jobs;


-- Ex 6
set serveroutput on;

declare
    rezultat number;
    function f1 (cod_dep employees.department_id%type) 
    return number
    is
        v_nr number;
    begin
        select count(*) into v_nr
        from employees
        where department_id = cod_dep;
        return v_nr;
    end f1;
    
    function f1 (cod_dep employees.department_id%type, an number) 
    return number
    is
        v_nr number;
    begin
        select count(*) into v_nr
        from employees
        where department_id = cod_dep and extract(year from hire_date) = an;
        return v_nr;
    end f1;
    
    function f1 (cod_dep employees.department_id%type, an number, sal number) 
    return number
    is
        v_nr number;
    begin
        select count(*) into v_nr
        from employees
        where department_id = cod_dep and extract(year from hire_date) = an and salary > sal;
        return v_nr;
    end f1;
begin
    rezultat := f1(50);
    dbms_output.put_line(rezultat);
    rezultat := f1(50, 1997);
    dbms_output.put_line(rezultat);
    rezultat := f1(50, 1997, 5000);
    dbms_output.put_line(rezultat);
end;
/


-- Ex 7
create or replace function factorial (n in number) 
return number
is
begin
    if n = 1 then
        return 1;
    else
        return n * factorial(n - 1);
    end if;
end;
/

create or replace function combinari (n in number, k in number) 
return number
is
begin
    return factorial(n) / (factorial(k) * factorial(n - k));
end;
/

variable g_var number;
exec :g_var := combinari(5, 2);
print g_var;


-- Ex 8
create or replace procedure updEmp (dep number, emp number) 
is
begin
    update employees set salary = (select avg(salary) from employees where department_id = dep) where employee_id = emp;
    if sql%rowcount > 0 then
        dbms_output.put_line('reusit!');
    else
        dbms_output.put_line('nu!');
    end if;
exception
    when no_data_found then raise_application_error(-20202, 'Fie nu exista codul de angajat, fie cel de departament');
end updEmp;
/

set serveroutput on;

execute updEmp(50, 108);


-- Ex 9
set serveroutput on;

create or replace function vechime (emp employees.employee_id%type)
return number
is
    nr_luni number;
begin
    select round(months_between(sysdate, hire_date)) into nr_luni
    from employees
    where employee_id = emp;
    return nr_luni;
exception
    when no_data_found then raise_application_error(-20202, 'Angajat negasit');
end vechime;
/

begin
    dbms_output.put_line(vechime(107) || ' luni de vechime.');
end;
/








