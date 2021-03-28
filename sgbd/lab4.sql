-- Laborator 4 COMPLET

-- EXEMPLU INTERATII
-- LOOP

set serveroutput on;
declare
    v_i number := 0;
begin
    loop
        dbms_output.put_line('Loop: ' || v_i);
        v_i := v_i + 1;
        exit when v_i > 10;
    end loop;
end;
/

-- WHILE
set serveroutput on;
declare
    v_i number := 0;
begin
    while v_i <= 10 loop
        dbms_output.put_line('While: ' || v_i);
        v_i := v_i + 1;
    end loop;
end;
/

-- FOR
declare
    v_i number := 0;
begin
    for v_i in 0..10 loop
        dbms_output.put_line('For: ' || v_i);
    end loop;
end;
/


-- EXEMPLE CURSOARE
-- VAR1: LOOP
declare
    cursor c_emp is select employee_id, first_name, last_name from employees where employee_id < 110;
    v_emp_id employees.employee_id%type;
    v_first_name employees.first_name%type;
    v_last_name employees.last_name%type;
begin
    open c_emp;
    loop
    -- sau mai putem incarca datele astfel:
    -- fetch c_mep into v_emp: si apoi apelam variabilele v_emp.nume_variabile, 
    -- unde v_emp e c_emp%ROWTYPE;
        fetch c_emp into v_emp_id, v_first_name, v_last_name;
        dbms_output.put_line(v_emp_id || ' ' || v_first_name || ' ' || v_last_name);
        exit when c_emp%NOTFOUND;  
    end loop;
    close c_emp;
end;
/

-- VAR2: WHILE
declare
    cursor c_emp is select employee_id, first_name, last_name from employees where employee_id < 110;
    v_emp_id employees.employee_id%type;
    v_first_name employees.first_name%type;
    v_last_name employees.last_name%type;
begin
    open c_emp;
    -- pentru a folosi while cu cursor treb 
    -- facut un fetch inainte de while, pt ca notfound are val null altfel
    fetch c_emp into v_emp_id, v_first_name, v_last_name;
    while c_emp%FOUND loop  
        dbms_output.put_line(v_emp_id || ' ' || v_first_name || ' ' || v_last_name);
        fetch c_emp into v_emp_id, v_first_name, v_last_name;
    end loop;
    close c_emp;
end;
/

-- VAR3: FOR
-- se da close automat
declare
    cursor c_emp is select employee_id, first_name, last_name from employees where employee_id < 110;
begin
    open c_emp;
    for v_emp in c_emp loop
        dbms_output.put_line(v_emp.v_emp_id || ' ' || v_emp.v_first_name || ' ' || v_emp.v_last_name);
    end loop;
end;
/


-- VAR4: Ciclu cursor cu subcerere (for)
begin
    for v_emp in (select employee_id, first_name, last_name from employees where employee_id < 110) loop
        dbms_output.put_line(v_emp.employee_id || ' ' || v_emp.first_name || ' ' || v_emp.last_name);
    end loop;
end;
/


-- Exercitii Instructiuni Iterative
set serveroutput on;

-- Ex 1
declare
    v_n number := &n;
    v_produs number := 1;
begin
    while v_n != 0 loop
        v_produs := v_produs * v_n;
        v_n := v_n - 1;
    end loop;
    
    dbms_output.put_line(v_produs);
end;
/


-- Ex 2

-- var EXIT
declare
    v_i positive := 1;
    c_max constant positive := 10;
begin
    loop
        v_i := v_i + 1;
        exit when v_i > c_max;
    end loop;
    
    dbms_output.put_line(v_i);
    v_i := 1;
    dbms_output.put_line(v_i);
end;
/

-- var GOTO
declare
    v_i positive := 1;
    c_max constant positive := 10;
begin
    loop
        v_i := v_i + 1;
        if v_i > c_max then
            goto resetValue;
        end if;
    end loop;
    
    << resetValue >>
    dbms_output.put_line(v_i);
    v_i := 1;
    dbms_output.put_line(v_i);
end;
/


-- Ex 3
--drop table org_tab;

create table org_tab (
    cod_tab integer,
    cod_nr integer,
    text_tab varchar2(20)
);

