-- TEMA 2

-- LABORATOR 2

-- Ex 20

select last_name, department_name
from employees e join departments d using (department_id)
where upper(last_name) like '%A%';

-- Ex 23

select ang.employee_id "#Ang" , ang.last_name "Angajat",  mgr.manager_id "#Mgr", mgr.last_name "Manager"
from employees ang, employees mgr 
where ang.manager_id = mgr.employee_id (+);

-- Ex 25
/*
S? se listeze structura tabelului JOBS. Crea?i o cerere prin care s? se afi?eze numele,     !! aici prin nume am inteles numele 
codul job-ului, titlul job-ului, numele departamentului ?i salariul angaja?ilor.               angajatului
*/

select * from jobs;

select last_name, job_id, job_title, department_name, salary
from employees e join departments d using (department_id)
                 join jobs j using (job_id);
                 
-- Ex 26

select e.last_name "Nume", e.hire_date "Data angajare", gates.hire_date "Data angajare Gates"
from employees e, employees gates
where initcap(gates.last_name) like 'Gates' and gates.hire_date < e.hire_date;

-- Ex 27

select ang.last_name "Angajat", ang.hire_date "Data_ang", mgr.last_name "Manager", mgr.hire_date "Data_mgr"
from employees ang join employees mgr on(ang.manager_id = mgr.employee_id)
where mgr.hire_date > ang.hire_date;

-- LABORATOR 3

-- Ex 2
/* 
S? se afi?eze codul ?i numele angaja?ilor care lucreaz? în acelasi departament cu
cel pu?in un angajat al c?rui nume con?ine litera “t”. Se vor afi?a, de asemenea, codul ?i
numele departamentului respectiv. Rezultatul va fi ordonat alfabetic dup? nume. Se vor
da 2 solu?ii pentru join (condi?ie în clauza WHERE ?i sintaxa introdus? de standardul
SQL3).
*/

-- Varianta cu WHERE
select ang.employee_id, ang.last_name, ang.department_id, dep.department_name
from employees ang, departments dep
where ang.department_id = dep.department_id and dep.department_id in ( select distinct department_id
                                                                     from employees
                                                                     where lower(last_name) like '%t%' and employee_id != ang.employee_id)
order by ang.last_name;

-- Varianta SQL3
select ang.employee_id, ang.last_name, ang.department_id, dep.department_name
from employees ang join departments dep on (ang.department_id = dep.department_id)
                 where dep.department_id in ( select distinct department_id
                                            from employees
                                            where lower(last_name) like '%t%')
order by ang.last_name;

-- Ex 3

select ang.last_name, ang.salary, j.job_title, l.city, c.country_name
from employees ang join employees mgr on (ang.manager_id = mgr.employee_id and initcap(mgr.last_name) = 'King')
                   join jobs j on (ang.job_id = j.job_id)
                   join departments d on (ang.department_id = d.department_id)
                   join locations l on (d.location_id = l.location_id)
                   join countries c on (l.country_id = c.country_id);
                   
-- Ex 4

select department_id, d.department_name, e.last_name, e.job_id, to_char(e.salary, '$99,999.00') "Salary"
from employees e join departments d using (department_id)
where lower(d.department_name) like '%ti%'
order by d.department_name, e.last_name;

-- Ex 5
/*
Sa se afiseze numele angajatilor, numarul departamentului, numele departamentului,
ora?ul si job-ul tuturor salariatilor al caror departament este localizat in Oxford.
*/
select e.last_name, e.department_id, d.department_name, l.city, e.job_id
from employees e join departments d on (e.department_id = d.department_id)
                 join locations l on (d.location_id = l.location_id and initcap(l.city) = 'Oxford');

