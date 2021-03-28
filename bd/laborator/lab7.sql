-- LABORATOR 7


-- Ex 1 -> 4
create table emp_rdi as select * from employees;
create table dept_rdi as select * from departments;

alter table emp_rdi
add constraint pk_emp_rdi primary key(employee_id);

alter table dept_rdi
add constraint pk_dept_rdi primary key(department_id);

alter table emp_rdi
add constraint fk_emp_dept_rdi1
foreign key(department_id) references dept_rdi(department_id);

alter table dept_rdi
add constraint kf_emp_dept_sef_rdi1
foreign key(manager_id) references emp_rdi(employee_id);

alter table emp_rdi
add constraint fk_emp_sef_rdi
foreign key(manager_id) references emp_edi(employee_id);

select * from user_constraints;


-- Ex 5
-- not good
insert into dept_rdi
values (300, 'Programare');

insert into dept_rdi (department_id, department_name)
values (300, 'Programare');
rollback;

-- not good
insert into dept_rdi (department_name, department_id)
values (300, 'Programare');
rollback;

insert into dept_rdi (department_id, department_name, location_id)
values (300, 'Programare', null);
rollback;

insert into dept_rdi (department_name, location_id)
values('Programre', null);


-- Ex 6
DESC emp_rdi;
INSERT INTO emp_rdi
VALUES (250, 'Prenume', 'Nume', 'ceva@ceva.ro', null, sysdate, 'AD_PRES', null, null, null, null);
COMMIT; --daca vrem sa se salveze


-- Ex 7
INSERT INTO emp_rdi (employee_id, last_name, email, hire_date, job_id, salary, commission_pct)  
VALUES (252, 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL); 

SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct  
FROM emp_rdi 
WHERE employee_id=252; 
ROLLBACK; 

INSERT INTO
(SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct      
FROM emp_rdi)  
VALUES (252, 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL); 
ROLLBACK;


-- cerinta
INSERT INTO
(SELECT employee_id, last_name, email, hire_date, job_id, salary, commission_pct      
FROM emp_rdi)  
VALUES ((select max(employee_id) + 1 from emp_rdi), 'Nume252', 'nume252@emp.com',SYSDATE, 'SA_REP', 5000, NULL); 
ROLLBACK;


-- Ex 8
create table emp1_rdi as select * from employees;
delete from emp1_rdi;
SELECT * FROM emp1_rdi;

insert into emp1_rdi
select *
from employees
where commission_pct > 0.25;

DROP TABLE emp1_rdi;



select e.employee_id
from employees e join employees m on (e.manager_id = m.employee_id)
where e.department_id = 100 and e.salary > 3000 and m.salary > 5500
union
select employee_id
from employees 
where department_id = 75 and manager_id is null;

-- Ex 9
-- var 1
create table emp0_rdi as select * from employees where department_id = 80;
select * from emp0_rdi;
drop table emp0_rdi;

create table emp1_rdi as select * from employees where salary < 5000;
select * from emp1_rdi;
drop table emp1_rdi;

create table emp2_rdi as select * from employees where salary between 5000 and 10000;
select * from emp2_rdi;
drop table emp2_rdi;

create table emp3_rdi as select * from employees where salary > 10000;
select * from emp3_rdi;
drop table emp3_rdi;


-- var 2 (stergem tot din tabele inainte)
INSERT FIRST -- mai exista si INSERT ALL, care insereaza oriunde se potriveste
WHEN department_id = 80 THEN INTO emp0_rdi
WHEN salary < 5000 THEN INTO emp1_rdi
WHEN salary >= 5000 and salary <= 10000 THEN INTO emp2_rdi
WHEN salary > 10000 THEN INTO emp3_rdi
SELECT * FROM employees;

-- Ex 10
update emp_rdi
set salary = 1.05 * salary;
select * from emp_rdi;
rollback;


-- Ex 11
 update dept_rdi
 set manager_id = (select employee_id from emp_rdi where lower(first_name||last_name) = 'douglasgrant')
 where department_id = 20;
 
 update emp_rdi
 set salary = salary + 1000
 where lower(first_name || last_name) = 'douglasgrant';


-- Ex 12
update emp_rdi
set (commission_pct, salary) = (select commission_pct, salary from emp_rdi e where employee_id = e.manager_id)
where salary = (select min(salary) from emp_rdi);


-- Ex 13
update emp_rdi
set (job_id, department_id) = (select job_id, department_id from emp_rdi e where e.employee_id = 205)
where employee_id = 114;


-- Ex 14
delete from dept_rdi
where department_id not in (select nvl(department_id, -1) from emp_rdi);
rollback;


-- Ex 15
-- var 1
delete from emp_rdi
where commission_pct is null and employee_id not in ((select nvl(manager_id, -1) from emp_rdi) union (select nvl(manager_id, -1) from dept_rdi));

-- var 2
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


-- Ex 16
DELETE FROM emp_rdi
WHERE employee_id = 206;
rollback;


-- Ex 17
insert into dept_rdi (department_id, department_name, location_id, manager_id)
values(305, 'Fashion designer', 207, 112);


-- Ex 18
savepoint p;


-- Ex 19
select * from dept_rdi;
select distinct department_id from emp_rdi;

delete from dept_rdi
where department_id in (select department_id 
                        from dept_rdi
                        minus
                        select department_id
                        from emp_rdi);
                        
                        
-- Ex 20
rollback to p;


-- Ex 22
MERGE INTO emp_pnu x
USING employees e
ON (x.employee_id = e.employee_id)
WHEN MATCHED THEN
UPDATE SET
x.first_name = e. first_name,
x.last_name = e.last_name,
x.email = e.email,
x.phone_number = e.phone_number,
x.hire_date = e.hire_date,
x.job_id = e.job_id,
x.salary = e.salary,
x.commission_pct = e.commission_pct,
x.manager_id = e.manager_id,
x.department_id = e.department_id
WHEN NOT MATCHED THEN
INSERT VALUES (e.employee_id, e.first_name, e.last_name, e.email,
e.phone_number, e.hire_date, e.job_id, e.salary, e.commission_pct, e.manager_id,
e.department_id);