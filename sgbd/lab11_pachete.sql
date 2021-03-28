-- LABORATOR 11 - PACHETE

-- Ex 1
CREATE or replace PACKAGE  DEPT_PKG is 
    procedure add_dept(dep_id departments.department_id%type, 
                       dep_name departments.department_name%type, 
                       managerCod departments.manager_id%type, 
                       locationCod departments.location_id%type); 

    procedure DEL_DEPT(dep_id number); 

    procedure UPD_DEPT( dep_id departments.department_id%type, 
                        dep_name departments.department_name%type); 
                        
    function GET_DEPT(dep_id number) return varchar2; 
end; 
/ 

create or replace package body DEPT_PKG as 
     procedure add_dept(dep_id departments.department_id%type, 
                        dep_name departments.department_name%type, 
                        managerCod departments.manager_id%type, 
                        locationCod departments.location_id%type) 
    is 
    begin 
        insert into dept values(dep_id, dep_name, managerCod, locationCod); 
    end; 

     procedure DEL_DEPT(dep_id number) is  
    begin 
        delete from dept where department_id = dep_id; 
    end;

    procedure UPD_DEPT( dep_id departments.department_id%type, 
                        dep_name departments.department_name%type) 
    is 
    begin 
        update dept set department_name = dep_name
        where department_id = dep_id; 
    end; 

    function GET_DEPT( dep_id number) return varchar2 
    is 
        name_dep varchar(30); 
    begin 
        select department_name into name_dep 
        from dept 
        where department_id = dep_id; 
        
        return name_dep; 
        
    exception 
        when no_data_found then  
            raise_application_error(-20002, 'Error'); 
        when too_many_rows then 
            raise_application_error(-20003, 'Too many rows');   
    end; 
end; 
/ 

set serveroutput on; 
begin 
    dept_pkg.add_dept(212, 'Ittt', null, null); 
    -- dept_pkg.upd_dept(222, 'Ittt', 100, 10); 
    -- dept_pkg.DEL_DEPT(222); 
    
    dbms_output.put_line(dept_pkg.get_dept(222)); 
end; 
/ 

select * from dept; 


-- Ex 2
create or replace package emp_pkg is
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type,
                      comm_pct emp.commission_pct%type,
                      cod_manager emp.manager_id%type,
                      cod_dept emp.department_id%type);
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type);
end;
/

create or replace package body emp_pkg as
    function valid_job_id(cod_job emp.job_id%type) return number
    is
        v_count number := 0;
    begin
        select count(*) into v_count
        from jobs
        where job_id = cod_job;
        
        dbms_output.put_line(v_count);
        
        if(v_count > 0) then
            return 1;
        else
            return 0;
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type,
                      comm_pct emp.commission_pct%type,
                      cod_manager emp.manager_id%type,
                      cod_dept emp.department_id%type)
    is    
    begin
        if valid_job_id(cod_job) = 1 then
            insert into emp values(seq_emp.nextval, fName, lName, email, phone, hireDate, cod_job, salariu, comm_pct, cod_manager, cod_dept);
        else
            raise_application_error(-20002, 'Cod job invalid!');
        end if;
    end;
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type)
    is
    begin
        select salary, job_id into salariu, cod_job
        from emp
        where employee_id = cod_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Angajatul nu exista!');
    end;
end;
/

set serveroutput on;

declare
    cod_emp emp.employee_id%type;
    salariu emp.salary%type;
    cod_job emp.job_id%type;
begin
    emp_pkg.add_emp('aa', 'bb', 'email', '039201', sysdate - 5, 'AD_VP', 9999, 0, 100, 80);
    
    if sql%rowcount = 1 then
        select employee_id into cod_emp
        from emp
        where first_name = 'aa' and last_name = 'bb';
    
        emp_pkg.get_emp(cod_emp, salariu, cod_job);
        dbms_output.put_line(cod_emp || ' ' || salariu || ' ' || cod_job);
    else
        raise_application_error(-20003, 'Angajatul nu exista!');
    end if;
end;
/

select * from emp;


-- Ex 3
create or replace package emp_pkg is
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type := null,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type := null,
                      comm_pct emp.commission_pct%type := null,
                      cod_manager emp.manager_id%type := null,
                      cod_dept emp.department_id%type := null);
                      
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      cod_job emp.job_id%type);
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type);
end;
/

