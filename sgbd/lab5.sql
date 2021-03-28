-- LABORATOR 5 COMPLET (LAB 2 DAT DE EA)

-- exemplu cu bulk collect
declare
    type v_all is table of emp_inreg;
    v_all_rec v_all := v_all();
begin
    delete from emp 
    where department_id = 60 
    RETURNING emp_inreg(employee_id, first_name, salary, department_id) 
    bulk collect into v_all_rec; 
    for i in v_all_rec.first..v_all_rec.last loop 
         DBMS_OUTPUT.put_line(v_all_rec(i).cod_emp || ' ' || v_all_rec(i).lname || ' ' || v_all_rec(i).salariu || ' ' || v_all_rec(i).cod_dept); 
    end loop; 
end; 
rollback; 

-- EXERCITII CU RECORD

-- Ex 1
set serveroutput on;

-- var cu OBJECT
create type emp_inreg is object 
(
    cod_emp number,
    lname varchar2(25),    
    salariu varchar2(25),
    cod_dept number
);

declare
    v_rec emp_inreg;
begin
    delete from emp where employee_id = 201
    returning emp_inreg(employee_id, last_name, salary, department_id) into v_rec;
    dbms_output.put_line(v_rec.cod_emp || ' ' || v_rec.lname || ' ' || v_rec.salariu || ' ' ||v_rec.cod_dept);
end;
/

rollback;

-- var cu RECORD
declare
    type emp_inreg2 is record 
    (
        cod_emp number,
        lname varchar2(25),    
        salariu varchar2(25),
        cod_dept number
    );
    v_rec emp_inreg2;
begin
    delete from emp where employee_id = 201
    returning employee_id, last_name, salary, department_id into v_rec;
    dbms_output.put_line(v_rec.cod_emp || ' ' || v_rec.lname || ' ' || v_rec.salariu || ' ' ||v_rec.cod_dept);
end;
/

rollback;

-- Ex 2
set serveroutput on;

declare
    type emp_nou is record (
        cod emp.employee_id%type := 500,
        fname emp.first_name%type := 'Rebeca',
        lname emp.last_name%type := 'Matei',
        email emp.email%type := 'abc@gmail.com',
        phone emp.phone_number%type,
        hireDate emp.hire_date%type :=sysdate,
        cod_job emp.job_id%type := 'IT_PROG',
        salariu emp.salary%type := '4200',
        comision emp.commission_pct%type,
        manager emp.manager_id%type,
        dept emp.department_id%type := 30
    );
    v_emp emp_nou;    
begin
    
    insert into emp values v_emp;
    if sql%rowcount = 1 then
        dbms_output.put_line('Inserare reusita!');
    end if;
    
    v_emp.lname := 'Diaconu';
    v_emp.email := 'rebeca.diaconu@gmail.com';
    
    update emp
    set row = v_emp where employee_id = v_emp.cod;
    
    if sql%rowcount = 1 then
        dbms_output.put_line('Modificare reusita!');
    end if;
end;
/

rollback;

select * from emp where employee_id = 500;


-- Exemple colectii
declare
    type tab_index is table of number 
    index by binary_integer;
    type tab_imbri is table of number;
    type vector is varray(5) of number;
    
    v_tab_index tab_index;
    v_tab_imbri tab_imbri;
    v_vector vector;
    i number;
    j number;
    k number;
begin
    v_tab_index(1) := 72;
    v_tab_index(2) := 23;
    v_tab_imbri := tab_imbri(5, 3, 2, 8, 7);
    v_vector := vector(1, 2);
    
    i := v_tab_index.first;
    while i <= v_tab_index.last loop
        dbms_output.put_line(v_tab_index(i));
        i := v_tab_index.next(i);
    end loop;
    
    j := v_tab_imbri.first;
    while j <= v_tab_imbri.last loop
        dbms_output.put_line(v_tab_imbri(j));
        j := v_tab_imbri.next(j);
    end loop;
    
    k := v_vector.first;
    while k <= v_vector.last loop
        dbms_output.put_line(v_vector(k));
        k := v_vector.next(k);
    end loop;
end;
/


-- EXERCITII TABLOU INDEXAT

set serveroutput on;

-- Ex 4
declare
    type tab_index is table of number
    index by binary_integer;
    
    v_index tab_index;
    v_aux tab_index; ---- tablou folosit pt stergere