declare
    v_text org_tab.text_tab%type;
begin
    for v_i in 1..70 loop
        if v_i mod 2 = 0 then
            v_text := 'par';
        else
            v_text := 'impar';
        end if;
        
        insert into org_tab values(v_i, v_i * 100, v_text);
    end loop;
end;
/

select * from org_tab;


-- Ex 4
declare
    cursor cursor_dept is select distinct department_id from departments;
    nr_venit_mic number := 0;
    nr_venit_mare number := 0;
begin
--    open cursor_dept;
    for depart in cursor_dept loop
        nr_venit_mic := 0;
        nr_venit_mare := 0;
        dbms_output.put_line('Situatia in departamentul ' || depart.department_id);
        
        select count(employee_id) into nr_venit_mic
        from employees
        where department_id = depart.department_id and salary < 4000;
        
        select count(employee_id) into nr_venit_mare
        from employees
        where department_id = depart.department_id and salary > 4000;
        
        if nr_venit_mic = 0 and nr_venit_mare = 0 then
            dbms_output.put_line('Nu exista niciun angajat in acest departament care sa corespunda cerintelor.');
        else
            if nr_venit_mic = 0 then 
                dbms_output.put_line('nicio persoana cu venit mic');
            else 
                dbms_output.put_line(nr_venit_mic  || ' persoane cu venit mic');
            end if;
            
            if nr_venit_mare = 0 then
                dbms_output.put_line(' si nicio persoana cu venit mare ');
            else 
                dbms_output.put_line(' si ' || nr_venit_mare || ' persoane cu venit mare.');
            end if;
        end if;
        
    end loop;
--    close cursor_dept; 
end;


-- Exercitii Cursoare
set serveroutput on;

-- Ex 6
-- loop
declare
    cursor c_emp is select last_name, salary, commission_pct from employees where department_id = 50 order by last_name;
    v_nume employees.last_name%type;
    v_salariu employees.salary%type;
    v_comision employees.commission_pct%type;
    v_salariu_anual employees.salary%type;
begin
    open c_emp;
    loop
        fetch c_emp into v_nume, v_salariu, v_comision;
        v_salariu_anual := (1 + nvl(v_comision, 0)) * v_salariu * 12;
        dbms_output.put_line(v_nume || ' are salariul anual ' || v_salariu_anual);
        exit when c_emp%notfound;
    end loop;
    close c_emp;
end;
/

-- while
declare
    cursor c_emp2 is select last_name, salary, commission_pct from employees where department_id = 50 order by last_name;
    v_emp c_emp2%rowtype;
    v_salariu_anual employees.salary%type;
begin
    open c_emp2;
    fetch c_emp2 into v_emp;
        
    while c_emp2%found loop
        v_salariu_anual := (1 + nvl(v_emp.commission_pct, 0)) * v_emp.salary * 12;
        dbms_output.put_line(v_emp.last_name || ' are salariul anual ' || v_salariu_anual);
        fetch c_emp2 into v_emp;
    end loop;
    close c_emp2;
end;
/

-- for
declare
    cursor c_emp2 is select last_name, salary, commission_pct from employees where department_id = 50 order by last_name;
    v_salariu_anual employees.salary%type;
begin
    for v_emp in c_emp2 loop
        v_salariu_anual := (1 + nvl(v_emp.commission_pct, 0)) * v_emp.salary * 12;
        dbms_output.put_line(v_emp.last_name || ' are salariul anual ' || v_salariu_anual);
    end loop;
end;
/

-- for cu subcerere
declare
    v_salariu_anual employees.salary%type;
begin
    for v_emp in (select last_name, salary, commission_pct from employees where department_id = 50 order by last_name) loop
        v_salariu_anual := (1 + nvl(v_emp.commission_pct, 0)) * v_emp.salary * 12;
        dbms_output.put_line(v_emp.last_name || ' are salariul anual ' || v_salariu_anual);
    end loop;
end;
/


-- Ex 7
declare
    v_sal employees.salary%type := &salariu;
begin
    update emp set commission_pct = nvl(commission_pct, 0) + 0.1 where salary < v_sal;
    if sql%found then
        dbms_output.put_line('Nr linii actualizate: ' || sql%rowcount);
    else
        dbms_output.put_line('Nicio linie actualizata.');
    end if;
