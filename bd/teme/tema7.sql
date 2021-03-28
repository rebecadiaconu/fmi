-- TEMA 7, DIACONU REBECA-MIHAELA, Grupa 233

-- LABORATOR 6

-- Ex 1

-- modelul 1 (2 x NOT EXIST)
select distinct employee_id "ID Angajat"
from works_on a
where not exists (select 1 
                  from projects p 
                  where start_date >= to_date('01-JAN-2006') AND
                          start_date <= to_date('30-JUN-2006')
                  and not exists (select 1
                                  from works_on b
                                  where p.project_id = b.project_id and b.employee_id = a.employee_id));
                  
-- modelul 3 (operatorul MINUS)
select employee_id
from works_on
minus
select employee_id from (select employee_id, project_id
                         from (select employee_id from works_on)t1,
                              (select project_id from projects where start_date >= to_date('01-JAN-2006') AND
                                                                     start_date <= to_date('30-JUN-2006'))t2
                         minus 
                         select employee_id, project_id from works_on)t3;
                         
-- modelul 4(A include B => B\A = multVida)
select distinct employee_id
from works_on a
where not exists (
                 (select project_id
                  from projects p
                  where start_date >= to_date('01-JAN-2006') AND
                        start_date <= to_date('30-JUN-2006'))
                  minus
                  (select project_id
                   from works_on b
                   where project_id = b.project_id and b.employee_id = a.employee_id));
          
          
-- Ex 5  
select distinct employee_id
from works_on x
where not exists ((select project_id
                  from works_on
                  where x.employee_id = employee_id)
                  minus
                  (select project_id
                  from projects
                  where project_manager = 102));
                  

-- Ex 8
-- la mine a mers cu data in formatul '07-DEC-99'
accept dataAng prompt "Data angajare: ";
select department_name, department_id, hire_date,
case when commission_pct is not null then (1 + commission_pct)*salary*12 
     else salary
     end "Salariul anual"                                
from employees join departments using (department_id)
where hire_date >= &dataAng
order by hire_date;


-- Ex 10
accept locationName prompt "Locatia este: ";
select last_name "Nume", job_id "Job", salary "Salariu", d.department_name "Nume departament", city "Oras"
from employees join departments d using (department_id),
     departments join locations using (location_id)
where lower(&locationName) = lower(city);


-- LABORATOR 7

create table emp_rdi as select * from employees;
create table dept_rdi as select * from departments;

alter table emp_rdi
add constraint pk_emp_rdi primary key(employee_id);

alter table dept_rdi
add constraint pl_dept_rdi primary key(department_id);

alter table emp_rdi
add constraint fk_emp_dept_rdi1     
foreign key(department_id) references dept_rdi(department_id); 

alter table dept_rdi
add constraint fk_emp_dept_sef_rdi1     
foreign key(manager_id) references emp_rdi(employee_id); 

alter table emp_rdi
add constraint fk_emp_sef_rdi  
foreign key(manager_id) references emp_rdi(employee_id); 

select * from user_constraints;

-- Ex 13
update emp_rdi
set (department_id, job_id) = (select department_id, job_id from emp_rdi where employee_id = 205)
where employee_id = 114;
rollback;

-- Ex 15
delete from emp_rdi e
where commission_pct is null 
      and
      not exists(select employee_id
                 from emp_rdi r
                 where r.manager_id = e.employee_id)
      and
      not exists(select manager_id
                from dept_rdi d
                where d.manager_id = e.employee_id);
rollback;
