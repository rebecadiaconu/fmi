-- LABORATOR 6 CURSOARE (LAB3 DAT DE EA)

-- Ex 1
set serveroutput on;

declare
    val_sal emp.salary%type := &salariu;
begin
    update emp set commission_pct = nvl(commission_pct, 0) + 0.1
    where salary < val_sal;
    
    if sql%found then
        dbms_output.put_line('Nr linii actualizate: ' || sql%rowcount);
    else
        dbms_output.put_line('Nicio linie actualizata!');
    end if;
end;
/


-- Ex 2
create table dep_emp_rdi (
    cod_dep number(6),
    cod_ang number(6)
);

declare
    type dep_tab is table of number;
    v_dep dep_tab;
    i number;
begin
    select distinct department_id bulk collect into v_dep
    from emp
    where department_id is not null;
    
    forall i in 1..v_dep.count
        insert into dep_emp_rdi
            select department_id, employee_id
            from emp
            where department_id = v_dep(i);
    for i in 1..v_dep.count loop    
        dbms_output.put_line('S-au introdus ' || sql%bulk_rowcount(i) || ' linii pentru departamentul ' || v_dep(i));
    end loop;
end;
/


-- Ex 3
set serveroutput on;

-- loop
declare
    cursor c_emp is select last_name, first_name, 12 * salary * (1 + nvl(commission_pct, 0)) from employees where department_id = 50 order by last_name;
    v_nume employees.last_name%type;
    v_prenume employees.first_name%type;
    v_sal employees.salary%type;
begin
    open c_emp;
    loop
        fetch c_emp into v_nume, v_prenume, v_sal;
        exit when c_emp%notfound;
        dbms_output.put_line('Salariatul ' || v_nume || ' ' || v_prenume || ' castiga ' || v_sal || ' .');
    end loop;
    close c_emp;
end;
/

-- while
set serveroutput on;

declare
    cursor c_emp is select last_name, first_name, (12 * salary * (1 + nvl(commission_pct, 0)))salAnual from employees where department_id = 50 order by last_name;
    v_nume employees.last_name%type;
    v_prenume employees.first_name%type;
    v_sal employees.salary%type;
begin
    open c_emp;
    fetch c_emp into v_nume, v_prenume, v_sal;
    while c_emp%found loop
        dbms_output.put_line('Salariatul ' || v_nume || ' ' || v_prenume || ' castiga ' || v_sal || ' .');
        fetch c_emp into v_nume, v_prenume, v_sal;
    end loop;
    close c_emp;
end;
/

-- for
declare
    cursor c_emp is select last_name, first_name, (12 * salary * (1 + nvl(commission_pct, 0)))salAnual from employees where department_id = 50 order by last_name;
begin
    for v_emp in c_emp loop
        dbms_output.put_line('Salariatul ' || v_emp.last_name || ' ' || v_emp.first_name || ' castiga ' || v_emp.salAnual || ' .');
    end loop;
end;
/

-- for subcerere
begin
    for v_emp in (select last_name, first_name, (12 * salary * (1 + nvl(commission_pct, 0)))salAnual from employees where department_id = 50 order by last_name) loop
        dbms_output.put_line('Salariatul ' || v_emp.last_name || ' ' || v_emp.first_name || ' castiga ' || v_emp.salAnual || ' .');
    end loop;
end;
/


-- Ex 4
declare
    cursor c_emp is select last_name, salary from employees where salary < 7000;
begin
    for emp in c_emp loop
        dbms_output.put_line('Salariatul ' || emp.last_name || ' castiga ' || emp.salary);
    end loop;
end;
/


-- Ex 5
create table top_salarii (
    salary number(10, 2)
);

accept p_num prompt 'nr angajati ? ';

declare
    v_num number := &p_num;
    v_sal employees.salary%type;
    cursor c_emp is select salary from (select salary from employees order by salary desc) where rownum <= v_num;
begin
    for sal in c_emp loop
        insert into top_salarii values sal;
    end loop;
end;
/

select * from top_salarii;


-- Ex 6

-- var1
declare
    p_cod employees.employee_id%type := &p_cod;
    cursor c_emp(p_id employees.employee_id%type) is 
        select last_name, salary 
        from employees 
        where p_id is null or employee_id = p_id;
    v_nume c_emp%rowtype;
begin
    open c_emp(p_cod);
    loop
        fetch c_emp into v_nume;
        exit when c_emp%notfound;
        dbms_output.put_line(v_nume.last_name || ' ' || v_nume.salary);
    end loop;
    close c_emp;
end;
/

-- var2
declare
    cursor c_emp(p_id employees.employee_id%type) is 
        select last_name, salary 
        from employees 
        where p_id is null or employee_id = p_id;
    type v_tab_nume is table of employees.last_name%type;
    type v_tab_sal is table of employees.salary%type;

    p_cod employees.employee_id%type := &p_cod;
    v_nume v_tab_nume;
    v_sal v_tab_sal;