end;
/


-- Ex 8
set serveroutput on;

declare
    v_dept_id10 departments.department_id%type := &cod_dept1;
    v_dept_id20 departments.department_id%type := &cod_dept2;
    cursor dept10_cur (cod_dept number) is select sum(salary)total_sales from emp where department_id = cod_dept;
    cursor dept20_cur (cod_dept number) is select sum(salary)total_sales from emp where department_id = cod_dept;
    dept10_rec dept10_cur%rowtype;
    dept20_rec dept20_cur%rowtype;
begin
    open dept10_cur(v_dept_id10);
    fetch dept10_cur into dept10_rec;
    dbms_output.put_line('Total for department ' || v_dept_id10 || ' is ' || dept10_rec.total_sales);
    close dept10_cur;
    
    if dept20_cur%isopen then close dept20_cur;
    end if;
    
    open dept20_cur(v_dept_id20);
    fetch dept20_cur into dept20_rec;
    dbms_output.put_line('Total for department ' || v_dept_id20 || ' is ' || dept20_rec.total_sales);
    close dept20_cur;
end;
/


-- Ex 9
create table top_salarii (
    salary number(10, 2)
);

accept p_num prompt 'nr_ang = ?';

declare
    v_num number := &p_num;
    v_sal top_salarii.salary%type;
    cursor emp_cursor is select salary from employees order by salary desc;
begin
    open emp_cursor;
    for v_i in 1..v_num loop
        fetch emp_cursor into v_sal;
        insert into top_salarii values(v_sal);
    end loop;
    close emp_cursor;
end;
/

select * from top_salarii;

drop table top_salarii;


-- Ex 10
set serveroutput on;

declare
    cursor dept_cur2 is select department_name, count(*)nrAng from employees join departments using (department_id) group by department_name;
begin
    if dept_cur2%isopen then close dept_cur2;
    end if;
        
    for dept in dept_cur2 loop
        if dept.nrAng = 0 then
            dbms_output.put_line('In departamentul ' || dept.department_name || ' nu lucreaza angajati.');
        elsif dept.nrAng = 1 then
            dbms_output.put_line('In departamentul ' || dept.department_name || ' lucreaza un angajat.');
        else 
            dbms_output.put_line('In departamentul ' || dept.department_name || ' lucreaza ' || dept.nrAng || ' angajati.');
        end if;
    end loop;
end;
/


-- Ex 11

-- cursor explicit
declare
    val_x number := &nr_ang_min;
    cursor cur_dep is select department_name, count(*)nrAng from employees join departments using (department_id) group by department_name having count(*) >= val_x; 
begin
    if cur_dep%isopen then close cur_dep;
    end if;
    
--    open cur_dep;
    for dept in cur_dep loop
        if dept.nrAng = 0 then
            dbms_output.put_line('In departamentul ' || dept.department_name || ' nu lucreaza angajati.');
        elsif dept.nrAng = 1 then
            dbms_output.put_line('In departamentul ' || dept.department_name || ' lucreaza un angajat.');
        else 
            dbms_output.put_line('In departamentul ' || dept.department_name || ' lucreaza ' || dept.nrAng || ' angajati.');
        end if;
    end loop;
end;
/


-- cursor implicit

-- DE FACUT CU VARRAY SAU TABEL INDEXAT DUPA

--declare
--    val_x number := &nr_ang_min;
--    v_nr_ang number;
--    v_nume varchar2(40);
--begin
--    dbms_output.put_line('yeeey!');
--    
--    select department_name, count(*) into v_nume, v_nr_ang
--    from employees join departments using (department_id)
--    group by department_name
--    having count(*) >= val_x;
--    
--    while sql%found loop
--        dbms_output.put_line('yey!');
--        
--        if v_nr_ang = 0 then
--            dbms_output.put_line('In departamentul ' || v_nume || ' nu lucreaza angajati.');
--        elsif v_nr_ang = 1 then
--            dbms_output.put_line('In departamentul ' || v_nume || ' lucreaza un angajat.');
--        else 
--            dbms_output.put_line('In departamentul ' || v_nume || ' lucreaza ' || v_nr_ang || ' angajati.');
--        end if;
--    end loop;
--end;
--/


