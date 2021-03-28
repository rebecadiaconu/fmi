-- Laborator 2 COMPLET

-- Exercitii VIZUALIZARI

DROP TABLE students CASCADE CONSTRAINTS
/
 
 
CREATE TABLE students (
  id INT NOT NULL PRIMARY KEY,
  registration_number VARCHAR2(6) NOT NULL,
  lname VARCHAR2(15) NOT NULL,
  fname VARCHAR2(30) NOT NULL,
  year NUMBER(1),
  groupno CHAR(2),
  scholarship NUMBER(6,2),
  dob DATE,
  email VARCHAR2(40),
  created_at DATE,
  updated_at DATE
)
/
 
SET SERVEROUTPUT ON;
DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_lname varr := varr('Morrison','Bennett','Brady','Coleman','Ford','Rios','Poole','Walters','Guerrero','Flores','Lee','Miller','Francis','French','Martin','Sherman','Graham','Garner','Maxwell','Estrada','Morales','Owen','Lawson','Benson','Hammond','Greene','Lamb','Castro','Perkins','Hughes','Barnes','Mckenzie','Watts','Anderson','Gregory','Alvarez','Yates','Fowler','Wilkins','Warren','Burns','Boone','Goodwin','Porter','Wheeler','Brock','Howard','Barton','Zimmerman','Hodges','Massey','Norton','Gibson','Strickland','Bell','Robinson','Graves','Craig','Howell','Hunt','Malone','Richards','Murphy','Nash','West','Lloyd','Paul','Fuller','Holloway','Goodman','Ryan','Reeves','Cole','Parker','Cohen','Ingram','Scott','Byrd','Hart','Casey','Franklin','Morgan','Mclaughlin','Lyons','Montgomery','Stephens','Glover','Roberts','Erickson','Allison','Ramos','Holland','Hawkins','Williamson','Edwards','Mccoy','Swanson','Delgado','Ellis','Collins','Boyd','Myers','Nichols','Wood','Rice','Wolfe','Stokes','Ortiz','Haynes','Mccormick','Norman','Knight','Patton','Gomez','Chandler','Henry','Tucker','Kennedy','Day','Gray','Banks','Allen','Clark','Reed','Oliver','Price','Simon','Fox','Copeland','Harrington','Brooks','Ruiz','Taylor','Griffith','Jordan','Ballard','Clarke','Kelley','Waters','Russell','Luna','Becker','Nguyen','Norris','Munoz','Wilson','Todd','Olson','George','Rivera','Williams','White','Torres','Brewer','Mendoza','Alexander','Joseph','Mason','Webster','Higgins','Barnett','Harrison','Bailey','Underwood','Robertson','Watkins','Stone','Quinn','Hicks','Holt','Burgess','Hoffman','Adams','Stevens','Chavez','Wilkerson','Bryan','Sandoval','Greer','Soto','Walsh','Wagner','Vega','Schmidt','Figueroa','Thornton','Diaz','Hamilton','Peters','Sims','Duncan','Rhodes','Carter','Alvarado','Powell','Burton','Osborne','Blake','Palmer','Moore','Dawson','Henderson','Lowe','Peterson','Sanders','Shelton','Lopez','Mckinney','Ferguson','Pierce','Neal','Abbott','Keller','Silva','Stewart','Griffin','Lynch','Bush','Nelson','Townsend','Butler','Webb','Spencer','Mack','Frazier','Gutierrez','Moody','Carroll','Bowman','Little','Guzman','Martinez','Larson','Clayton','Perez','Colon','Daniel','Adkins','Turner','Smith','Tate','Mccarthy','Douglas','Riley','Mills','Briggs','Collier','Perry','Murray','Mullins','Vasquez','Wright','Pearson','Cooper','Lewis','Foster','Mann','Santiago','Santos','Cain','Rodgers','Lambert','Fitzgerald','Hudson','Fletcher','Jennings','Schultz','Bowen','Schwartz','Rose','Hopkins','Doyle','Carr','Saunders','Meyer','Cruz','Roy','Baker','Simpson','Valdez','Newton','Caldwell','Parks','Obrien','Johnson','Weaver','Steele','Thomas','Fisher','Walker','Johnston','Grant','Watson','Reid','Gill','Carson','Simmons','Barrett','Holmes','Wells','Mcdonald','Garza','Cook','Bridges','Cox','Leonard','Klein','Lawrence','Rowe','Jackson','Aguilar','Willis','Harmon','Long','Davis','Summers','Davidson','Baldwin','Harper','Patrick','Sanchez','Gonzalez','Lindsey','Miles','Wise','Roberson','Bass','Mcgee','Powers','Richardson','Nunez','Hogan','Gordon','Singleton','Harvey','Wade','Welch','Kelly','Houston','Sutton','Love','Bradley','Jimenez','Floyd','Ortega','Black','Ball','Crawford','Bowers','Hernandez','Tran','Brown','Armstrong','Gilbert','Cummings','Snyder','Hayes','Padilla','Dixon','Hampton','Mathis','Medina','Jenkins','Hill','Jacobs','King','Jefferson','Conner','Chapman','Terry','Christensen','Maldonado','Stanley','Gardner','Fields','Ward','Hunter','Ross','Cannon','Sharp','Manning','Newman','Mitchell','Morris','Morton','Hansen','Ramsey','Garcia','Moss','Vargas','Hale','Wallace','Dennis','Fernandez','Thompson','Huff','Park','Walton','Kim','Chambers');
  lista_fname_fete varr := varr('Bonnie','Louise','Janet','Anna','Jane','Ruth','Ashley','Tina','Joyce','Stephanie','Laura','Virginia','Alice','Margaret','Lori','Sharon','Anne','Emily','Andrea','Elizabeth','Sarah','Rebecca','Ann','Brenda','Jessica','Paula','Jennifer','Diana','Cheryl','Lois','Teresa','Susan','Evelyn','Karen','Wanda','Gloria','Carol','Nicole','Phyllis','Martha','Carolyn','Denise','Heather','Theresa','Marie','Sara','Doris','Cynthia','Joan','Sandra','Kathryn','Julie','Mildred','Jacqueline','Donna','Rose','Dorothy','Debra','Rachel','Diane','Irene','Helen','Jean','Lillian','Patricia','Norma','Kelly','Janice','Frances','Annie','Christine','Michelle','Beverly','Catherine','Melissa','Judith','Lisa','Pamela','Tammy','Kathy','Deborah','Linda','Judy','Kathleen','Angela','Christina','Katherine','Marilyn','Shirley','Maria','Ruby','Mary','Kimberly','Barbara','Nancy','Betty','Amy','Julia','Amanda');
  lista_fname_baieti varr := varr('Alonzo','Lorenzo','Tommy','Levi','Dustin','Angelo','Matthew','Johnny','Andres','Jeffrey','Samuel','Alberto','Leland','Wallace','Loren','Gustavo','Virgil','Dale','Jaime','Gerard','Carlos','Jason','Roy','Harvey','Willard','Rick','Stuart','Cody','Eduardo','Gerardo','Curtis','Aubrey','Sammy','Gene','Toby','Winston','Tony','Charlie','Wm','Joseph','Marty','Johnnie','Earl','Brad','Jonathan','Rex','Cornelius','Eddie','Cesar','Keith','Louis','Micheal','Nicholas','Dwight','Dave','Rodolfo','Warren','Raymond','Shannon','Emmett','George','Moses','Preston','Guillermo','Andrew','Ignacio','Leslie','Ian','Kirk','Amos','Bert','Ronnie','Timmy','Manuel','Tim','Gregory','Mario','Earnest','Luis','Lawrence','Eric','Miguel','Rudy','Albert','Wayne','Colin','Larry','Israel','Salvador','Jorge','Thomas','Alton','Pat','Malcolm','Randolph','Nicolas','Marshall','Francis','Tyrone','Lewis');
  lista_materii_year_1 varr := varr('Logic in Informatics','Mathematics','Introduction to Programming','Computer Architecture and Operating Systems','Operating Systems','Object-Oriented Programming','Fundamental Algebraic of Information','Probabilities and Statistics');
  lista_materii_year_2 varr := varr('Computer Networks','Data Basis','Formal Languages, Automata and Compilers','Graph Algorithms','Web Technologies','Advanced Programming','Software Engineering','DBMS Practice');
  lista_materii_year_3 varr := varr('Automated Learning','Network Security','Artificial Intelligence','Python Programming','Numeric Calculus','Computer graphics','Data Mining','Petri networks and their applications');
  lista_grade_diactice varr := varr('Colaborator','Assistant Lecturer','Lecturer','Associate Professor','Professor');
     
  v_lname VARCHAR2(255);
  v_fname VARCHAR2(255);
  v_fname1 VARCHAR2(255);
  v_fname2 VARCHAR2(255);
  v_matr VARCHAR2(6);
  v_matr_aux VARCHAR2(6);
  v_temp int;
  v_temp1 int;
  v_temp2 int;
  v_temp3 int;
  v_temp_date date;
  v_year int;
  v_groupno varchar2(2);
  v_scholarship int;
  v_dob date;  
  v_email varchar2(40);