begin
    open c_emp(p_cod);
    fetch c_emp bulk collect into v_nume, v_sal;
    close c_emp;
    
    for i in v_nume.first..v_nume.last loop
        dbms_output.put_line(v_nume(i) || ' ' || v_sal(i));
    end loop;
end;
/


-- Ex 7
create table mesaje (
    text varchar2(100)
);

declare
    cursor c_text(dept employees.department_id%type, jobb employees.job_id%type) is
        select to_char(employee_id) || ' ' || to_char(department_id) || ' ' || to_char(job_id)
        from employees
        where (dept is null or department_id = dept) and (jobb is null or job_id = jobb);
begin
    for c_emp in c_text(null, null) loop
        insert into mesaje values c_emp;
    end loop;
end;
/

select * from mesaje;

drop table mesaje;


-- Ex 8
set serveroutput on;

declare
    cursor c_emp is
        select last_name, salary, hire_date, employee_id
        from employees
        where hire_date < to_date('01-JAN-1995')
        for update of salary nowait;
begin
    for x in c_emp loop
        update employees set salary = salary * 2
        where current of c_emp;
        
        dbms_output.put_line(x.employee_id || ' ' || x.last_name || ' ' || x.salary || ' ' || x.hire_date);
    end loop;
end;
/

rollback;


-- Ex 9
declare
    cursor c_emp(loc_id locations.location_id%type) is
        select department_id
        from dept
        where location_id = loc_id
        for update nowait;
        
    cod_locatie locations.location_id%type := &cod_loc;
begin
    dbms_output.put_line('Departamentele actualizate: ');
    for x in c_emp(cod_locatie) loop
        update dept set location_id = 100
        where current of c_emp;
        dbms_output.put_line(x.department_id);
    end loop;
end;
/

set serveroutput on;

select location_id, department_name from dept;
rollback;

-- Ex 10
declare
    cursor c_emp(loc_id locations.location_id%type) is
        select department_id
        from dept
        where location_id = loc_id
        for update nowait;
        
    cod_locatie locations.location_id%type := &cod_loc;
begin
    dbms_output.put_line('Departamentele actualizate: ');
    for x in c_emp(cod_locatie) loop
        update dept set department_name = department_name || to_char(location_id)
        where current of c_emp;
        dbms_output.put_line(x.department_id);
    end loop;
end;
/


-- Ex 11
set serveroutput on;

declare
    type c_emp is ref cursor return emp%rowtype;
    var1 c_emp;
    v_emp var1%rowtype;
    v_opt number(1) := &optiune;
begin
    if v_opt = 1 then
        open var1 for select * from emp;
    elsif v_opt = 2 then
        open var1 for select * from emp where salary between 1000 and 2000;
    else
        open var1 for select * from emp where to_char(hire_date, 'YYYY') = '1990';
        -- sau where extract(year from hire_date) = 1990
        
    end if;
    fetch var1 into v_emp;    
    loop
        exit when var1%notfound;
        dbms_output.put_line(v_emp.employee_id || ' ' || v_emp.salary || ' ' || v_emp.hire_date);
        fetch var1 into v_emp;
    end loop;
    close var1;
end;
/


-- Ex 12
set serveroutput on;

declare
    type c_emp is ref cursor return emp%rowtype;
    v_cursor c_emp;
    emp_c v_cursor%rowtype;
    n number := &nr;
begin
    open v_cursor for select * from emp where salary > n;
    fetch v_cursor into emp_c;
    loop
        exit when v_cursor%notfound;
        if emp_c.commission_pct is not null then
            dbms_output.put_line(emp_c.last_name || ' ' || emp_c.salary || ' ' || emp_c.commission_pct);
        end if;
        fetch v_cursor into emp_c;
    end loop;
    close v_cursor;
end;
/

-- cu sir dinamic
declare
    type c_emp is ref cursor;
    v_cursor c_emp;
    emp_c emp%rowtype;
    n number := &nr;
begin
    open v_cursor for
        'select * from emp where salary > :bind_var' using n;
    fetch v_cursor into emp_c;
    loop
        exit when v_cursor%notfound;
        if emp_c.commission_pct is not null then
            dbms_output.put_line(emp_c.last_name || ' ' || emp_c.salary || ' ' || emp_c.commission_pct);
        end if;
        fetch v_cursor into emp_c;
    end loop;
    close v_cursor;
end;
/


-- Ex 13
-- secvential
begin
    for x in (select region_name, country_name from regions join countries using(region_id)) loop
        dbms_output.put_line(x.region_name || ' ' || x.country_name);
    end loop;
end;
/

-- expresii cursor
declare
    cursor c_reg is 
        select r.region_name, cursor (select country_name
                                      from countries c
                                      where c.region_id = r.region_id) as country
        from regions r;
    v_regiuni regions.region_name%type;
    v_country sys_refcursor;
    type v_country_name is table of countries.country_name%type
    index by binary_integer;
    
    v_tara v_country_name;