-- Ex 12
-- id urile managerilor
select employee_id
from employees
where employee_id in (select distinct manager_id
                      from employees
                      where manager_id is not null);
                      
-- primii 3 manageri cu cei mai multi subord
select last_name, nrAng
from (select last_name, 
      (select count(*) from employees emp where emp.manager_id = e.employee_id)nrAng
      from employees e
      order by nrAng desc)
where rownum <= 3;

set serveroutput on;

declare
    cursor manager_cur is select last_name, nrAng
                          from (select last_name, 
                                (select count(*) from employees emp where emp.manager_id = e.employee_id)nrAng
                                from employees e
                                order by nrAng desc)
                          where rownum <= 3;
begin    
    for manager_rec in manager_cur loop
        dbms_output.put_line('Managerul ' || manager_rec.last_name || ' are ' || manager_rec.nrAng || ' subordonati.');
    end loop;
end;
/


-- Ex 13
declare
    cursor double_cur is select * from employees where hire_date < to_date('01-JAN-1995') and commission_pct is null
                         for update of salary nowait;
    v_nr number := 0;
begin
    for emp in double_cur loop
        update employees set salary = salary * 2 where current of double_cur;
        v_nr := v_nr + 1;
    end loop;
    
    dbms_output.put_line(v_nr);
end;
/


-- Ex 14

-- cursor explicit
declare
    v_nr number := 0;
    v_id_locatie locations.location_id%type := &loc;
    cursor loc_cur is select * from dept where location_id = v_id_locatie
                      for update of location_id nowait;
begin
    for loc in loc_cur loop
        update dept set location_id = 100 where current of loc_cur;
        v_nr := 1;
    end loop;
    
    dbms_output.put_line(v_nr);
end;
/

-- cursor parametrizat
set serveroutput on;
DECLARE 
    v_nr number := 0;
    v_param departments.location_id%type := &l_id;
     cursor cur_loc (par_loc departments.location_id%type) is
        select *
        from dept
        where location_id = par_loc
        for update of location_id nowait;
BEGIN 
    for d in cur_loc(v_param) loop
        update dept set location_id = 100 where current of cur_loc;
        v_nr := 1;
    end loop;
    
    dbms_output.put_line(v_nr);
end;

select location_id from dept;


-- Ex 15

-- cursor explicit
select department_name, location_id from dept;

declare
    v_nr number := 0;  -- pt verificare
    v_nume_nou varchar2(30);
    v_id_locatie locations.location_id%type := &loc;
    cursor nume_cur is select * from dept where location_id = v_id_locatie
                       for update of location_id, department_name nowait;
begin
    select city into v_nume_nou
    from locations
    where location_id = v_id_locatie;   -- cautare numele orasului dupa id ul locatiei introdus
    
    -- daca id ul dat nu exista, vom folosi pt concatenare valoarea introdusa
    if v_nume_nou is null then
        v_nume_nou := to_char(v_id_locatie);
    end if;  

    for dep in nume_cur loop
        update dept set location_id = 100, department_name = department_name || v_nume_nou where current of nume_cur;
        v_nr := 1;
    end loop;
    
    dbms_output.put_line(v_nr);
end;
/

-- cursor parametrizat
--Ex 15
set serveroutput on;
DECLARE 
    v_nr number := 0;  -- pt verificare
    v_param departments.location_id%type := &l_id;
    v_name dept.department_name % type;
    
    cursor cur_loc (par_loc departments.location_id%type, par_nume dept.department_name % type) is
        select *
        from dept
        where location_id = par_loc
        for update of location_id, department_name nowait;
BEGIN 
    select city into v_name
    from locations
    where location_id = v_param;   -- cautare numele orasului dupa id ul locatiei introdus
    
    -- daca id ul dat nu exista, vom folosi pt concatenare valoarea introdusa
    if v_name is null then
        v_name := to_char(v_param);
    end if;  

    for d in cur_loc(v_param,v_name) loop
        v_nr := 1;
        update dept set location_id = 100, department_name = department_name || v_name where current of cur_loc;
    end loop;
end;










