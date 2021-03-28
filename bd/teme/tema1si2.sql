-- TEMA 1

-- Ex 19

select last_name, salary, commission_pct
from employees
order by commission_pct desc, salary desc;

/* Putem observa ca valorile NULL sunt plasate la inceput, in cazul in care sortam descrescator. */

-- Ex 20

select last_name "Nume"
from employees
where upper(last_name) like '__A%';

-- Ex 22

select last_name, job_id, salary
from employees
where (lower(job_id) like '%clerk%' or lower(job_id) like '%rep%') and salary NOT IN (1000,2000,3000);

-- Ex 23

select last_name, salary, commission_pct
from employees
where salary > salary * commission_pct * 5;

-- TEMA 2 

-- Ex 3

select employee_id, last_name, department_id
from employees
where TRIM(BOTH FROM upper(first_name)) = 'STEVEN';

-- Ex 4

select employee_id "Cod angajat" , last_name "Nume" , length(last_name) "Lungime nume", INSTR(lower(last_name),'a') "Prima regasire 'a'"
from employees
where substr(lower(last_name),length(last_name), length(last_name)) = 'e'; 

-- Ex 9
/* Numarul de zile ramase pana la sfarsitul anului. */

select round(LAST_DAY('02-DEC-2020') - sysdate) "Zile pana la final de an"
from dual;

-- Ex 10
-- a)
select to_char(sysdate + 1/2, 'MON/DD/YYYY hh24:mi:ss') "Data peste 12 ore"
from dual;

-- b)
select to_char(sysdate+1/1440*5,'MON/DD/YYYY hh24:mi:ss') "Data peste 5 minute"
from dual;

-- Ex 11
select last_name||' '||first_name "Nume si prenume", hire_date, NEXT_DAY(ADD_MONTHS(to_char(hire_date), 6), 'Monday') "Negociere"
from employees;

-- Ex 12
-- ordonat crescator
select last_name||' '||first_name "Nume si prenume", round(MONTHS_BETWEEN(sysdate, hire_date)) "Luni lucrate"
from employees
order by round(MONTHS_BETWEEN(sysdate, hire_date));

-- ordonat descrescator
select last_name||' '||first_name "Nume si prenume", round(MONTHS_BETWEEN(sysdate, hire_date)) "Luni lucrate"
from employees
order by round(MONTHS_BETWEEN(sysdate, hire_date)) desc;

-- Ex 13

select last_name, hire_date, to_char(hire_date, 'DAY') "Zi"
from employees
order by to_char(hire_date, 'D');