begin
    open c_reg;
    loop
        fetch c_reg into v_regiuni, v_country;
        exit when c_reg%notfound;
        fetch v_country bulk collect into v_tara;
        
        dbms_output.put_line('In ' || v_regiuni || ' avem tarile: ');
        for ind in v_tara.first..v_tara.last loop
            dbms_output.put(v_tara(ind) || ' ');
        end loop;
        dbms_output.new_line();
        dbms_output.new_line();
    end loop;
    close c_reg;
end;
/


-- cursor dinamic
declare
    type refcursor is ref cursor;
    cursor c_locations is
        select region_name, cursor(select country_name from countries c where c.region_id = r.region_id)
        from regions r;
    v_region regions.region_name%type;
    v_country countries.country_name%type;
    v_cursor refcursor;
begin
    open c_locations;
    loop
        fetch c_locations into v_region, v_cursor;
        exit when c_locations%notfound;
        dbms_output.put_line('------------');
        dbms_output.put_line(v_region);
        dbms_output.put_line('------------');
        loop
            fetch v_cursor into v_country;
            exit when v_cursor%notfound;
            dbms_output.put_line(v_country);
        end loop;
    end loop;
    close c_locations;
end;
/



--  EXERCITII PROPUSE
set serveroutput on;

--  Ex 1
declare
    cursor dep_med is
        select department_id, round(avg(salary), 2)medSal 
        from employees 
        group by department_id 
        having department_id is not null 
        order by department_id;
begin
    for emp in dep_med loop
        dbms_output.put_line('In departamentul ' || emp.department_id || ' media salariilor este ' || emp.medSal);
    end loop;
end;
/


-- Ex 2
declare
    cursor emp is
        select last_name, first_name, employee_id
        from (select last_name, first_name, employee_id from employees order by last_name)
        where rownum <= 5;
begin
    for v_emp in emp loop
        dbms_output.put_line(v_emp.last_name || ' ' || v_emp.first_name || ' ' || v_emp.employee_id);
    end loop;
end;
/


-- Ex 3
declare
    n number := &nr;
    cursor bestSal is
        select last_name, salary
        from employees
        where salary in (select salary
                         from (select distinct salary from employees order by salary desc)
                         where rownum <= n);
begin
    for v_emp in bestSal loop
        dbms_output.put_line(v_emp.last_name || ' ' || v_emp.salary);
    end loop;
end;
/


-- Ex 4
declare
    text varchar2(100);
    cursor emp_job is
        select distinct job_id
        from employees;
    cursor v_emp (c employees.job_id%type) is
        select last_name, job_id
        from employees
        where job_id = c;
begin
    for j in emp_job loop
        for e in v_emp(j.job_id) loop
            text := 'Salariatul ' || e.last_name || ' are jobul ' || e.job_id;
            insert into mesaje values(text);
        end loop;
    end loop;
end;
/

select * from mesaje;
rollback;


-- Ex 5
set serveroutput on;

declare
    cursor findJob is
        select department_id, department_name
        from departments
        where department_id < 100;
    cursor findEmp (dep employees.department_id%type) is
        select employee_id, last_name, job_id, hire_date, salary
        from employees
        where employee_id < 120 and department_id = dep;
begin
    for j in findJob loop   
        for d in findEmp(j.department_id) loop
            dbms_output.put_line(d.employee_id || ' ' || d.last_name || ' ' || d.job_id || ' ' || d.hire_date || ' ' || d.salary || ' ' || j.department_id || ' ' || j.department_name);
        end loop;
    end loop;
end;
/

select * from employees;


-- Ex 6
set serveroutput on;

accept p_dep prompt 'cod departament = ?';
declare
    cod_dep employees.department_id%type := &p_dep;
    cursor emp_cursor (dep employees.department_id%type) is
        select last_name, salary, manager_id
        from employees
        where department_id = dep;
begin
    for emp in emp_cursor(cod_dep) loop
        if emp.salary < 5000 and emp.manager_id in (101, 124) then
            dbms_output.put_line(emp.last_name || ' va fi propus pentru marire.');
        else
            dbms_output.put_line(emp.last_name || ' nu va fi propus pentru marire.');
        end if;
    end loop;
end;
/

select salary, department_id
from employees
where manager_id in (101, 124);


-- Ex 7
set serveroutput on;

declare
    cod_dep employees.department_id%type := &c_dep;
    comision employees.commission_pct%type;
    
    cursor c_emp (dep employees.department_id%type) is
        select last_name, first_name, salary
        from employees
        where department_id = dep
        for update nowait;
begin
    if cod_dep in (20, 60, 60, 100) then
        for emp in c_emp(cod_dep) loop
            case
            when emp.salary < 6500 then comision := 0.2;
            when emp.salary < 9500 then comision := 0.15;
            when emp.salary < 12000 then comision := 0.08;
            else comision := 0.03;
            end case;
            
            update employees set salary = (1 + comision) * salary
            where current of c_emp;
            
            dbms_output.put_line('Linii actualizate: ' || c_emp%rowcount);
        end loop;
    else
        dbms_output.put_line('Angajatii din departamentul respectiv nu sunt propusi pentru marire!');
    end if;
exception
    when no_data_found then raise_application_error(-20202, 'Nu exista acest departament!');
end;
/




