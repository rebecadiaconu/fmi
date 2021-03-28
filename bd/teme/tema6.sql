-- TEMA 6, DIACONU REBECA-MIHAELA, Grupa 233

-- LABORATOR 5

-- Ex 15
select last_name "Nume", first_name "Prenume", employee_id "ID angajat", manager_id "ID manager", salary "Salariu"
from employees
start with employee_id = (select employee_id
                         from employees
                         where to_number(employee_id) = 114)
connect by manager_id = prior employee_id;


-- Ex 21
select last_name || first_name "Nume si prenume", salary
from (select * from employees order by salary desc)
where rownum <= 10;


-- Ex 23
select 'Departamentul ' || d.department_name || ' este condus de ' || 
case when d.manager_id is null then 'nimeni'
     else to_char(d.manager_id)
     end
||
case when (select count(*) from employees
           where department_id = d.department_id) = 0 then ' si nu are angajati'
     else ' si are ' || to_char((select count(*) from employees where department_id = d.department_id)) || ' angajati.'
     end "Exercitiul 23"
from departments d;


-- Ex 24
select last_name "Nume", first_name "Prenume", length(last_name) "Lungime nume", length(first_name) "Lungime prenume"
from employees
where nullif(length(last_name), length(first_name)) is not null;


-- Ex 25
select last_name "Nume", first_name "Prenume", hire_date "Data angajarii", salary "Salariu",
case when to_char(hire_date, 'YYYY') like '1989' then 1.2 * salary
     when to_char(hire_date, 'YYYY') like '1990' then 1.15 * salary
     when to_char(hire_date, 'YYYY') like '1991' then 1.1 * salary
     else salary
     end "Salariu dupa marire"
from employees
order by hire_date;


-- Ex 26
select job_id "ID JOB",
case when upper(job_id) like 'S%' then sum(salary)
     when job_id in (select job_id 
                       from employees
                       where salary = (select max(salary)
                                       from employees)) then avg(salary)
     else min(salary)
     end "Rezolvare ex 26"
from employees 
group by job_id
order by job_id;

-- nu cred ca se poate folosi DECODE din cauza ca el ar verifica daca exp = val1 si in cazul nostru 
-- nu avem o valoare constanta cu care sa comparam valoarea rezultata in urma expresiei
                     