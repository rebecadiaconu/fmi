-- TEMA 5, DIACONU REBECA-MIHAELA, Grupa 233

-- Exercitiul 29 (Laborator 4)
select department_id "ID Departament", department_name "Nume departament", 
(select count(*) from employees e where e.department_id = department_id) "Numar angajati",
(select round(avg(salary)) from departments d where d.department_id = department_id) "Salariul mediu",
last_name "Nume", salary "Salariu", job_id "Job"
from employees right outer join departments using (department_id);
                
               

-- Exercitiul 31 (Laborator 4)
select last_name "Nume", salary "Salariu",  department_id "Id departament", round(dep.salMediu) "Salariu mediu"
from employees join (select department_id, avg(salary)salMediu
                         from employees
                         group by department_id)dep using (department_id);



-- Exercitiul 32 (Laborator 4)
select last_name "Nume", salary "Salariu",  department_id "Id departament", round(dep.salMediu) "Salariu mediu", dep.nrAngajati "Numar angajati"
from employees join (select department_id, avg(salary)salMediu, count(*)nrAngajati
                         from employees
                         group by department_id)dep using (department_id);
                         
-- Exercitiul 34 (Laborator 4)

select department_id "ID Departament", department_name "Nume departament", dep.nrAngajati "Numar angajati",
dep.salMediu "Salariu mediu",
last_name "Nume", salary "Salariu", job_id "Job"
from employees join (select department_id, round(avg(salary))salMediu, count(*)nrAngajati
                    from employees
                    group by department_id)dep using (department_id)
               right outer join departments using (department_id);


-- Exercitiul 8 (Laborator 5)
select e.last_name "Nume", e.first_name "Prenume", e.hire_date "Data angajare", d.department_name "Nume departament"
from employees e join departments d on (e.department_id = d.department_id)
where e.hire_date = (select min(hire_date)
                  from employees
                  group by department_id
                  having department_id = e.department_id)
order by d.department_name;

