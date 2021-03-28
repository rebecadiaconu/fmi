-- LABORATOR 5


-- Ex 1
-- a)
select department_name, job_title, round(avg(salary), 2)
from employees join departments using (department_id)
                join jobs using (job_id)
group by rollup (department_name, job_title);

-- b)
select department_name, job_title, round(avg(salary), 2), grouping(department_name), grouping(job_title)
from employees join departments using (department_id)
                join jobs using (job_id)
group by rollup (department_name, job_title);



-- Ex 2
-- a)
select department_name, job_title, round(avg(salary), 2)
from employees join departments using (department_id)
                join jobs using (job_id)
group by cube(department_name, job_title);

-- b)
select department_name, job_title, round(avg(salary), 2),
CASE WHEN GROUPING(department_name) = 0 and GROUPING(job_title) = 0 THEN 'Dep Job'
     WHEN GROUPING (department_name) = 0 THEN 'Dep'
     WHEN GROUPING (job_title) = 0 THEN 'Job'
     ELSE ' '
     END "Intervine in agregare"
from employees join departments using (department_id)
                join jobs using (job_id)
group by cube(department_name, job_title);


-- Ex 3
select department_name, job_title, e.manager_id, max(salary), sum(salary)
from employees e join departments using (department_id)
                join jobs using (job_id)
group by grouping sets((department_name, job_title), (job_title, e.manager_id), ());


-- Ex 5
-- a)
select last_name, salary, department_id
from employees e
where salary > (select avg(salary)
                    from employees
                    where department_id = e.department_id)
order by 3;

-- b)
-- subcerere necorelata in FROM
select last_name, salary, department_id, department_name, d.Count, d.Medie
from employees join departments using (department_id)
                join (select department_id, count(*)Count, round(avg(salary), 2)Medie
                      from employees
                      group by department_id)d using (department_id)
where salary > d.Medie
order by 3;

-- subcerere corelata in SELECT
select e.last_name, e.salary, e.department_id, d.department_name, 
(select count(*) from employees where department_id = e.department_id),
(select round(avg(salary), 2) from employees where department_id = e.department_id)
from employees e join departments d on (e.department_id = d.department_id)
where e.salary > (SELECT AVG(salary)
                FROM employees
                WHERE department_id = e.department_id)
group by e.department_id, d.department_name, e.last_name, e.salary 
order by 3;


-- Ex 6
-- var cu ALL
select last_name, salary
from employees
where salary > all (select avg(salary)
                    from employees
                    group by department_id);
                    
-- varianta cu MAX
select last_name, salary
from employees
where salary > (select max(avg(salary))
                    from employees
                    group by department_id);


-- Ex 7
-- subcerere sincron
select last_name, salary, department_id
from employees e
where salary in (select min(salary)
                from employees
                group by department_id
                having department_id = e.department_id)
order by 2;

-- subcerere nesincron
select last_name, salary, department_id
from employees
where (department_id, salary) in (select department_id, min(salary)
                                from employees
                                group by department_id)
order by 2;

-- subcerere in FROM
select last_name, salary, department_id
from employees join (select department_id, min(salary)SalMin
                    from employees
                    group by department_id)a using (department_id)
where salary = a.SalMin
order by 2;


-- Ex 8
select last_name "Nume", round(sysdate - hire_date) "Zile vechime", department_id "ID dep"
from employees e
group by department_id, last_name, round(sysdate - hire_date)
having round(sysdate - hire_date) in (select max (round(sysdate - hire_date))
                                from employees
                                group by department_id
                                having department_id = e.department_id);


-- Ex 9
-- sal maxim din dep 30
select max(salary)
from employees
where department_id = 30;

select last_name, department_id
from employees
where department_id in (select department_id
                        from employees e
                        where exists (select 1
                                      from employees
                                      where e.salary = (select max(salary)
                                                        from employees
                                                        where department_id = 30)));
                                                        
                                                        
-- Ex 10
-- GRESIT!!!!! --> mai intai executa where ul si dupa order by
select last_name, salary
from employees
where rownum <= 3
order by salary desc;

