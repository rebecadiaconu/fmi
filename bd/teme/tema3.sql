-- TEMA 3, Diaconu Rebeca-Mihaela, Grupa 233

-- Ex 14

select e.last_name, e.employee_id, j.job_id, e.salary
from employees e join jobs j on (e.job_id = j.job_id)
where e.salary > 3000
union
select e.last_name, e.employee_id, j.job_id, e.salary
from employees e join jobs j on (e.job_id = j.job_id)
where e.salary = (j.min_salary + j.max_salary)/2;

-- Ex 17

select last_name, salary, manager_id
from employees
where manager_id = (select employee_id
                    from employees
                    where manager_id is null);