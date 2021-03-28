-- Laborator 3 COMPLET

-- Ex 1

set serveroutput on;

declare
    v_oras locations.city%type;
begin
    select city into v_oras
    from locations join departments using (location_id)
    where department_id = 30;
    
    dbms_output.put_line(v_oras);
end;
/


-- Ex 2
declare
    v_media_sal employees.salary%type := 0;
    v_dept number(4) := 50;
begin
    select avg(salary) into v_media_sal
    from employees
    where department_id = v_dept;
    
    if v_media_sal > 0 then
        dbms_output.put_line('Media salariilor din departamentul ' || v_dept || ' este ' || v_media_sal);
    else
        dbms_output.put_line('Nu este niciun angajat in departamentul ' || v_dept);
    end if;
end;
/


-- Ex 3
declare
    v_dept_id employees.department_id%type := &dept_id;
    v_nr_ang number(4) := 0;
    v_text varchar2(20);
begin
    select count(*) into v_nr_ang
    from employees
    where department_id = v_dept_id;
    
    if v_nr_ang < 10 then
        v_text := 'mic';
    elsif v_nr_ang <= 30 then
        v_text := 'mediu';
    else
        v_text := 'mare';
    end if;
    
    dbms_output.put_line('Departamentul ' || v_dept_id || ' a fost catalogat ca fiind ' || v_text || ' (' || v_nr_ang || ' angajat/i).');  
end;
/


-- Ex 4
declare
    v_castig_total employees.salary%type := 0;
    v_salariu_lunar employees.salary%type := &salariu_lunar;
    v_procent number(4) := &procent;
begin
    v_salariu_lunar := nvl(v_salariu_lunar, 0);
    v_castig_total := ((1 + v_procent / 100) * v_salariu_lunar) * 12;
    dbms_output.put_line('Pentru salariul ' || v_salariu_lunar || ' si comisionul ' || v_procent/100 || ' avem castigul pe un an egal cu ' || v_castig_total);
end;
/


-- Ex 5
declare
    v_dept departments.department_id%type := &dept_id;
    p_com number := &procent;
begin
    p_com := p_com / 100;
    update employees 
    set commission_pct = p_com
    where department_id = v_dept and commission_pct is null;
    if sql%rowcount > 0 then
        dbms_output.put_line('Numar linii actualizate: ' || SQL%rowcount);
    else
        dbms_output.put_line('Nicio linie actualizata.');
    end if;
end;
/

rollback;


-- Ex 6
set serveroutput on;

declare
    v_zi varchar2(2) := '&zi';
    v_text varchar2(100);
begin
    case upper(v_zi)
        when 'L' then v_text := 'Luni';
        when 'M' then v_text := 'Marti' ;
        when 'MI' then v_text := 'Miercuri';
        when 'J' then v_text := 'Joi';
        when 'V' then v_text := 'Vineri';
        when 'S' then v_text := 'Sambata';
        when 'D' then v_text := 'Duminica';
        else v_text := 'Nu ati introdus o abreviere corespunzatoare unei zile din saptamana.';
    end case;
    
    dbms_output.put_line(v_text);
end;
/


-- Ex 7
begin
    update employees set commission_pct = 0.1
    where commission_pct is null and manager_id is null and employee_id in (select distinct manager_id from employees);
    dbms_output.put_line(sql%rowcount);
end;
/

-- verificare
select commission_pct, employee_id, manager_id
from employees
where employee_id in (select distinct manager_id from employees);


-- Ex 8(1)
declare
    v_cod_emp employees.employee_id%type := &cod_angajat;
    v_comision employees.commission_pct%type;
    v_salariu employees.salary%type;
begin
    select salary into v_salariu
    from employees
    where employee_id = v_cod_emp;
    
    if v_salariu < 1000 then
        v_comision := 0.1;
    elsif v_salariu <= 1500 then
        v_comision := 0.15;
    elsif v_salariu > 1500 then
        v_comision := 0.2;
    else
        v_comision := 0;
    end if;
    
    update emp set commission_pct = v_comision
    where employee_id = v_cod_emp;
    
    dbms_output.put_line(sql%rowcount);
end;
/


-- Ex 8(2) + 9
declare
    v_cod_maxim departments.department_id%type;
    v_nume_dept departments.department_name%type := '&nume_dept';
begin
    select max(department_id) into v_cod_maxim
    from dept;
    dbms_output.put_line(v_cod_maxim);
    
    insert into dept (department_name, department_id, location_id) values (v_nume_dept, v_cod_maxim + 10, null);
end;
/

-- verificare
select * from dept order by department_id desc;


-- Ex 10
declare
    v_cod_dept departments.department_id%type := &cod_dept;
    v_locatie_noua locations.city%type := '&locatie_noua';
    v_cod_locatie locations.location_id%type;
begin
    select location_id into v_cod_locatie
    from locations
    where upper(city) = upper(v_locatie_noua);
    
    update dept set location_id = v_cod_locatie where department_id = v_cod_dept;
    
end;
/

select * from dept;
select * from locations;


-- Ex 11
declare
    v_cod_dept departments.department_id%type := &cod;
begin
    delete from dept where department_id = v_cod_dept;
    dbms_output.put_line(sql%rowcount);
end;
/


-- Ex 12
set serveroutput on;

declare
    v_impozit number;
    v_sal_max jobs.max_salary%type;
    v_sal_min jobs.min_salary%type;
    v_salariu employees.salary%type;
    v_nume employees.last_name%type;
    v_job employees.job_id%type;
    v_cod_emp employees.employee_id%type := '&emp_id';
begin
    select salary, last_name, job_id into v_salariu, v_nume, v_job
    from employees
    where employee_id = v_cod_emp;
    
    select min_salary, max_salary into v_sal_min, v_sal_max
    from jobs
    where job_id = v_job;
    
    if v_salariu = v_sal_min then
        v_impozit := v_salariu * 0.1;
    elsif v_salariu = v_sal_max then
        v_impozit := v_salariu * 0.3;
    else
        v_impozit := v_salariu * 0.2;
    end if;
    
    dbms_output.put_line('Angajatul ' || v_nume || ' are impozitul ' || v_impozit || '.');
end;
/