begin
    for v_i in 1..20 loop
        v_index(v_i) := v_i * 2;
    end loop;
    
    for i in v_index.first..v_index.last loop
        dbms_output.put_line(v_index(i));
        v_index(i) := null;    -- metoda 1 de stergere
    end loop;
    
    v_index := v_aux; -- metoda 2 de stergere
    
    v_index.delete; -- metoda 3 de stergere
    DBMS_OUTPUT.PUT_LINE('tabloul are ' || v_index.COUNT || ' elemente');      
end;
/
 set serveroutput on;


-- Ex 5
declare
    type inreg_dept is table of dept%rowtype
    index by binary_integer;
    
    tab_nou inreg_dept;
begin
    tab_nou(1).department_id := 300;
    tab_nou(1).department_name := 'Contabilitate';
    tab_nou(1).manager_id := 100;
    tab_nou(1).location_id := 1501;
    tab_nou(1).informatii := null;
    
    insert into dept values (tab_nou(1).department_id, tab_nou(1).department_name, tab_nou(1).manager_id, tab_nou(1).location_id, tab_nou(1).informatii);
    -- sau insert into dept values tab_nou(1);
    tab_nou.delete;
end;
/

select * from dept where department_id = 300;


-- Ex 6
DECLARE
    TYPE secventa IS VARRAY(5) OF VARCHAR2(10);
    v_sec secventa := secventa ('alb', 'negru', 'rosu','verde');
BEGIN
     v_sec (3) := 'rosu';
     v_sec.EXTEND; -- adauga un element null
     v_sec(5) := 'albastru';
     -- extinderea la 6 elemente va genera eroarea ORA-06532
--     v_sec.EXTEND;
     
     for i in v_sec.first..v_sec.last loop
        dbms_output.put_line(i || ' ' || v_sec(i));
     end loop;
END; 
/


-- Ex 7
create type proiect is varray(50) of varchar2(15);
create table testul (
    cod_ang number(4),
    proiecte_alocate proiect
); 

declare
    v_pr proiect := proiect('aaaa', 'bbbbb', 'matematica', 'analiza');
begin
    insert into testul values (100, v_pr);
end;
/

select * from testul;


-- Ex 8

-- var 1
declare
    type cod_dept is varray(50) of number(6);
    v_ang cod_dept := cod_dept();
begin
    select employee_id bulk collect into v_ang
    from emp
    where department_id = 50 and salary < 5000;
    
    forall i in v_ang.first..v_ang.last 
        update emp set salary = salary * 1.1 where employee_id = v_ang(i); 
end;
/

-- var 2
DECLARE
    TYPE t_id IS VARRAY(100) OF emp_pnu.employee_id%TYPE;
    v_id t_id := t_id();
BEGIN 
    FOR contor IN ( SELECT * FROM emp_pnu) LOOP 
        IF contor.department_id = 50 AND contor.salary < 5000 THEN
            v_id.extend;
            v_id(v_id.count) := contor.employee_id;
        END IF;
    END loop;
    
    FOR contor IN 1..v_id.count LOOP
        UPDATE emp_pnu SET salary = salary * 1.1
        WHERE employee_id = v_id(contor);
    END LOOP;
END;
/

select * from emp where department_id = 50 and salary < 5000;

rollback;


