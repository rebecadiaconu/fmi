-- LABORATOR 9 + 10 - TRIGGERI

-- Ex 1
create or replace trigger upd_emp 
before insert on emp
begin
    if (to_char(sysdate, 'dy') in ('sat', 'sun')) or 
    (to_char(sysdate,'hh24:mi') not between '08:00' and '18:00') then
        raise_application_error(-20002, 'Inafara programului de lucru!');
    end if;
end;
/

--insert into emp(employee_id, last_name, email, hire_date, salary) values(1, 'aa', 'idk@yy.com', sysdate, 1000);


-- Ex 2
create or replace trigger upd_emp
before insert or update or delete on emp
begin
    if (to_char(sysdate, 'dy') in ('sat', 'sun')) or 
    (to_char(sysdate,'hh24:mi') not between '08:00' and '18:00') then
        if deleting then
            raise_application_error(-20002, 'fara stergeri!');
        elsif updating('salary') then
            raise_application_error(-20003, 'fara actualizari ale salariului');
        elsif inserting then
            raise_application_error(-20004, 'fara inserari!');
        else
            raise_application_error(-20005, 'fara actualizari!!');
        end if;
    end if;
end;
/

--update emp set hire_date = sysdate where employee_id = 101;
--delete from emp where employee_id = 101;

alter trigger upd_emp disable;

-- Ex 3
create or replace trigger trigg_ex3
before insert or update of salary on emp
for each row
begin
    if not (:new.job_id in ('AD_PRES', 'AD_VP')) and :new.salary > 15000 then
        raise_application_error(-20005, 'Nu este permis un salariu atat de mare!');
    end if;
end;
/

update emp set salary = 15500 where job_id = 'IT_PROG';
alter trigger trigg_ex3 disable;


-- Ex 4
-- var 1
create or replace trigger no_decrem_v1
before update of salary on emp
for each row
when (new.salary < old.salary)
begin
    raise_application_error(-20002, 'not allowed! 1');
end;
/

alter trigger no_decrem_v1 disable;

-- var2
create or replace trigger no_decrem_v2
before update of salary on emp
for each row
begin
    if (:new.salary < :old.salary) then
        raise_application_error(-20003, 'not allowed! 2');
    end if;
end;
/

alter trigger no_decrem_v2 disable;

-- var 3
create or replace procedure no_decrem_msg is
begin
    raise_application_error(-20006, 'not allowed 3!!');
end;
/

create or replace trigger no_decrem_v3
before update of salary on emp
for each row
when (new.salary < old.salary)
call no_decrem_msg

alter trigger no_decrem_v3 disable;

select * from emp;

update emp set salary = 2400 where employee_id = 199;


-- Ex 5
create or replace trigger upd_comision
before insert or update of salary on emp
for each row
when (new.job_id = 'SA_REP')
begin
    if inserting then
        :new.commission_pct := 0;
    elsif :old.commission_pct is null then
        :new.commission_pct := 0;
    else
        :new.commission_pct := :old.commission_pct * (:new.salary / :old.salary);
    end if;
end;
/

alter trigger upd_comision disable;

select commission_pct from emp where job_id = 'SA_REP' order by commission_pct;

update emp set salary = salary * 2 where job_id = 'SA_REP';


-- Ex 6
create or replace trigger betweenVals
before update of min_salary, max_salary on jobs
for each row
declare
    v_min emp.salary%type;
    v_max emp.salary%type;
    e_invalid exception;
begin
    select min(salary), max(salary) into v_min, v_max
    from emp
    where job_id = :new.job_id;
    
    if (v_min < :new.min_salary) or (v_max > :new.max_salary) then
        raise e_invalid;
    end if;
exception
    when e_invalid then
        raise_application_error(-20011, 'Salary out of boundries!');
end;
/

update jobs set max_salary = 2000 where job_id = 'SA_REP';

alter trigger betweenVals disable;


-- Ex 7
create or replace trigger check_sal
before insert or update of salary, job_id on emp
for each row
when(new.job_id <> 'AD_PRES')
declare
    v_min emp.salary%type;
    v_max emp.salary%type;
    not_between exception;
begin
    select min(salary), max(salary) into v_min, v_max
    from copie_emp
    where job_id = :new.job_id;
    
    if (:new.salary not between v_min and v_max) then
        raise not_between;
    end if;
exception
    when not_between then
        raise_application_error(-20023, 'salary not allowed!');
end;
/

insert into emp(employee_id, last_name, email, hire_date, salary, job_id) values(1, 'aa', 'idk@yy.com', sysdate, 1200, 'AD_PRES');
update emp set salary = 3500 where last_name = 'Stiles'; -- tabelul este mutating

create table copie_emp as select * from emp; -- vom folosi copia tabelului in interiorul trigger ului

alter trigger check_sal disable;


-- Ex 8
-- a)
alter table dept add total_sal number;
update dept set total_sal = (select sum(salary) from emp where emp.department_id = dept.department_id);