create or replace package body emp_pkg as
    function valid_job_id(cod_job emp.job_id%type) return number
    is
        v_count number := 0;
    begin
        select count(*) into v_count
        from jobs
        where job_id = cod_job;
        
        dbms_output.put_line(v_count);
        
        if(v_count > 0) then
            return 1;
        else
            return 0;
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type := null,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type := null,
                      comm_pct emp.commission_pct%type := null,
                      cod_manager emp.manager_id%type := null,
                      cod_dept emp.department_id%type := null)
    is    
    begin
        if valid_job_id(cod_job) = 1 then
            insert into emp values(seq_emp.nextval, fName, lName, email, phone, hireDate, cod_job, salariu, comm_pct, cod_manager, cod_dept);
        else
            raise_application_error(-20002, 'Cod job invalid!');
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      cod_job emp.job_id%type) 
    is
        v_email emp.email%type;
    begin
        v_email := upper(substr(fName,0,1) || substr(lName,0,7));
        add_emp(lName => lName, fName => fName, email => v_email, cod_job => cod_job);
    end;
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type)
    is
    begin
        select salary, job_id into salariu, cod_job
        from emp
        where employee_id = cod_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Angajatul nu exista!');
    end;
end;
/

begin
    emp_pkg.add_emp('Diaconu', 'Rebeca', 'AD_PRES');
end;
/

select * from emp;


-- Ex 4
-- a) + b)
create or replace package emp_pkg is
    function get_emp(p_emp_id in employees.employee_id%type) return employees%rowtype;
    function get_emp(lName in employees.last_name%type) return employees%rowtype;
    procedure print_employee(v_emp in employees%rowtype);
end emp_pkg;
/

create or replace package body emp_pkg as
    function get_emp(p_emp_id in employees.employee_id%type) return employees%rowtype
    is
        v_emp employees%rowtype;
    begin
        select * into v_emp
        from emp
        where employee_id = p_emp_id;
        
        return v_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Nu exista angajatul cautat!');
    end;
    
    function get_emp(lName in employees.last_name%type) return employees%rowtype
    is
        v_emp employees%rowtype;
    begin
        select * into v_emp
        from emp
        where lower(last_name) = lower(lName);
        
        return v_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Nu exista angajatul cautat!');
    end;
    
    procedure print_employee(v_emp in employees%rowtype)
    is
    begin
        dbms_output.put_line(v_emp.department_id || ' ' || v_emp.employee_id || ' ' || v_emp.first_name || ' ' ||
        v_emp.job_id || ' ' || v_emp.salary);
    end;
end;
/

-- c)
select * from emp;

set serveroutput on;

declare
    nume employees.last_name%type := 'Baer';
    cod employees.employee_id%type := 203;
    emp1 employees%rowtype;
    emp2 employees%rowtype;
begin
    emp1 := emp_pkg.get_emp(nume);
    emp2 := emp_pkg.get_emp(cod);
    
    emp_pkg.print_employee(emp1);
    emp_pkg.print_employee(emp2);
end;
/


-- Ex 5
create or replace package emp_pkg is
    -- functia ceruta
    function valid_deptid(cod_dept emp.department_id%type) return number;
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type := null,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type := null,
                      comm_pct emp.commission_pct%type := null,
                      cod_manager emp.manager_id%type := null,
                      cod_dept emp.department_id%type := null);
                      
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      cod_job emp.job_id%type);
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type);
                      
    function get_emp(p_emp_id in employees.employee_id%type) return employees%rowtype;
    function get_emp(lName in employees.last_name%type) return employees%rowtype;
    procedure print_employee(v_emp in employees%rowtype);
end;
/

