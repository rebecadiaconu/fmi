-- LABORATOR 4

-- Ex 2
select max(salary) "Maxim", min(salary) "Minim", sum(salary) "Suma", round(avg(salary), 2) "Media"
from employees;


-- Ex 3
select job_id, min(salary), max(salary), sum(salary), avg(salary)
from employees
group by job_id
order by job_id;


-- Ex 4
select count(employee_id), job_id
from employees
group by job_id;


-- Ex 5
select count(distinct manager_id) "Nr manageri"
from employees;


-- Ex 6
select max(salary) - min(salary) "Diferenta"
from employees;


-- Ex 7
select department_name "Nume departament", location_id "Locatie", count(employee_id) "Nr. angajati", round(avg(salary), 2) "Salariul mediu"
from employees join departments using (department_id)
group by department_name, location_id;


-- Ex 8
select employee_id, last_name || ' ' || first_name, salary
from employees
where salary > (select avg(salary)
                from employees)
order by salary desc;


-- Ex 9
select manager_id, min(salary)
from employees
where manager_id is not null
group by manager_id
having min(salary) > 1000
order by 2 desc;


-- Ex 10
select department_id, department_name, max(salary)
from employees join departments using(department_id)
group by department_id, department_name
having avg(salary) > 3000;


-- Ex 11
-- salariile medii per job
select avg(salary), job_id
from employees
group by job_id
order by 1;

-- sal mediu minim
select min(avg(salary))
from employees
group by job_id;


-- Ex 12
select department_id, department_name, sum(salary)
from employees join departments using (department_id)
group by department_id, department_name;


-- Ex 13
select round(max(avg(salary)), 2)
from employees
group by department_id;


-- Ex 14
select job_id, job_title, avg(salary)
from employees join jobs using (job_id)
group by job_id, job_title
having avg(salary) = (select min(avg(salary))
                     from employees
                     group by job_id);
                     
                     
-- Ex 15
select round(avg(salary), 2)
from employees
having avg(salary) > 2500;


-- Ex 16
select department_id, job_id, sum(salary)
from employees
group by department_id, job_id
order by department_id, job_id;


-- Ex 17
-- salariul maxim
select max(salary)
from employees; 

-- departamenul cu cel mai mare salariu
select distinct department_id, salary
from employees
where salary = (select max(salary)
                from employees);
                
-- cerinta
select department_name, department_id, min(salary)
from employees join departments using (department_id)
group by department_id, department_name
having department_id = (select distinct department_id
                        from employees
                        where salary = (select max(salary)
                                        from employees));
                                        
                                        
-- Ex 18
-- a)
select department_id, department_name, count(employee_id)
from employees join departments using (department_id)
group by department_id, department_name
having count(employee_id) < 4
order by 3;

-- mergea la fel de bine si cu count(*)

-- b)
-- numarul maxim de angajati din toate departamentele
select max(count(*))
from employees
group by department_id;

-- departamentul cu nr max de ang
select department_id
from employees
group by department_id
having count(*) in (select max(count(*))
                    from employees
                    group by department_id);
                    
-- cerinta
select department_id, department_name, count(*)
from employees join departments using (department_id)
group by department_id, department_name
having count(*) in (select max(count(*))
                    from employees
                    group by department_id);


-- Ex 19
-- ziua in care cei mai multi salariati au fost angajati
select to_char(hire_date, 'DD'), count(*)
from employees
group by to_char(hire_date, 'DD')
having count(*) in (select max(count(*))
                    from employees
                    group by to_char(hire_date, 'DD'));
                    
-- cerinta
select last_name || ' ' || first_name
from employees
where to_char(hire_date, 'DD') in (select to_char(hire_date, 'DD')
                                    from employees
                                    group by to_char(hire_date, 'DD')
                                    having count(*) in (select max(count(*))
                                                        from employees
                                                        group by to_char(hire_date, 'DD')))
order by 1;


-- Ex 20
-- departamentele care au cel putin 15 angajati
select count(*) "Numar angajati"
from employees
group by department_id
having count(*) > 15;

-- cerinta
select count(count(*)) "Nr departamente"
from employees
group by department_id
having count(*) > 15;


-- Ex 21
select department_id, sum(salary) "Total salarii"
from employees
group by department_id
having count(*) > 10 and department_id != 30
order by 2;


-- Ex 22
select department_id, department_name, count(*) "Nr ang", round(avg(clg.salary), 2) "Sal mediu",
ang.last_name "Nume", ang.salary "Salariu angajat", ang.job_id "Job angajat"
from employees ang join employees clg using (department_id)
                   right outer join departments using (department_id)
group by department_id, department_name, ang.last_name, ang.salary, ang.job_id
order by 1;


