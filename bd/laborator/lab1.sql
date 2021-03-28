-- RECAP LAB 1

-- Ex 1
DESC employees;
DESC DEPARTMENTS;
DESC JOBS;
DESC JOB_HISTORY;
DESC LOCATIONS;
DESC COUNTRIES;
DESC REGIONS;

-- Ex 4
select * from employees;

-- Ex 5
select employee_id, last_name ||' '|| first_name "Nume si prenume", job_id, hire_date
from employees;

-- Ex 6
select distinct job_id
from employees;

-- Ex 7
select last_name ||', '||job_id "Angajat si titlu"
from employees;

-- Ex 8
SELECT last_name||','||job_id||','||first_name||','||salary||','||email "Informatii complete"
FROM employees;

-- Ex 9
select last_name "Nume", salary "Salariu"
from employees
where salary > 2850;

-- Ex 10
select last_name "Nume", department_id 
from employees
where employee_id = 104;

-- Ex 11
-- var 1
select last_name, salary
from employees
where salary < 1500 or salary > 2850
order by salary;

-- var 2
select last_name, salary
from employees
where salary not between 1500 and 2850
order by salary;

-- Ex 12
select last_name, job_id, hire_date
from employees
where hire_date between '20-FEB-1987' and '1-MAY-1989'
order by hire_date;

-- Ex 13
select last_name, department_id
from employees
where department_id in(10, 30)
order by last_name;

-- Ex 14
select last_name "Angajat", salary "Salariu", department_id
from employees
where salary > 3500 and department_id in (10, 30);

-- Ex 15
select sysdate
from dual;

select to_char(sysdate, 'ddd')
from dual;

-- Ex 16
-- var 1, cu formatul implicit al datei
select last_name, hire_date
from employees
where hire_date like '%87';

-- var 2, formatam data
select last_name, hire_date
from employees
where to_char(hire_date, 'YYYY') = '1987';

-- Ex 17
select last_name, job_id
from employees
where manager_id is null;

-- Ex 18
select last_name, salary, commission_pct 
from employees
where commission_pct is not null
order by salary desc, commission_pct desc;

-- Ex 19
select last_name, salary, commission_pct 
from employees
order by salary desc, commission_pct desc;

-- Ex 20
select last_name
from employees
where upper(last_name) like '__A%';

-- Ex 21
select last_name, first_name, department_id, manager_id
from employees
where (upper(first_name) like '%L%L%') and (department_id = 30 or manager_id = 101) ;

-- Ex 22
select last_name, job_id, salary
from employees
where (lower(job_id) like '%clerk%' or lower(job_id) like '%rep%') and salary not in (1000, 2000, 3000);

-- Ex 23
select last_name, salary, commission_pct
from employees
where salary > salary*commission_pct*5;