create or replace package body emp_pkg as
    -- functia ceruta de exercitiu
    function valid_deptid(cod_dept emp.department_id%type) return number
    is
        v_count number := -1;
    begin
        select count(*) into v_count
        from dept
        where department_id = cod_dept;
        
        if v_count > 0 then
            return 1;
        else 
            return 0;
        end if;
    end;

    function valid_job_id(cod_job emp.job_id%type) return number
    is
        v_count number := 0;
    begin
        select count(*) into v_count
        from jobs
        where job_id = cod_job;
        
        dbms_output.put_line(v_count);
        
        if(v_count > 0) then
            return 1;
        else
            return 0;
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type := null,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type := null,
                      comm_pct emp.commission_pct%type := null,
                      cod_manager emp.manager_id%type := null,
                      cod_dept emp.department_id%type := null)
    is    
    begin
        if valid_job_id(cod_job) = 1 and valid_deptid(cod_dept) = 1 then
            insert into emp values(seq_emp.nextval, fName, lName, email, phone, hireDate, cod_job, salariu, comm_pct, cod_manager, cod_dept);
        else
            raise_application_error(-20002, 'Cod job sau cod departament invalid!');
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      cod_job emp.job_id%type) 
    is
        v_email emp.email%type;
    begin
        v_email := upper(substr(fName,0,1) || substr(lName,0,7));
        add_emp(lName => lName, fName => fName, email => v_email, cod_job => cod_job);
    end;
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type)
    is
    begin
        select salary, job_id into salariu, cod_job
        from emp
        where employee_id = cod_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Angajatul nu exista!');
    end;
    
    function get_emp(p_emp_id in employees.employee_id%type) return employees%rowtype
    is
        v_emp employees%rowtype;
    begin
        select * into v_emp
        from emp
        where employee_id = p_emp_id;
        
        return v_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Nu exista angajatul cautat!');
    end;
    
    function get_emp(lName in employees.last_name%type) return employees%rowtype
    is
        v_emp employees%rowtype;
    begin
        select * into v_emp
        from emp
        where lower(last_name) = lower(lName);
        
        return v_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Nu exista angajatul cautat!');
    end;
    
    procedure print_employee(v_emp in employees%rowtype)
    is
    begin
        dbms_output.put_line(v_emp.department_id || ' ' || v_emp.employee_id || ' ' || v_emp.first_name || ' ' ||
        v_emp.job_id || ' ' || v_emp.salary);
    end;
end;
/

set serveroutput on;

select * from dept;

begin
    emp_pkg.add_emp('aa', 'bb', 'email', '039201', sysdate - 5, 'AD_VP', 9999, 0, 100, 15);
end;
/

-- tabelul cerut este creat la exercitiul 6

-- Ex 6
-- a) a creat tabelul, procedura init_dept si am modificat functia valid_dept

create or replace package emp_pkg is
    -- procedura ceruta
    procedure init_dept;
    function valid_deptid(cod_dept emp.department_id%type) return number;
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type := null,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type := null,
                      comm_pct emp.commission_pct%type := null,
                      cod_manager emp.manager_id%type := null,
                      cod_dept emp.department_id%type := null);
                      
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      cod_job emp.job_id%type);
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type);
                      
    function get_emp(p_emp_id in employees.employee_id%type) return employees%rowtype;
    function get_emp(lName in employees.last_name%type) return employees%rowtype;
    procedure print_employee(v_emp in employees%rowtype);
end;
/

create or replace package body emp_pkg as
    type boolean_dept is table of boolean
    index by binary_integer;
    dept_valid_tab boolean_dept;
    
    function valid_deptid(cod_dept emp.department_id%type) return number
    is
    begin
        if dept_valid_tab.exists(cod_dept) then
            return 1;
        else 
            return 0;
        end if;
    exception
        when no_data_found then
            return 0;
    end;

    function valid_job_id(cod_job emp.job_id%type) return number
    is
        v_count number := 0;
    begin
        select count(*) into v_count
        from jobs
        where job_id = cod_job;
        
        dbms_output.put_line(v_count);
        
        if(v_count > 0) then
            return 1;
        else
            return 0;
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      email emp.email%type,
                      phone emp.phone_number%type := null,
                      hireDate emp.hire_date%type := sysdate,
                      cod_job emp.job_id%type,
                      salariu emp.salary%type := null,
                      comm_pct emp.commission_pct%type := null,
                      cod_manager emp.manager_id%type := null,
                      cod_dept emp.department_id%type := null)
    is    
    begin
        if valid_job_id(cod_job) = 1 and valid_deptid(cod_dept) = 1 then
            insert into emp values(seq_emp.nextval, fName, lName, email, phone, hireDate, cod_job, salariu, comm_pct, cod_manager, cod_dept);
        else
            raise_application_error(-20002, 'Cod job sau cod departament invalid!');
        end if;
    end;
    
    procedure add_emp(lName emp.last_name%type,
                      fName emp.first_name%type,
                      cod_job emp.job_id%type) 
    is
        v_email emp.email%type;
    begin
        v_email := upper(substr(fName,0,1) || substr(lName,0,7));
        add_emp(lName => lName, fName => fName, email => v_email, cod_job => cod_job);
    end;
    
    procedure get_emp(cod_emp in emp.employee_id%type,
                      salariu out emp.salary%type,
                      cod_job out emp.job_id%type)
    is
    begin
        select salary, job_id into salariu, cod_job
        from emp
        where employee_id = cod_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Angajatul nu exista!');
    end;
    
    function get_emp(p_emp_id in employees.employee_id%type) return employees%rowtype
    is
        v_emp employees%rowtype;
    begin
        select * into v_emp
        from emp
        where employee_id = p_emp_id;
        
        return v_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Nu exista angajatul cautat!');
    end;
    
    function get_emp(lName in employees.last_name%type) return employees%rowtype
    is
        v_emp employees%rowtype;
    begin
        select * into v_emp
        from emp
        where lower(last_name) = lower(lName);
        
        return v_emp;
    exception
        when no_data_found then
            raise_application_error(-20002, 'Nu exista angajatul cautat!');
    end;
    
    procedure print_employee(v_emp in employees%rowtype)
    is
    begin
        dbms_output.put_line(v_emp.department_id || ' ' || v_emp.employee_id || ' ' || v_emp.first_name || ' ' ||
        v_emp.job_id || ' ' || v_emp.salary);
    end;
    
    -- procedura ceruta de exercitiu
    procedure init_dept 
    is
    begin
        for dept in (select distinct department_id from dept) loop
            dept_valid_tab(dept.department_id) := TRUE;
        end loop;
    end;
    