BEGIN
 
   DBMS_OUTPUT.PUT_LINE('Adding 102 students...');
   FOR v_i IN 1..102 LOOP
      v_lname := lista_lname(TRUNC(DBMS_RANDOM.VALUE(0,lista_lname.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_fname1 := lista_fname_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_fete.count))+1);
         LOOP
            v_fname2 := lista_fname_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_fete.count))+1);
            exit when v_fname1<>v_fname2;
         END LOOP;
       ELSE
         v_fname1 := lista_fname_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_baieti.count))+1);
         LOOP
            v_fname2 := lista_fname_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_fname_baieti.count))+1);
            exit when v_fname1<>v_fname2;
         END LOOP;      
       END IF;
     
     IF (DBMS_RANDOM.VALUE(0,100)<60) THEN  
        IF LENGTH(v_fname1 || ' ' || v_fname2) <= 20 THEN
          v_fname := v_fname1 || ' ' || v_fname2;
        END IF;
        else
           v_fname:=v_fname1;
      END IF;      
       
      LOOP
         v_matr := FLOOR(DBMS_RANDOM.VALUE(100,999)) || CHR(FLOOR(DBMS_RANDOM.VALUE(65,91))) || CHR(FLOOR(DBMS_RANDOM.VALUE(65,91))) || FLOOR(DBMS_RANDOM.VALUE(0,9));
         select count(*) into v_temp from students where registration_number = v_matr;
         exit when v_temp=0;
      END LOOP;
             
      LOOP      
        v_year := TRUNC(DBMS_RANDOM.VALUE(0,3))+1;
        v_groupno := chr(TRUNC(DBMS_RANDOM.VALUE(0,2))+65) || chr(TRUNC(DBMS_RANDOM.VALUE(0,6))+49);
        select count(*) into v_temp from students where year=v_year and groupno=v_groupno;
        exit when v_temp < 30;
      END LOOP;
     
      v_scholarship := '';
      IF (DBMS_RANDOM.VALUE(0,100)<10) THEN
         v_scholarship := TRUNC(DBMS_RANDOM.VALUE(0,10))*100 + 500;
      END IF;
     
      v_dob := TO_DATE('01-01-1974','MM-DD-YYYY')+TRUNC(DBMS_RANDOM.VALUE(0,365));
     
      v_temp:='';
      v_email := lower(v_lname ||'.'|| v_fname1);
      LOOP        
         select count(*) into v_temp from students where email = v_email||v_temp;
         exit when v_temp=0;
         v_temp :=  TRUNC(DBMS_RANDOM.VALUE(0,100));
      END LOOP;    
     
      if (TRUNC(DBMS_RANDOM.VALUE(0,2))=0) then v_email := v_email ||'@gmail.com';
         else v_email := v_email ||'@info.ro';
      end if;
                     
      DBMS_OUTPUT.PUT_LINE (v_i||' '||v_matr||' '||v_lname||' '||v_fname ||' '|| v_year ||' '|| v_groupno||' '|| v_scholarship||' '|| to_char(v_dob, 'DD-MM-YYYY')||' '|| v_email);      
      insert into students values(v_i, v_matr, v_lname, v_fname, v_year, v_groupno, v_scholarship, v_dob, v_email, sysdate, sysdate);
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('done !');
END;
/
 
