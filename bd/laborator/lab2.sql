-- RECAP LAB 2

-- Ex 1
select first_name ||' '||last_name||' castiga '||salary||' dar doreste '||salary * 3||'.' "Salariu ideal"
from employees;

-- puteam fol si functia CONCAT


-- Ex 2
-- var cu LIKE
select initcap(first_name) "Prenume", upper(last_name) "Nume", length(last_name) "Lungimea numelui"
from employees
where (upper(last_name) like 'J%' or upper(last_name)like 'M%') or upper(last_name) like '__A%'
order by length(last_name) desc;

-- var cu SUBSTR
select initcap(first_name) "Prenume", upper(last_name) "Nume", length(last_name) "Lungimea numelui"
from employees
where (upper(substr(last_name,1,1)) = 'J' or upper(substr(last_name,1,1)) = 'M') or upper(substr(last_name, 3, 1)) = 'A'
order by length(last_name) desc;


-- Ex 3
 select employee_id, last_name, first_name, department_id
 from employees
 where initcap(trim(both from first_name)) = 'Steven';


-- Ex 4
select employee_id "ID angajat", last_name "Nume", length(last_name)"Lungime nume"
from employees
where lower(last_name) like '%e';


-- Ex 5
select * from employees
where mod(round(sysdate - hire_date),7) = 0;


-- Ex 6
select employee_id "ID anagajat", last_name "Nume", salary "Salariu", round(1.15*salary, 2) "Salariu nou", round(1.15*salary/100, 2) "Numar sute"
from employees
where mod(salary, 1000) != 0;


-- Ex 7
select last_name "Nume de familie", hire_date "Data angajarii"
from employees
where commission_pct is not null;


-- Ex 8
select to_char(sysdate + 30, 'MONTH/DD/YYYY hh24:mi:ss') "Data si ora de peste30 de zile"
from dual;


-- Ex 9
select round(last_day('20/DEC/2020') - sysdate) "Zile pana la finalul anului"
from dual;


-- Ex 11
select last_name||' '||first_name " Nume si prenume", hire_date, next_day(add_months(hire_date, 6), 'Monday') "Negociere salariu"
from employees;


-- Ex 12
select last_name "Nume", round(months_between( (select sysdate from dual), hire_date)) "Numar luni lucrate"
from employees
order by round(months_between( (select sysdate from dual), hire_date));


-- Ex 13
select last_name, hire_date, lower(to_char(hire_date, 'DAY')) "Zi"
from employees;


-- Ex 14
-- var 1
select last_name "Nume", commission_pct,
case 
when commission_pct is null then 'Fara comision'
else to_char(commission_pct)
end "Comision"
from employees;

-- var 2
SELECT last_name, NVL(TO_CHAR(commission_pct), 'Fara comision') Comision
from employees;


-- Ex 15
select last_name, salary, commission_pct
from employees
where salary + salary * NVL(commission_pct, 0) > 10000;


-- Ex 16
-- var CASE
select last_name "Nume", job_id "ID job", salary "Salariu", 
case 
when upper(job_id) like 'IT_PROG' then 1.2*salary
when upper(job_id) like 'SA_REP' then 1.25*salary
when upper(job_id) like 'SA_MAN' then 1.35*salary
else salary
end "Salariul dupa marire"
from employees;

-- var DECODE
select last_name "Nume", job_id "ID job", salary "Salariu", 
DECODE(job_id, 'IT_PROG',1.2*salary, 'SA_REP', 1.25*salary, 'SA_MAN', 1.35*salary, salary) "Salariul dupa marire"
from employees;


-- Ex 17
select last_name "Nume", e.department_id "ID departament", d.department_name "Nume departament"
from employees e join departments d on (e.department_id = d.department_id);


-- Ex 18
select job_title, department_id
from employees join jobs using (job_id)
where department_id = 30;


-- Ex 19
select last_name, department_name, location_id
from employees join departments using (department_id)
where commission_pct is not null;


-- Ex 20
select last_name, department_name
from employees join departments using(department_id)
where upper(last_name) like '%A%';


-- Ex 21
select last_name, job_id, department_id, department_name, city
from employees join departments using (department_id)
               join locations using (location_id)
where initcap(city) = 'Oxford';


-- Ex 22
select e.employee_id "Ang#", e.last_name "Angajat", mgr.manager_id "Mgr#", mgr.last_name "Manager"
from employees e join employees mgr on (e.manager_id = mgr.employee_id);


-- Ex 23
select ang.employee_id "#Ang" , ang.last_name "Angajat",  mgr.manager_id "#Mgr", mgr.last_name "Manager"
from employees ang, employees mgr 
where ang.manager_id = mgr.employee_id (+);


-- Ex 24
select ang.last_name, ang.department_id, colg.last_name "Coleg"
from employees ang join employees colg on (ang.department_id = colg.department_id)
where ang.employee_id != colg.employee_id;


-- Ex 25
DESC jobs;

select last_name, job_id, job_title, department_name, salary
from employees join departments using (department_id)
               join jobs using (job_id);
               
               
-- Ex 26
select e.last_name "Nume", e.hire_date "Data angajare", gates.hire_date "Gates data angajare"
from employees e, employees gates 
where e.hire_date > gates.hire_date and initcap(gates.last_name) = 'Gates'
order by e.hire_date;


-- Ex 27
select ang.last_name "Angajat", ang.hire_date "Data angajat", mgr.last_name "Manager", mgr.hire_date "Data manager"
from employees ang, employees mgr
where ang.manager_id = mgr.employee_id and ang.hire_date < mgr.hire_date;