begin
    init_dept;
end;
/

-- b)
begin
    emp_pkg.add_emp('cc', 'dd', 'email123', '039201', sysdate - 6, 'AD_VP', 9999, 0, 100, 15);
end;
/


-- Ex 7
create or replace package find_salary is
    cursor emp_sal(salariu_max number) return employees%rowtype;
    function max_sal(oras locations.city%type) return number;
end;
/

create or replace package body find_salary 
is
    cursor emp_sal(salariu_max number) return employees%rowtype
    is select * from employees where salary >= salariu_max;
    
    function max_sal(oras locations.city%type) return number
    is
        sal_max number :=0;
    begin
        select max(salary) into sal_max
        from employees join departments using (department_id)
                       join locations using (location_id)
        where lower(city) = lower(oras);
        
        return sal_max;
    exception
        when no_data_found then
            return 0;
    end;
end;
/

set serveroutput on;

declare

begin
    dbms_output.put_line(find_salary.max_sal('Oxford'));
    for emp in find_salary.emp_sal(find_salary.max_sal('Oxford')) loop
        dbms_output.put_line(emp.last_name || ' ' || emp.employee_id || ' ' || emp.salary);
    end loop;
end;
/


-- Ex 8
create or replace package verif_pkg is
    procedure valid_comb(cod_job in employees.job_id%type, cod_dept in employees.department_id%type);
end;
/

create or replace package body verif_pkg
is
    procedure valid_comb(cod_job employees.job_id%type, cod_dept employees.department_id%type)
    is
        v_count number := 0;
    begin
        select count(*) into v_count
        from employees
        where department_id = cod_dept and job_id = cod_job;
        
        if v_count > 0 then
            dbms_output.put_line('Combinatie valida!');
        else
            dbms_output.put_line('Invalid!');
        end if;
    exception
        when no_data_found then
            dbms_output.put_line('INVALID!');
    end;
end;
/


select distinct department_id, job_id from employees;

set serveroutput on;

begin
    verif_pkg.valid_comb('SA_REP', 10);
end;
/


-- DBMS_OUTPUT
-- Ex 9
declare
    linie varchar2(255);
    stare number;
    nume employees.last_name%type;
    salariu employees.salary%type;
    dept employees.department_id%type;
begin
    select last_name, salary, department_id into nume, salariu, dept
    from employees
    where employee_id = 145;
    
    dbms_output.put_line(nume || ' ' || salariu || ' ' || dept);
    dbms_output.get_line(linie, stare);
    dbms_output.new_line();
    dbms_output.put_line(linie || ' ' || stare);
end;
/


-- DBMS_JOB
-- Ex 10

-- a)
variable num_job number
begin
    dbms_job.submit(
        job => :num_job, -- returneaza numarul jobului, printr-o variabila de leg
        what => 'verif_pkg.valid_comb(''SA_MAN'', 20);',  -- codul ce va fi executat (ce adaugam in coada)
        next_date => sysdate + 1/288,
        interval => 'trunc(sysdate + 1)');
    commit;
end;
/

print num_job

-- b)
select job, next_date, what
from user_jobs;

-- c)
BEGIN
    dbms_job.run(job => 593);
END;
/

-- d)
begin
    dbms_job.remove(job => 593);
end;
/

select job, next_date, what
from user_jobs;