select * from students;


-- Ex 1
create or replace view students_view as select * from students where scholarship > 1350 with check option;


-- Ex 2
update students set scholarship = 1400 where id = 1;
update students set scholarship = 1200 where id = 1;


-- Ex 3
update students_view set scholarship = 1400 where id = 1;
update students_view set scholarship = 1200 where id = 1;

select * from students_view;


-- Ex 4
insert into students_view values(1998,'123AB1','f1','l1',3,'B1',200,sysdate, 'aaa@gmail.com',
sysdate, sysdate);

insert into students_view values(1999,'123AB2','f2','l2',2,'B2',1400,sysdate, 'abc@gmail.com',
sysdate, sysdate);


-- Ex5
delete from students_view where id > 1997; 
delete from students where id > 1997; 


-- Ex 6
create or replace view students_view2 as select fname, lname, scholarship from students;

insert into students_view2 values ('Ababa', 'Bababa', 1500);


-- Exercitii SECVENTE
create sequence dept_seq
increment by 10
start with 200
maxvalue 10000
nocycle
nocache;

select * from all_sequences;

select dept_seq.nextval from dual;


-- Exercitii Indecsi
select index_name, index_type, visibility, status
from all_indexes
where table_name = 'EMPLOYEES';

create index employees_lname_index
on employees (last_name);

