-- RECAP LAB 3

-- Ex 1
select last_name "Nume", to_char(hire_date, 'MONTH') "Luna angajarii", to_char(hire_date, 'YYYY') "Anul angajarii"
from employees
where employee_id in (select ang.employee_id
                      from employees ang, employees gates
                      where ang.department_id = gates.department_id 
                      and ang.employee_id != gates.employee_id
                      and initcap(gates.last_name) = 'Gates'
                      and upper(ang.last_name) like '%A%')
order by last_name;


-- Ex 2
select employee_id, last_name, department_id, department_name
from employees join departments using (department_id)
where employee_id in (select e.employee_id
                      from employees e, employees coleg 
                      where e.department_id = coleg.department_id
                      and e.employee_id != coleg.employee_id
                      and upper(coleg.last_name) like '%T%')
order by employee_id;


-- Ex 3
select e.last_name "Nume", e.salary "Salariu", j.job_title "Job", l.city "Oras", c.country_name "Tara"
from employees e join departments d on (e.department_id = d.department_id)
               join jobs j on (e.job_id = j.job_id)
               join locations l on (l.location_id = d.location_id)
               join countries c on (c.country_id = l.country_id) 
where e.manager_id in (select employee_id
                     from employees
                     where initcap(last_name) = 'King');


-- Ex 4
select department_id "ID departament", department_name "Nume departament", last_name "Nume de familie", job_id "Job", to_char(salary, '$99,999.00') "Salariu"
from employees join departments using (department_id)
where lower(department_name) like '%ti%'
order by department_name, last_name;


-- Ex 5
select last_name "Nume", department_id "ID departament", department_name "Nume departament", city "Oras", job_id "Job"
from employees join departments using (department_id)
               join locations using (location_id)
where initcap(city) = 'Oxford';


-- Ex 6
select employee_id "ID angajat", last_name "Nume", salary "Salariu", (min_salary + max_salary) /2 "Medie salariu"
from employees join jobs using (job_id)
where salary > (min_salary + max_salary) / 2 and department_id in (select distinct department_id
                                                                   from employees
                                                                   where lower(last_name) like '%t%');


-- Ex 7
-- var 1
select e.last_name "Nume", d.department_name "Departament"
from employees e, departments d
where e.department_id = d.department_id (+)
order by d.department_name;

-- var 2
select e.last_name "Nume", d.department_name "Departament"
from departments d right outer join employees e on (d.department_id = e.department_id)
order by d.department_name;


-- Ex 8
-- var 1
select d.department_name "Departament", e.last_name "Nume"
from employees e, departments d
where e.department_id (+) = d.department_id;

-- var 2
select d.department_name "Departament", e.last_name "Nume"
from departments d left outer join employees e on (e.department_id = d.department_id);


-- Ex 10
-- var 1
select department_id, department_name
from departments 
where lower(department_name) like '%re%' or department_id in (select distinct department_id
                                                            from employees
                                                            where job_id = 'SA_REP');

-- var 2
select department_id
from departments
where lower(department_name) like '%re%'
UNION
select department_id
from employees
where job_id = 'SA_REP';


-- Ex 12
-- var 1
SELECT department_id
FROM departments

MINUS 

SELECT department_id
FROM employees;

-- var 2
SELECT d.department_id
FROM employees e right outer join departments d
                 on (e.department_id= d.department_id)
WHERE employee_id is null;

-- var 3
SELECT department_id
FROM departments
WHERE department_id not in (SELECT NVL(department_id,0)
                            FROM employees);


-- Ex 13
select department_id
from departments
where lower(department_name) like '%re%'
INTERSECT
select department_id
from employees
where job_id = 'HR_REP';


-- Ex 14
select employee_id, job_id, last_name, salary
from employees join jobs using (job_id)
where salary > 3000 or salary = (min_salary + max_salary) /2
order by salary;


-- Ex 15
select last_name, hire_date
from employees
where hire_date > (select hire_date
                   from employees
                   where initcap(last_name) = 'Gates');
                   

-- Ex 16
select last_name, salary, department_id
from employees
where initcap(last_name) != 'Gates' and department_id in (select department_id
                                                         from employees
                                                         where initcap(last_name) = 'Gates');
                                                         
                                                         
-- Ex 17
select last_name, salary, manager_id
from employees
where manager_id in (select employee_id
                    from employees
                    where manager_id is null);


-- Ex 18
select last_name, department_id, salary
from employees ang
where department_id in (select department_id
                        from employees
                        where commission_pct is not null and salary = ang.salary);


-- Ex 19
select employee_id, last_name, salary
from employees join jobs using (job_id)
where salary > (min_salary + max_salary) / 2 and department_id in (select distinct department_id
                                                                   from employees
                                                                   where lower(last_name) like '%t%');


-- Ex 20
select employee_id, salary
from employees
where salary > ALL(select salary
                from employees
                where upper(job_id) like '%clerk%')
order by salary desc;


-- Ex 21
select e.last_name, d.department_name, e.salary
from employees e join departments d on (e.department_id = d.department_id)
where e.commission_pct is null and e.manager_id in (select mgr.employee_id
                                                from employees ang join employees mgr on (ang.manager_id = mgr.employee_id)
                                                where ang.commission_pct is not null);


-- Ex 22
select e.last_name, e.department_id, e.salary, e.job_id
from employees e
where e.commission_pct in (select ang.commission_pct
                        from employees ang join departments d using (department_id)
                                           join locations using (location_id)
                        where ang.salary = e.salary and city = 'Oxford');


-- Ex 23
select last_name, department_id, job_id, city
from employees join departments using (department_id)
               join locations using (location_id)
where city = 'Toronto';

-- var cu subcereri
SELECT last_name, department_id, job_id
FROM employees
WHERE department_id in (SELECT department_id
                        FROM departments join locations using (location_id)
                        WHERE city='Toronto');
