-- LABORATOR 6


-- Ex 1
-- model 1 (not exists)
select employee_id, last_name
from employees 
where employee_id in (select distinct employee_id
                      from works_on a
                      where not exists (select project_id
                                        from projects p
                                        where months_between(start_date, to_date('01-JAN-2006')) <= 6
                                        and not exists (select employee_id
                                                        from works_on b
                                                        where b.project_id = p.project_id and a.employee_id = b.employee_id)));
                                                        
-- model 2 (count)                                                        
select employee_id, last_name
from employees
where employee_id in (select employee_id
                     from works_on a
                     where project_id in (select project_id from projects p  where months_between(start_date, to_date('01-JAN-2006')) <= 6)
                     group by employee_id
                     having count (project_id) = (select count(*)
                                                  from projects
                                                  where months_between(start_date, to_date('01-JAN-2006')) <= 6));
                                                        

-- model 3 (minus)
select employee_id, last_name
from employees
where employee_id in (select distinct employee_id
                      from works_on a
                      minus
                      select employee_id
                      from (select employee_id, project_id
                            from (select employee_id from works_on b)t1, 
                                 (select project_id from projects p where months_between(start_date, to_date('01-JAN-2006')) <= 6)t2
                            minus
                            select employee_id, project_id from works_on a)t3);
                        
-- model 4 (A include B => B/A = multVid)
select employee_id, last_name
from employees
where employee_id in (select distinct employee_id
                      from works_on a
                      where not exists ((select project_id 
                                        from projects p 
                                        where months_between(start_date, to_date('01-JAN-2006')) <= 6)
                                        minus
                                        (select p.project_id 
                                        from works_on b, projects p
                                        where b.project_id = p.project_id
                                        and  b.employee_id = a.employee_id)));


-- Ex 2
-- a)
select employee_id, last_name
from employees
where employee_id in (select distinct employee_id
                      from works_on a
                      where not exists ((select project_id 
                                        from works_on
                                        where employee_id = 200)
                                        minus
                                        (select project_id
                                        from works_on
                                        where employee_id = a.employee_id)));
                                                                           
-- b)
-- proiectele lui x incluse in proiectele lui 200
select employee_id, last_name
from employees
where employee_id in (select distinct employee_id
                      from works_on a
                      where not exists ((select project_id
                                            from works_on
                                            where employee_id = a.employee_id)
                                            minus
                                            (select project_id
                                            from works_on
                                            where employee_id = 200)));
                                       
-- c)
select employee_id, last_name
from employees
where employee_id in (select distinct employee_id
                      from works_on a
                      where not exists ((select project_id 
                                        from works_on
                                        where employee_id = 200)
                                        minus
                                        (select project_id
                                        from works_on
                                        where employee_id = a.employee_id))
                      and
                      not exists ((select project_id
                                            from works_on
                                            where employee_id = a.employee_id)
                                            minus
                                            (select project_id
                                            from works_on
                                            where employee_id = 200)));


-- Ex 3
select count(*), country_id
from employees join departments using (department_id)
                join locations using (location_id)
group by country_id;


-- Ex 4
-- var 1
select employee_id, last_name, department_id
from employees e
where exists (select distinct department_id
                      from employees
                      where employee_id in (select project_manager
                                            from projects)
                      and department_id = e.department_id)
order by 1;

-- var 2
select *
from employees
where department_id in (select department_id
                        from employees e join projects p on (e.employee_id = p.project_manager));


-- Ex 5
select *
from employees
where employee_id in (select distinct employee_id
                      from works_on a
                      where not exists ((select project_id
                                        from works_on
                                        where employee_id = a.employee_id)
                                        minus
                                        (select project_id
                                        from projects
                                        where project_manager = 102)));


-- Ex 6
accept p_cod prompt "cod = ";
select employee_id, last_name, salary, department_id
from employees
where employee_id = &p_cod;


-- Ex 7
select distinct job_id
from employees;

accept valJob prompt "job_id = ";
select last_name, department_id, 12*((1 + nvl(commission_pct, 0))*salary) "Salariu anual", job_id
from employees
where lower(job_id) = lower(&valJob);
                                                        
               
-- Ex 8
accept dataCalen prompt "Data = ";
select last_name, department_id, 12*((1 + nvl(commission_pct, 0))*salary) "Salariu anual", hire_date
from employees
where hire_date > &dataCalen
order by hire_date;


-- Ex 9
SELECT &&p_col
-- && determina ca valoarea lui p_coloana sa nu mai 
-- fie ceruta si pentru clauza ORDER BY, urmand sa 
-- fie utilizata valoarea introdusa aici pentru toate 
-- aparitiile ulterioare ale lui &p_coloana 
FROM  &p_tabel 
WHERE &p_where    
ORDER BY &p_col; 

SELECT salary
FROM employees
WHERE salary > 1000
ORDER BY salary;
                                                        

-- Ex 10
accept locationName prompt "Locatia este: ";
select last_name "Nume", job_id "Job", salary "Salariu", d.department_name "Nume departament", city "Oras"
from employees join departments d using (department_id),
     departments join locations using (location_id)
where lower(&locationName) = lower(city);

-- Ex 11
--a)
ACCEPT data_inceput PROMPT 'Introduceti data de inceput'
ACCEPT data_sfarsit PROMPT 'Introduceti data de sfarsit'

SELECT (TO_DATE(&data_inceput,'DD-MM-YYYY') + ROWNUM - 1) dt
FROM DUAL 
CONNECT BY ROWNUM <= TO_DATE(&data_sfarsit,'DD-MM-YYYY') - TO_DATE(&data_inceput,'DD-MM-YYYY') + 1;

-- SAU
SELECT (TO_DATE(&data_inceput,'DD-MM-YYYY') + ROWNUM-1) dt
FROM DUAL 
CONNECT BY (TO_DATE(&data_inceput,'DD-MM-YYYY') + ROWNUM-1) <= TO_DATE(&data_sfarsit,'DD-MM-YYYY');

-- b)
SELECT dt, TO_CHAR(dt,'DY')
FROM ( SELECT (TO_DATE(&data_inceput,'DD-MM-YYYY') + ROWNUM-1) dt
       FROM DUAL 
       CONNECT BY (TO_DATE(&data_inceput,'DD-MM-YYYY') + ROWNUM-1) <= TO_DATE(&data_sfarsit,'DD-MM-YYYY') )
WHERE TO_CHAR(dt,'D') <= 5;



                                      
                                                        