explain plan for 
select employee_id, last_name
from employees
where last_name = 'King'; 

select plan_table_output
from table(dbms_xplan.display());

drop index employees_lname_index;


-- Exercitii Variabile de Substitutie
define p_cod;  -- trebuia sa afiseze inform despre variab p_cod, dar ea nu exista
select employee_id, last_name, salary, department_id
from employees
where employee_id = &p_cod;
undefine p_cod;

define p_cod = 100;
select employee_id, last_name, salary, department_id
from employees
where employee_id = &&p_cod;
undefine p_cod;

accept p_cod prompt 'cod = ?';
select employee_id, last_name, salary, department_id
from employees
where employee_id = &p_cod;


-- Exercitii Tabele Temporare
create global temporary table temp_table_333 (
    id number,
    description varchar2(20)
)
on commit preserve rows;

select * from temp_table_333;

insert into temp_table_333 values (1, 'one');

-- cate elemente avem in tabel
select count(*)
from temp_table_333;

commit;
select count(*)
from temp_table_333;

drop table temp_table_333 purge;


-- Session ID
select sys_context('USERENV','SID') 
from dual; 

select sid 
from v$mystat 
where rownum <=1; 

select to_number(substr(dbms_session.unique_session_id,1,4),'XXXX') mysid 
from dual;  

select distinct sid 
from v$mystat; 


-- Introducere in PL/SQL
-- Ex 1
set serveroutput on;

declare
    v_text varchar2(30) := '&textul_de_afisat';
begin
    dbms_output.put_line(v_text);
end;
/


-- Ex 2
declare
    v_nr1 number(4, 2) := &nr1;
    v_nr2 number(4, 2) := &nr2;
    v_suma number(5, 2) := 0;
begin
    v_suma := v_nr1 + v_nr2;
    dbms_output.put_line(v_suma);
end;
/


-- Ex 3
declare
    v_nr1 number(4, 2) := &nr1;
    v_nr2 number(4, 2) := &nr2;
    v_rez number(5, 2) := 0;
begin
    if v_nr2 = 0 then 
        v_rez := v_nr1 * v_nr1;
    else
        v_rez := (v_nr1 / v_nr2) + v_nr2;
    end if; 
    dbms_output.put_line(v_rez);
end;
/


-- Ex 4
declare
    v_job_id varchar2(20) := '&job_majuscule';
    v_suma_salarii number(8, 2) := 0;
begin
    select sum(salary) into v_suma_salarii
    from employees
    where job_id = v_job_id;
    
    if v_suma_salarii > 0 then
        dbms_output.put_line(v_suma_salarii);
    else
        dbms_output.put_line('Niciun angajat cu acest job!');
    end if;
end;
/

select distinct job_id
from employees;


-- Exemplu afisare variabile in PL/SQL
variable g_var number 
exec :g_var := 30 
print g_var 
define p_var = 'Variabila de substitutie' 

DECLARE  
    var1 INTEGER := 35;  
    var2 varchar2(20) := 'Variabila pl/sql';  
BEGIN  
    dbms_output.put_line(var1);   
    dbms_output.put_line(var2);   
    dbms_output.put_line(:g_var);   
    dbms_output.put_line('&p_var');      
END;  
/