select total_sal from dept;

-- b)
create or replace procedure calculeaza_total(dept in dept.department_id%type, sal emp.salary%type) is
begin
    update dept set total_sal = total_sal + sal where department_id = dept;
end;
/

create or replace trigger upd_total_dept
after insert or delete or update of salary on emp
for each row
begin
    -- tabelul este modificat(mutating) => deci nu putem modifica direct, deci vom folosi o procedura
    if deleting then
        calculeaza_total(:old.department_id, (-1) * :old.salary);
    elsif updating('salary') then
        calculeaza_total(:new.department_id, :new.salary - :old.salary);
    else /* inserting */
        calculeaza_total(:new.department_id, :new.salary);
    end if;
end;
/

update emp set salary = 10000 where department_id = 20;

alter trigger upd_total_dept disable;


-- Ex 9
create table new_emp as select employee_id, last_name, salary, department_id, email, job_id, hire_date
from employees;

create table new_dept as select d.department_id, d.department_name, d.location_id, sum(e.salary)total_dept_sal
from departments d join employees e on (e.department_id = d.department_id)
group by d.department_id, d.department_name, d.location_id;

create view view_emp as 
select employee_id, last_name, salary, department_id, email, job_id, department_name, location_id 
from employees join departments using (department_id);

create or replace trigger upd_view
instead of insert or update or delete on view_emp
for each row
begin
    if inserting then
        insert into new_emp values(:NEW.employee_id, :NEW.last_name, :NEW.salary,
        :NEW.department_id, :NEW.email, :NEW.job_id, sysdate);
        
        update new_dept
        set total_dept_sal = total_dept_sal + :NEW.salary
        where department_id = :NEW.department_id;
        
    elsif deleting then
        delete from new_emp
        where employee_id = :OLD.employee_id;
        
        update new_dept
        set total_dept_sal = total_dept_sal - :OLD.salary
        where department_id = :OLD.department_id;
        
    elsif updating('salary') then
        update new_emp
        set salary = :NEW.salary
        where employee_id = :NEW.employee_id;
        
        update new_dept
        set total_dept_sal = total_dept_sal + (:NEW.salary - :OLD.salary)
        where department_id = :OLD.department_id;
        
     elsif updating('department_id') then
        update new_emp
        set department_id = :NEW.department_id
        where employee_id = :OLD.employee_id;
        
        update new_dept
        set total_dept_sal = total_dept_sal - :OLD.salary
        where department_id = :OLD.department_id;
        
        update new_dept
        set total_dept_sal = total_dept_sal + :NEW.salary
        where department_id = :NEW.department_id;
    end if;
end;
/

insert into view_emp values(2222, 'aaaaaac', 1500, 300, 'email', 'AD_GH', 'Freelancing', 1000);
select * from new_emp;
select * from new_dept;


-- Ex 10
create or replace package dept_date as
    type t_cod is table of dept.department_id%type
    index by binary_integer;
    
    v_cod_dep t_cod;
    
    v_NrIntrari binary_integer := 0;
end dept_date;
/

create or replace trigger limita_dept_tab
before insert on dept
for each row
begin
    dept_date.v_NrIntrari := dept_date.v_NrIntrari + 1;
    dept_date.v_cod_dep(dept_date.v_NrIntrari) := :new.department_id;
end limita_dept_tab;
/

create or replace trigger limita_dept
before insert on dept
declare
    max_emp constant number := 50;
    emp_curr number;
    cod_dept dept.department_id%type;
begin
    for v_index in 1..dept_date.v_NrIntrari loop
        cod_dept := dept_date.v_cod_dep(v_index);
        
        select count(*) into emp_curr
        from emp
        where department_id = cod_dept;
        
        if emp_curr > max_emp then
            raise_application_error(-20002, 'prea multi angajati in departamentul ' || cod_dept);
        end if;
    end loop;
    dept_date.v_NrIntrari := 0;
end;
/


-- Ex 11
create or replace trigger cascada_dept
before delete or update of department_id on dept
for each row
begin
    if deleting then
        delete from emp where department_id = :old.department_id;
    elsif updating and :old.department_id != :new.department_id then
        update emp set department_id = :new.department_id where department_id = :old.department_id;
    end if;
end;
/

select * from emp;

delete from dept where department_id = 15;
update dept set department_id = 33 where department_id = 50;


-- Ex 12 este in rezolvari


-- Ex 13
-- nu l am inteles ft bine => nu e terminat
create table ex13_trigg (
    user_id varchar2(30),
    nume_bd varchar2(50),
    eveniment_sis varchar2(20),
    nume_obj varchar2(30),
    dataa date
);


create or replace trigger ex13 
after create or drop or alter on schema
begin
    insert into info
    values(sys.login_user, sys.database_name, sys.sysevent, sys.dictionary_obj_name, sysdate);
end;
/

alter trigger ex13 disable;