-- UTL_FILE
-- Ex 11
create or replace procedure emp_report (p_dir in varchar2, p_filename in varchar2)
is
    v_file utl_file.file_type;
    cursor avg_csr is
    select last_name, department_id, salary
    from employees e
    where salary > (SELECT AVG(salary)
                    from employees
                    group by e.department_id)
    order by department_id;
begin
    v_file := utl_file.fopen(p_dir, p_filename, 'w');
    utl_file.put_line(v_file, 'Angajati care castiga mai mult decat salariul mediu:');
    utl_file.put_line(v_file, 'Raport generat la date de '|| SYSDATE);
    utl_file.new_line(v_file);
    
    for emp in avg_csr loop
        utl_file.put_line(v_file, rpad(emp.last_name, 30) || ' ' ||
                                  lpad(nvl(to_char(emp.department_id, '9999'), '-'), 5) || 
                                  ' ' || lpad(to_char(emp.salary, '$99,999.00'), 12));
    end loop;
    utl_file.new_line(v_file);
    utl_file.put_line(v_file, '***Sfârsitul raportului ***');
    utl_file.fclose(v_file);
end;
/


-- SQL DINAMIC, DBMS_SQL
-- Ex 12
create or replace procedure deleteFromTable(numeTabel in varchar2, nrLinii out number) 
is
    nume_cursor number;
begin
    nume_cursor := dbms_sql.open_cursor;
    dbms_sql.parse(nume_cursor, 'delete from ' || numeTabel, dbms_sql.v7);
    nrLinii := dbms_sql.execute(nume_cursor);
    dbms_sql.close_cursor(nume_cursor);
end;
/

variable linii_sterse number
execute deleteFromTable ('emp', :linii_sterse)
rollback;
print linii_sterse

select * from emp;

-- Ex 13
create or replace package table_pkg is
    PROCEDURE make(table_name VARCHAR2, col_specs VARCHAR2);
    PROCEDURE add_row(table_name VARCHAR2, col_values VARCHAR2, cols VARCHAR2 := null);
    PROCEDURE upd_row(table_name VARCHAR2, set_values VARCHAR2, conditions VARCHAR2 := NULL);
    PROCEDURE del_row(table_name VARCHAR2, conditions VARCHAR2 := NULL);
    PROCEDURE remove_tab(table_name VARCHAR2);
end;
/

create or replace package body table_pkg IS
    procedure execute (stmt VARCHAR2)
    IS
    BEGIN
        Dbms_output.put_line(stmt);
        Execute immediate stmt;
    END;
    
    PROCEDURE make(table_name VARCHAR2, col_specs VARCHAR2)
    IS
        stmt VARCHAR2(200) := 'CREATE TABLE '||table_name||' ('||col_specs ||')';
    BEGIN
        EXECUTE(stmt);
    END;
    
    PROCEDURE add_row(table_name VARCHAR2, col_values VARCHAR2, cols VARCHAR2 := null)
    IS
        stmt VARCHAR2(200) := 'INSERT INTO'||table_name;
    BEGIN
        IF cols IS NOT NULL THEN
            stmt := stmt ||' (' ||cols||')';
        END IF;
        stmt := stmt || ' VALUES(' || col_values || ')';
        execute(stmt);
    END;
    
    PROCEDURE upd_row(table_name VARCHAR2, set_values VARCHAR2, conditions VARCHAR2 := NULL)
    IS
        stmt VARCHAR2(200) := 'UPDATE '||table_name || ' SET ' ||set_values;
    BEGIN
        IF conditions IS NOT NULL THEN
            stmt := stmt || ' WHERE ' || conditions ;
        END IF;
        execute(stmt);
    END;
    
    PROCEDURE del_row(table_name VARCHAR2, conditions VARCHAR2 := NULL)
    IS
        stmt VARCHAR2(200) := 'DELETE FROM '||table_name;
    BEGIN
        IF conditions IS NOT NULL THEN
            stmt := stmt || ' WHERE ' || conditions ;
        END IF;
        execute(stmt);
    END;
    
    PROCEDURE remove_tab(table_name VARCHAR2)
    IS
        csr_id INTEGER;
        stmt VARCHAR2(100) := 'DROP TABLE '||table_name;
    BEGIN
        csr_id := DBMS_SQL.OPEN_CURSOR;
        DBMS_OUTPUT.PUT_LINE(stmt);
        DBMS_SQL.PARSE(csr_id, stmt, DBMS_SQL.NATIVE);
        DBMS_SQL.CLOSE_CURSOR(csr_id);
    END;
END table_pkg;
/








