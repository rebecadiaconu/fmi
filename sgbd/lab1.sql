-- LABORATOR 1

-- EX 1
select department_id "Departament", to_char(hire_date, 'YYYY') "An angajare", count(*) "Nr. angajati",
round(count(*)/(select count(*) from employees), 2) "Procent"
from employees join departments using (department_id)
group by department_id, to_char(hire_date, 'YYYY')
order by department_id;


-- EX 2
select country_name "Tara", city "Oras", count(department_id) "Nr. departamente"
from departments join locations using (location_id)
               join countries using (country_id)
where department_id in (select department_id
                        from employees join departments using (department_id)
                        group by department_id
                        having count(*) >= 5)
group by country_name, city
order by country_name;

-- EX 3
select employee_id "Angajat", last_name "Nume", salary "Salariul", 
case 
when months_between(sysdate, hire_date) <= 12 then 1.05*salary
when months_between(sysdate, hire_date) <= 60 then 1.1*salary
else 1.15*salary
end "Salariul majorat"
from employees;

-- EX 4
select distinct loc.city
from locations loc join departments dep1 on (dep1.location_id = loc.location_id)
where not exists (select emp.department_id
                  from employees emp join departments dep2 on (dep2.department_id = emp.department_id)
                  where to_char(hire_date, 'YYYY') = '1997' and dep1.department_id = dep2.department_id);
                  
-- EX 5

select job_title, 
case 
when job_title like 'S%' then (select sum(salary) from employees where job_id = j.job_id) 
when max_salary = (select max(max_salary) from jobs) then (select avg(salary) 
                                                           from employees e2 
                                                           where e2.job_id = e1.job_id) 
when (select count(1) from employees where job_id = j.job_id) = 0 then min_salary 
else (select min(salary) from employees where job_id = j.job_id) 
end "statistica" 
from jobs j join employees e1 on j.job_id = e1.job_id;
