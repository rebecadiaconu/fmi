-- TEMA 4, DIACONU REBECA-MIHAELA, GRUPA 233

-- Laborator 4

-- Ex 12
select department_id, department_name, sum(salary)
from employees join departments using(department_id)
group by department_name, department_id;

-- Ex 17
select department_name, min(salary)
from employees join departments using (department_id)
group by department_name
having avg(salary) = (select max(avg(salary))
                      from employees
                      group by department_id);
                      
-- Ex 21
select department_id, sum(salary)
from employees
where department_id != 10
group by department_id
having count(employee_id) > 10;