-- Ex 23
select city "Oras", department_name "Nume departament", job_id "Job", sum(salary) "Total salariu"
from employees join departments using (department_id)
                join locations using (location_id)
group by department_id, department_name, job_id, city
having department_id > 80
order by 2;


-- Ex 24
SELECT employee_id
FROM job_history
GROUP BY employee_id
HAVING count(*) >=2;


-- Ex 25
-- NU ASA!!!! (ignora null)
select avg(commission_pct) "Comision mediu"
from employees;

-- VAR 1 CORECTA
select sum(commission_pct)/count(*) "Comision mediu"
from employees;

-- VAR 2 CORECTA
SELECT AVG(nvl(commission_pct,0))
FROM employees;


-- Ex 26
-- var cu ROLLUP
select department_id, to_char(hire_date, 'YYYY'), sum(salary)
from employees
where department_id < 50
group by rollup(department_id, to_char(hire_date, 'YYYY'));
--gr by = un fel de union all intre:
--gr by department_id, TO_CHAR
--gr by department_id
--gr by nimic (linia de la final)

--VAR CU CUBE
select department_id, to_char(hire_date, 'YYYY'), sum(salary)
from employees
where department_id < 50
group by cube(department_id, to_char(hire_date, 'YYYY'));
--gr by = un fel de union all intre:
--gr by nimic(linie de inceput)
--gr by TO_CHAR
--gr by department_id, TO_CHAR
--gr by department_id


-- Ex 27
-- var cu subcereri
select job_id "Job", 
(select sum(salary) from employees where job_id = e.job_id and department_id = 30) "Dep30",
(select sum(salary) from employees where job_id = e.job_id and department_id = 50) "Dep50",
(select sum(salary) from employees where job_id = e.job_id and department_id = 80) "Dep80",
sum(salary) "Total"
from employees e
group by job_id
order by 1;

-- var cu DECODE
select job_id "Job", sum(decode(department_id, 30, salary)) "Dep30", sum(decode(department_id, 50, salary)) "Dep50",
sum(decode(department_id, 80, salary)) "Dep80", sum(salary) "Total"
from employees
group by job_id
order by 1;


-- Ex 28
-- nr total angajati
select count(*) "Nr total angajati"
from employees;

-- nr ang din 1997
select count(*)
from employees
where to_char(hire_date, 'YYYY') = '1997';

-- cerinta
select distinct (select count(*) from employees) "Nr total angajati",
 (select count(*) from employees where to_char(hire_date, 'YYYY') = '1997') "Angajati in '97",
 (select count(*) from employees where to_char(hire_date, 'YYYY') = '1998') "Angajati in '98",
 (select count(*) from employees where to_char(hire_date, 'YYYY') = '1999') "Angajati in '99",
 (select count(*) from employees where to_char(hire_date, 'YYYY') = '2000') "Angajati in '00"
from employees;


-- Ex 29
select d.department_id "Dep ID", d.department_name "Dep name", 
(select count(*) from employees where department_id = e.department_id) "Nr ang",
(select round(avg(salary), 2) from employees where department_id = e.department_id) "Salariu mediu",
e.last_name "Nume", e.salary "Salariu angajat", e.job_id "Job ang"
from employees e right outer join departments d ON(e.department_id = d.department_id);


-- Ex 30
-- ce ar trebui sa obtin
select department_id, department_name, sum(salary)
from employees join departments using (department_id)
group by department_id, department_name
order by 1;

-- subcereri in clauza FROM
select department_id, department_name, a.Suma
from departments join (select department_id, sum(salary)Suma
                        from employees
                        group by department_id)a using (department_id)
order by 1;


-- Ex 31
select last_name, salary, department_id, a.Mediu
from employees join (select department_id, avg(salary)Mediu
                    from employees
                    group by department_id)a using (department_id)
order by 3;


-- Ex 32
select last_name, salary, department_id, a.Mediu "Salariul mediu", a.NrAng
from employees join (select department_id, round(avg(salary), 2)Mediu, count(*)NrAng
                    from employees
                    group by department_id)a using (department_id)
order by 3;


-- Ex 33
select department_name, department_id, a.Name, a.Salariu
from departments join (select last_name Name, salary Salariu, department_id
                        from employees e 
                        group by department_id, last_name, salary
                        having salary = (select min(salary)
                                        from employees
                                        where department_id = e.department_id))a using (department_id)
order by 1;


-- Ex 34
select d.department_id, d.department_name, a.Count, a.Sal "Salariu mediu", e.last_name, e.job_id, e.salary
from departments d join employees e on (d.department_id = e.department_id)
                   join (select department_id, count(*)Count, round(avg(salary), 2)Sal
                        from employees
                        group by department_id)a on (d.department_id = a.department_id)
order by 1;