-- Ex 9
DECLARE
     TYPE CharTab IS TABLE OF CHAR(1);
     v_Characters CharTab := CharTab('M', 'a', 'd', 'a', 'm', ',', ' ', 'I', '''', 'm', ' ', 'A', 'd', 'a', 'm');
     v_Index INTEGER;
BEGIN
     v_Index := v_Characters.FIRST;
     
     WHILE v_Index <= v_Characters.LAST LOOP
        DBMS_OUTPUT.PUT(v_Characters(v_Index));
         v_Index := v_Characters.NEXT(v_Index);
     END LOOP;
     
     DBMS_OUTPUT.NEW_LINE;
     v_Index := v_Characters.LAST;
     
     WHILE v_Index >= v_Characters.FIRST LOOP
         DBMS_OUTPUT.PUT(v_Characters(v_Index));
         v_Index := v_Characters.PRIOR(v_Index);
     END LOOP;
     
     DBMS_OUTPUT.NEW_LINE;
END;
/ 

set serveroutput on;


-- Ex 10
create type numTab is table of number(6);

declare
    type indexTab is table of number(6)
    index by binary_integer;
    
    v_imb numTab := numTab(2, 3, 4, 5, 6, 7);
    v_ind indexTab;
    v_index binary_integer;
begin
    v_index := v_imb.first;
    loop
        if v_imb.exists(v_index) then 
            dbms_output.put_line(v_imb(v_index));
            v_ind(v_index) := v_imb(v_index);
            v_index := v_imb.next(v_index);
        else
            exit;
        end if;
    end loop;
    
    v_index := v_ind.count;
    loop
        if v_ind.exists(v_index) then 
            dbms_output.put_line(v_ind(v_index));
            v_index := v_ind.prior(v_index);
        else
            exit;
        end if;
    end loop;
end;
/


-- Ex 11
DECLARE
     TYPE alfa IS TABLE OF VARCHAR2(50);
     -- creeaza un tablou (atomic) null
     tab1 alfa ;
     /* creeaza un tablou cu un element care este null, dar
     tabloul nu este null, el este initializat, poate
     primi elemente */
     tab2 alfa := alfa() ;
BEGIN
     IF tab1 IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('tab1 este NULL');
     ELSE
        DBMS_OUTPUT.PUT_LINE('tab1 este NOT NULL');
     END IF;
     
     IF tab2 IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('tab2 este NULL');
     ELSE
        DBMS_OUTPUT.PUT_LINE('tab2 este NOT NULL');
     END IF;
END;
/ 


-- Ex 13
create type list_and is varray(10) of number(4);
create table job_emp (
    cod_job number(3),
    titlu_job varchar2(25),
    info list_ang
);

declare
    v_info job_emp.info%type;
    v_cod job_emp.cod_job%type;
    v1 list_ang := list_ang(1, 2, 3, 4, 17);
    v2 list_ang;
begin
    v2 := list_ang(11, 12, 15);
    insert into job_emp values (v1(1),'Job1', v1);
    
    v_cod := 30;
    insert into job_emp values(v_cod, 'Job2', v2);
    
    v_cod := 50;
    insert into job_emp values(v_cod, 'Job3', list_ang(1,2));
    
end;
/

select * from job_emp;


-- Ex 14
create type dateTabr is table of date;

create table famous_dates (
    date1 dateTabr
)
nested table date1 store as date_tab1;

declare
    v_date dateTabr := dateTabr('31-DEC-2000','02-MAY-1998', '12-JAN-2012', '31-MAR-2001', '14-SEP-1987');
begin
    v_date.delete(2);
    insert into famous_dates values(v_date);
end;
/

select * from famous_dates;


-- Ex 15
create type deptInfo is object (
    cod_ang number(6),
    job_id varchar2(20)
);
create type infoR is table of deptInfo;

-- adaugam o coloana noua de tipul info
alter table dept add info infoR nested table info store as info2;

declare
    v_cod_dept dept.department_id%type := &cod_dept;
    v_info infoR := infoR(deptInfo(1, 'Contabil'), deptInfo(2, 'Dansator'));
begin
    update dept set info = v_info where department_id = v_cod_dept;
    
    for i in v_info.first..v_info.last loop 
        dbms_output.put_line(v_info(i).cod_ang || ' '  || v_info(i).job_id); 
    end loop; 
end;
/


-- Ex 16
create global temporary table temp_table (
    c_num number(8),
    c_chr varchar2(30)
); 

create type ind_rec is object (
    c_num_ind number(8),
    c_chr_ind varchar2(30)
);

declare
    type table_index is table of ind_rec
    index by binary_integer;
    
    v_tab table_index;
    v_i ind_rec;
begin
    for i in 1..500 loop
        v_i := ind_rec(i, 'a' || to_char(i));
        v_tab(i):= v_i;
    end loop;
    
    forall i in v_tab.first..v_tab.last
        insert into temp_table values(v_tab(i).c_num_ind, v_tab(i).c_chr_ind);
end;
/

select * from temp_table;


-- Ex 17
set serveroutput on;

declare
    v_newRow rowid;
    v_nume emp.last_name%type;
    v_prenume emp.first_name%type;
    v_id emp.employee_id%type;
begin
    insert into emp (employee_id, first_name, last_name, email, hire_date, job_id, salary)
    values (450, 'John', 'Bae', 'aaa@gmail.com', sysdate, 10, 1200)
    returning rowid into v_newRow;
    
    dbms_output.put_line('Linia noua inserata are rowid-ul: ' || v_newRow);
    
    update emp set salary = salary * 1.3
    where rowid = v_newRow
    returning last_name, first_name into v_nume, v_prenume;
    dbms_output.put_line('Numele angajatului este ' || v_nume || ' ' || v_prenume);
    
    delete from emp where rowid = v_newRow
    returning employee_id into v_id;
    
    dbms_output.put_line('Id-ul angajatului tocmai sters este ' || v_id);
end;
/


-- Ex 18
set serveroutput on;

declare
    type t_numbers is table of number(8)
    index by binary_integer;
    
    type t_multinumbers is table of t_numbers
    index by binary_integer;
    
    type t_multivarray is varray(100) of t_numbers;
    
    type t_multinested is table of t_numbers;
    
    v_num t_numbers;
    v_multinum t_multinumbers;
    v_arr t_multivarray;
    v_nested t_multinested := t_multinested();
    
    v_index binary_integer := 1;
begin
    v_num(v_index) := 15;
    v_index := v_index + 1;
    v_num(v_index) := -3;
    for i in v_num.first..v_num.last loop
        dbms_output.put_line('T_NUM ' || v_num(i));
    end loop;
    
    v_multinum(1)(1) := 2;
    v_multinum(1)(2) := -11;
    v_multinum(2)(1) := 17;
    for i in v_multinum.first..v_multinum.last loop
        dbms_output.put_line('MULTINUM ' || i);
        for j in v_multinum(i).first..v_multinum(i).last loop
            dbms_output.put_line(v_multinum(i)(j));
        end loop;
    end loop;
    
    v_arr := t_multivarray(v_num);
    v_index := v_arr.count + 1;
    v_arr.extend(2);
    for i in v_multinum.first..v_multinum.last loop
        v_arr(v_index) := v_multinum(i);
        v_index := v_index + 1;
    end loop;
        
    for i in v_arr.first..v_arr.last loop
        dbms_output.put_line('VARRAY ' || i);
        for j in v_arr(i).first..v_arr(i).last loop
            dbms_output.put_line(v_arr(i)(j));
        end loop;
    end loop;
    
    v_nested := t_multinested(v_num);
    for i in v_nested.first..v_nested.last loop
        dbms_output.put_line('NESTED ' || i);
        for j in v_nested(i).first..v_nested(i).last loop
            dbms_output.put_line(v_nested(i)(j));
        end loop;
    end loop;
end;
/


-- Ex 19
declare
    type empTab is table of emp%rowtype;
    
    v_emp empTab := empTab(); 
begin
    v_emp.extend(1);
    v_emp(1).employee_id := 601;
    v_emp(1).first_name := 'Rebi';
    v_emp(1).last_name := 'Diaconu';
    v_emp(1).email := 'aav@yahoo.com';
    v_emp(1).phone_number := '012567893456';
    v_emp(1).hire_date := sysdate;
    v_emp(1).job_id := 'IT_PROG';
    v_emp(1).salary := 5800;
    v_emp(1).commission_pct := 0.3;
    v_emp(1).manager_id := null;
    v_emp(1).department_id := null;
    
    insert into emp values v_emp(1);
    if sql%rowcount = 1 then
        dbms_output.put_line('Linie inserata!');
    end if;
end;
/


-- Ex 20
declare
    type EmpRow is table of emp%rowtype;
    type EmpTab is table of EmpRow
    index by binary_integer;
    
    v_emp EmpTab;
begin
    v_emp(1) := EmpRow();
    v_emp(1).extend();
    
    select * into v_emp(1)(1)
    from emp
    where employee_id = 100;
    
    v_emp(1).extend();
    v_emp(1)(2).first_name := 'wtf';
    v_emp(1)(2).last_name := 'man';
    
    dbms_output.put_line(v_emp(1)(1).employee_id);
    dbms_output.put_line(v_emp(1)(2).first_name);
    dbms_output.put_line(v_emp(1)(2).last_name);
end;
/