-- Var 1 CORECTA
select last_name, salary
from employees e
where 3 > (select count(salary)
           from employees
           where salary > e.salary);
           
-- var 2 CORECTA
select last_name, salary
from (select * from employees e order by salary desc)
where rownum <= 3;


-- Ex 11
select employee_id, last_name, first_name 
from employees e
where 2 <= (select count(*)
            from employees
            where manager_id = e.employee_id);
            
            
-- Ex 12
-- var 1
select distinct location_id
from departments d
where exists (select 1
             from departments
             where location_id = d.location_id);
             
-- var 2
select location_id
from departments l
where exists (select 1
              from departments
              where department_id is not null and location_id = l.location_id)
group by location_id;


-- Ex 13
-- var 1
select department_id
from departments d
where not exists(select 1
                from employees
                where department_id = d.department_id
                group by department_id
                having  count(employee_id) > 0);
                
-- var 2
select department_id
from departments d
where not exists (select employee_id from employees where department_id = d.department_id)
order by 1;


-- Ex 14
-- a)
select employee_id, last_name, hire_date, salary, manager_id
from employees
where manager_id = (select employee_id
                        from employees
                        where lower(last_name) like 'de haan');

-- b)
select employee_id, last_name, hire_date, salary, manager_id
from employees
start with manager_id = (select employee_id
                        from employees
                        where lower(last_name) like 'de haan')
connect by prior employee_id = manager_id;


-- Ex 15
select last_name, employee_id, manager_id
from employees
start with employee_id = 114
connect by prior employee_id = manager_id;


-- Ex 16
select employee_id, manager_id, last_name
from employees
where level = 2
start with manager_id = (select employee_id
                        from employees
                        where lower(last_name) like 'de haan')
connect by manager_id = prior employee_id;


-- Ex 17
select manager_id, employee_id, level, last_name, lpad(last_name, length(last_name) + level * 2 - 2, '_') 
from employees
connect by prior manager_id = employee_id;


-- Ex 18
-- ang cu salariul maxim
select employee_id
from employees
where salary = (select max(salary)
                from employees);

-- cerinta
select manager_id, employee_id, last_name, salary, level
from employees
start with employee_id = (select employee_id
                        from employees
                        where salary = (select max(salary)
                                        from employees))
connect by prior employee_id = manager_id and salary > 5000;


-- Ex 19
with val_dept as (select department_name, sum(salary) as total
                 from departments join employees using (department_id)
                 group by department_name),
     val_sal as (select avg(total) as medie
                from val_dept)

select *
from val_dept
where total > (select medie
              from val_sal)
order by department_name;


-- Ex 20
WITH subord AS ( SELECT employee_id, hire_date
                 FROM employees
                 WHERE manager_id = ( SELECT employee_id
                                      FROM employees
                                      WHERE LOWER(last_name || first_name) = 'kingsteven'
                                    ) 
               ),
               
vechime AS ( SELECT employee_id
             FROM subord
             WHERE hire_date = ( SELECT MIN(hire_date) FROM subord ) 
            )

-- cererea principala            
SELECT employee_id, last_name || first_name "Nume si prenume", job_id, hire_date, manager_id
FROM employees
WHERE to_char(hire_date,'yyyy') != 1970
START WITH employee_id IN ( SELECT employee_id FROM vechime )
CONNECT BY PRIOR employee_id = manager_id;


-- Ex 21
select employee_id, salary
from (select * from employees order by salary desc)
where rownum <= 10;


-- Ex 22
select *
from (select job_id, avg(salary) "Medie salarii" from employees group by job_id order by 2)
where rownum <= 3;
                    
                    
-- Ex 23
select 'Departamentul ' || d.department_name || ' este condus de ' ||
case
when d.manager_id is null then 'nimeni'
else to_char(d.manager_id)
end
|| ' si ' ||
case 
when (select count(*) from employees
        where department_id = d.department_id) = 0 then 'nu are angajati'
else 'are ' || (select count(*) from employees where department_id = d.department_id) || ' salariati.'
end
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
 
