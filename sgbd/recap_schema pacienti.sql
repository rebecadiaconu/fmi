drop table trateaza;
drop table pacienti;
drop table personal cascade constraints;
drop table specializare;
drop table functii;

CREATE TABLE functii
    ( id_functie     NUMBER(4)
    , nume_functie   VARCHAR2(20) NOT NULL
    , salariu_minim    NUMBER(6) NOT NULL
    , salariu_maxim    NUMBER(6) NOT NULL
    , CONSTRAINT     prk_functie 
        	     PRIMARY KEY (id_functie) 
    ) ;
    
    
CREATE TABLE specializare
    ( id_specializare     NUMBER(4)
    , nume_specializare   VARCHAR2(50) NOT NULL
    , id_manager    number(4)
    , CONSTRAINT     prk_specializare
        	     PRIMARY KEY (id_specializare) 
    ) ;
    
    
CREATE TABLE personal
    ( id_salariat     NUMBER(4)
    , nume   VARCHAR2(50) NOT NULL
    , prenume   VARCHAR2(50) NOT NULL
    , adresa    VARCHAR2(50)
    , data_nastere date
    , salariu NUMBER(6) NOT NULL
    , ID_functie NUMBER(4) NOT NULL
    , ID_specializare NUMBER(4) NOT NULL
    , CONSTRAINT     prk_personal
        	     PRIMARY KEY (id_salariat) 
    ) ;
    
CREATE TABLE pacienti
      (id_pacient NUMBER(4)
      , nume   VARCHAR2(50) NOT NULL
      , prenume   VARCHAR2(50) NOT NULL
      , data_nastere date
	  , CONSTRAINT     prk_pacienti
        	     PRIMARY KEY (id_pacient)
      );
      
CREATE TABLE trateaza
      (id_salariat NUMBER(4) constraint fk_personal references personal(id_salariat)
      , id_pacient NUMBER(4) constraint fk_pacient references pacienti(id_pacient)
      , data_internare date
      , data_externare date
      , CONSTRAINT     prk_trateaza
        	     PRIMARY KEY (id_salariat, id_pacient, data_internare) 
      );
    
ALTER TABLE personal
ADD ( CONSTRAINT fkk_pers_funct
        	 FOREIGN KEY (ID_functie)
          	  REFERENCES functii(ID_functie) 
    ) ;
    
    
ALTER TABLE personal
ADD ( CONSTRAINT fkk_pers_spec
        	 FOREIGN KEY (ID_specializare)
          	  REFERENCES specializare(ID_specializare) 
    ) ;
    
alter table specializare 
add (constraint fkk_spec_pers foreign key(id_manager) references personal(id_salariat)); 


INSERT INTO functii VALUES (1, 'asistenta', 1000, 2000);
INSERT INTO functii VALUES (2, 'radiolog', 1200, 2200);
INSERT INTO functii VALUES (3, 'anestezist', 1500, 2500);
INSERT INTO functii VALUES (4, 'laborant', 1700, 2700);
INSERT INTO functii VALUES (5, 'medic', 2000, 3000);
INSERT INTO functii VALUES (6, 'medic specialist', 2300, 3500);
INSERT INTO functii VALUES (7, 'diagnostician', 3000, 5000);
INSERT INTO functii VALUES (8, 'chirurg', 2500, 4000);

alter table specializare disable constraint fkk_spec_pers;

INSERT INTO specializare VALUES (1, 'Alergologie', 1);
INSERT INTO specializare VALUES (2, 'Boli Infectioase', 8);
INSERT INTO specializare VALUES (3, 'Cardiologie', 18);
INSERT INTO specializare VALUES (4, 'Neurologie', 25);
INSERT INTO specializare VALUES (5, 'Psihiatrie', 30);
INSERT INTO specializare VALUES (6, 'Oncologie', 36);
INSERT INTO specializare VALUES (7, 'Reumatologie', 40);
INSERT INTO specializare VALUES (8, 'Terapie Intensiva', 45);
INSERT INTO specializare VALUES (9, 'Chirurgie Generala', 56);
INSERT INTO specializare VALUES (10, 'Chirurgie Cardiovasculara', 58);
INSERT INTO specializare VALUES (11, 'Chirurgie Plastica', 65);
INSERT INTO specializare VALUES (12, 'Chirurgie Pediatrica si Ortopedica', 72);
INSERT INTO specializare VALUES (13, 'Obstetrica si Ginecologie', 79);
INSERT INTO specializare VALUES (14, 'Oftalmologie', 84);
INSERT INTO specializare VALUES (15, 'Pediatrie', 89);
INSERT INTO specializare VALUES (16, 'Epidemiologie', 94);


INSERT INTO personal VALUES (1, 'Alexe', 'Sorin', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3000, 6,1);
INSERT INTO personal VALUES (2, 'Popa', 'Dorel', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2200, 5,1);
INSERT INTO personal VALUES (3, 'Florea', 'Alina', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2000, 3,1);
INSERT INTO personal VALUES (4, 'Serban', 'Ileana', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1200, 1,1);
INSERT INTO personal VALUES (5, 'Savu', 'Sabin', 'Bucuresti', TO_DATE('13-05-1984', 'dd-MM-yyyy'),1200, 1,1);
INSERT INTO personal VALUES (6, 'Popa', 'Sorin', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3000, 6,2);
INSERT INTO personal VALUES (7, 'Soare', 'Dorel', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2200, 5,2);
INSERT INTO personal VALUES (8, 'Dorin', 'Stefan', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,2);
INSERT INTO personal VALUES (9, 'Doru', 'Ileana', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,2);
INSERT INTO personal VALUES (10, 'Savu', 'Cristina', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1200, 1,2);
INSERT INTO personal VALUES (11, 'Florea', 'Cristina', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,2);
INSERT INTO personal VALUES (12, 'Chirca', 'Raluca', 'Arad', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2200, 4,2);
INSERT INTO personal VALUES (13, 'Popa', 'Sorin', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3000, 8,3);
INSERT INTO personal VALUES (14, 'Soare', 'Dorel', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2200, 8,3);
INSERT INTO personal VALUES (15, 'Florea', 'Gabriela', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,3);
INSERT INTO personal VALUES (16, 'Doru', 'Ileana', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,3);
INSERT INTO personal VALUES (17, 'Savu', 'Cristina', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1200, 1,3);
INSERT INTO personal VALUES (18, 'Badea', 'Alina', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,3);
INSERT INTO personal VALUES (19, 'Chirca', 'Raluca', 'Arad', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2200, 4,3);
INSERT INTO personal VALUES (20, 'Dorla', 'Cristian', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3000, 8,4);
INSERT INTO personal VALUES (21, 'Soare', 'Angela', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2200, 8,4);
INSERT INTO personal VALUES (22, 'Anghel', 'Gabriela', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,4);
INSERT INTO personal VALUES (23, 'Anghel', 'Ileana', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,4);
INSERT INTO personal VALUES (24, 'Savu', 'Dorina', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1200, 1,3);
INSERT INTO personal VALUES (25, 'Tudor', 'Raluca', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,4);
INSERT INTO personal VALUES (26, 'Chirca', 'Sorina', 'Bucuresti', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2200, 4,4);
INSERT INTO personal VALUES (27, 'Iorga', 'Andrei', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3100, 6,5);
INSERT INTO personal VALUES (28, 'Popescu', 'Andreea', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2250, 5,5);
INSERT INTO personal VALUES (29, 'Jelea', 'Dorin', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2200, 3,5);
INSERT INTO personal VALUES (30, 'Luca', 'Raluca', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1100, 1,5);
INSERT INTO personal VALUES (31, 'Savu', 'Cosmin', 'Bucuresti', TO_DATE('13-05-1984', 'dd-MM-yyyy'),1400, 1,5);
INSERT INTO personal VALUES (32, 'Mutu', 'Sorin', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3100, 8,6);
INSERT INTO personal VALUES (33, 'Perianu', 'Dorel', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2300, 8,6);
INSERT INTO personal VALUES (34, 'Florea', 'Andreea', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2300, 3,6);
INSERT INTO personal VALUES (35, 'Doru', 'Adrian', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1300, 1,6);
INSERT INTO personal VALUES (36, 'Alexe', 'Sabin', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1400, 1,6);
INSERT INTO personal VALUES (37, 'Popa', 'Marian', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4200, 7,6);
INSERT INTO personal VALUES (38, 'Tudor', 'Raluca', 'Arad', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2300, 4,6);
INSERT INTO personal VALUES (39, 'Popa', 'Sorin', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3200, 6,7);
INSERT INTO personal VALUES (40, 'Sutu', 'Dorin', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2300, 5,7);
INSERT INTO personal VALUES (41, 'Florea', 'Adriana', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2100, 3,7);
INSERT INTO personal VALUES (42, 'Gogu', 'Ileana', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1200, 1,7);
INSERT INTO personal VALUES (43, 'Savu', 'Silvia', 'Bucuresti', TO_DATE('13-05-1984', 'dd-MM-yyyy'),1300, 1,7);
INSERT INTO personal VALUES (44, 'Dorea', 'Sorina', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3000, 8,8);
INSERT INTO personal VALUES (45, 'Benchescu', 'Alina', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2200, 8,8);
INSERT INTO personal VALUES (46, 'Sabin', 'Gabriela', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,8);
INSERT INTO personal VALUES (47, 'Doru', 'Alina', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,8);
INSERT INTO personal VALUES (48, 'Savu', 'Petre', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1200, 1,8);
INSERT INTO personal VALUES (49, 'Popescu', 'Cristina', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,8);
INSERT INTO personal VALUES (50, 'Chirca', 'Adela', 'Arad', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2200, 4,8);
INSERT INTO personal VALUES (51, 'Popa', 'Sorin', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3100, 8,9);
INSERT INTO personal VALUES (52, 'Soare', 'Dorel', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2400, 8,9);
INSERT INTO personal VALUES (53, 'Florea', 'Gabriela', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,9);
INSERT INTO personal VALUES (54, 'Doru', 'Ileana', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,9);
INSERT INTO personal VALUES (55, 'Savu', 'Cristina', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1300, 1,9);
INSERT INTO personal VALUES (56, 'Manea', 'Gabrielaa', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,9);
INSERT INTO personal VALUES (57, 'Chirca', 'Raluca', 'Arad', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2500, 4,9);
INSERT INTO personal VALUES (58, 'Danciu', 'Cosmin', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3100, 8,10);
INSERT INTO personal VALUES (59, 'Pasarin', 'Cosmina', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2400, 8,10);
INSERT INTO personal VALUES (60, 'Florea', 'Adela', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,10);
INSERT INTO personal VALUES (61, 'Ali', 'Ileana', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,10);
INSERT INTO personal VALUES (62, 'Edis', 'Cristina', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1300, 1,10);
INSERT INTO personal VALUES (63, 'Valea', 'Gabrielaa', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,10);
INSERT INTO personal VALUES (64, 'Danciu', 'Raluca', 'Arad', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2500, 4,10);
INSERT INTO personal VALUES (65, 'Dobrescu', 'Alexandru', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3100, 8,11);
INSERT INTO personal VALUES (66, 'Lascar', 'Alina', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2400, 8,11);
INSERT INTO personal VALUES (67, 'Dunca', 'Dan', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,11);
INSERT INTO personal VALUES (68, 'Serb', 'Razvan', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,11);
INSERT INTO personal VALUES (69, 'Edis', 'Elena', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1300, 1,11);
INSERT INTO personal VALUES (70, 'Serb', 'Gabriela', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,11);
INSERT INTO personal VALUES (71, 'Danciu', 'Alina', 'Suceava', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2500, 4,11);
INSERT INTO personal VALUES (72, 'Lisa', 'Viorel', 'Bucuresti', TO_DATE('17-03-1983', 'dd-MM-yyyy'),3100, 8,12);
INSERT INTO personal VALUES (73, 'Sorea', 'Elena', 'Oradea', TO_DATE('14-12-1988', 'dd-MM-yyyy'),2400, 8,12);
INSERT INTO personal VALUES (74, 'Dunca', 'Iulian', 'Bucuresti', TO_DATE('10-02-1988', 'dd-MM-yyyy'),2000, 3,12);
INSERT INTO personal VALUES (75, 'Serb', 'Iulian', 'Bucuresti', TO_DATE('10-07-1984', 'dd-MM-yyyy'),1200, 1,12);
INSERT INTO personal VALUES (76, 'Ali', 'Elena', 'Arad', TO_DATE('13-04-1989', 'dd-MM-yyyy'),1300, 1,12);
INSERT INTO personal VALUES (77, 'Serb', 'Andrei', 'Ploiesti', TO_DATE('12-04-1989', 'dd-MM-yyyy'),4000, 7,12);
INSERT INTO personal VALUES (78, 'Danciu', 'Florin', 'Suceava', TO_DATE('17-02-1989', 'dd-MM-yyyy'),2500, 4,12);
INSERT INTO personal VALUES (79, 'Vasile', 'Irina', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3000, 6,13);
INSERT INTO personal VALUES (80, 'Popa', 'Alina', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2200, 5,13);
INSERT INTO personal VALUES (81, 'Ioana', 'Irina', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2000, 3,13);
INSERT INTO personal VALUES (82, 'Serban', 'Adriana', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1200, 1,13);
INSERT INTO personal VALUES (83, 'Savu', 'Elena', 'Bucuresti', TO_DATE('13-05-1984', 'dd-MM-yyyy'),1200, 1,13);
INSERT INTO personal VALUES (84, 'Bugheanu', 'Ion', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3000, 6,14);
INSERT INTO personal VALUES (85, 'Benchescu', 'Alina', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2200, 5,14);
INSERT INTO personal VALUES (86, 'Vuidu', 'Camelia', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2000, 3,14);
INSERT INTO personal VALUES (87, 'Ionescu', 'Magda', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1200, 1,14);
INSERT INTO personal VALUES (88, 'Savu', 'Adela', 'Bucuresti', TO_DATE('13-05-1984', 'dd-MM-yyyy'),1200, 1,14);
INSERT INTO personal VALUES (89, 'Petre', 'Olga', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3000, 6,15);
INSERT INTO personal VALUES (90, 'Perianu', 'Alina', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2200, 5,15);
INSERT INTO personal VALUES (91, 'Soare', 'Camelia', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2000, 3,15);
INSERT INTO personal VALUES (92, 'Ionescu', 'Camelia', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1200, 1,15);
INSERT INTO personal VALUES (93, 'Savu', 'Dorina', 'Bucuresti', TO_DATE('13-05-1984', 'dd-MM-yyyy'),1200, 1,15);
INSERT INTO personal VALUES (94, 'Sorescu', 'Ramona', 'Bucuresti', TO_DATE('17-05-1987', 'dd-MM-yyyy'),3000, 6,16);
INSERT INTO personal VALUES (95, 'Sascau', 'Alina', 'Bucuresti', TO_DATE('14-02-1988', 'dd-MM-yyyy'),2200, 5,16);
INSERT INTO personal VALUES (96, 'Raducu', 'Camelia', 'Bucuresti', TO_DATE('23-02-1988', 'dd-MM-yyyy'),2000, 3,16);
INSERT INTO personal VALUES (97, 'Tamazlicaru', 'Andrei', 'Bucuresti', TO_DATE('10-03-1985', 'dd-MM-yyyy'),1200, 1,16);
INSERT INTO personal VALUES (98, 'Braun', 'Cristian', 'Bucuresti', TO_DATE('13-07-1983', 'dd-MM-yyyy'),1200, 1,16);
INSERT INTO personal VALUES (99, 'Savu', 'Radu', 'Bucuresti', TO_DATE('10-09-1988', 'dd-MM-yyyy'),1200, 1,16);
INSERT INTO personal VALUES (100, 'Bunghiuz', 'Dorina', 'Bucuresti', TO_DATE('19-02-1986', 'dd-MM-yyyy'),1200, 1,16);

alter table specializare enable constraint fkk_spec_pers;

INSERT INTO pacienti VALUES (1, 'Alina' , 'Soare', TO_DATE('01-02-1965', 'dd-MM-yyyy')); 
INSERT INTO pacienti VALUES (2, 'Elena' , 'Oana', TO_DATE('15-09-1957', 'dd-MM-yyyy')); 
INSERT INTO pacienti VALUES (3, 'Sorin' , 'Percec', TO_DATE('11-02-1980', 'dd-MM-yyyy')); 
INSERT INTO pacienti VALUES (4, 'Radu' , 'Albu', TO_DATE('13-02-1968', 'dd-MM-yyyy')); 
INSERT INTO pacienti VALUES (5, 'Edis' , 'Eras', TO_DATE('10-12-1975', 'dd-MM-yyyy')); 
INSERT INTO pacienti VALUES (6, 'Alice' , 'Mihai', TO_DATE('05-04-1977', 'dd-MM-yyyy')); 

INSERT INTO trateaza VALUES(63,1, TO_DATE('13-05-2003', 'dd-MM-yyyy'), TO_DATE('17-05-2003', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(27,1, TO_DATE('17-02-2004', 'dd-MM-yyyy'), TO_DATE('20-03-2004', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(35,1, TO_DATE('23-08-2006', 'dd-MM-yyyy'), TO_DATE('28-08-2006', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(39,2, TO_DATE('21-04-2007', 'dd-MM-yyyy'), TO_DATE('27-04-2007', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(63,2, TO_DATE('13-03-2009', 'dd-MM-yyyy'), TO_DATE('17-03-2009', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(22,3, TO_DATE('13-01-2007', 'dd-MM-yyyy'), TO_DATE('17-01-2007', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(84,3, TO_DATE('13-01-2007', 'dd-MM-yyyy'), TO_DATE('17-01-2007', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(1,3, TO_DATE('18-02-2008', 'dd-MM-yyyy'), TO_DATE('25-02-2008', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(18,3, TO_DATE('18-02-2008', 'dd-MM-yyyy'), TO_DATE('25-02-2008', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(6,4, TO_DATE('16-07-2005', 'dd-MM-yyyy'), TO_DATE('27-07-2005', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(48,4, TO_DATE('23-09-2008', 'dd-MM-yyyy'), TO_DATE('29-09-2008', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(23,5, TO_DATE('21-11-2005', 'dd-MM-yyyy'), TO_DATE('05-12-2005', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(94,5, TO_DATE('21-11-2005', 'dd-MM-yyyy'), TO_DATE('05-12-2005', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(22,6, TO_DATE('07-10-2006', 'dd-MM-yyyy'), TO_DATE('15-10-2006', 'dd-MM-yyyy'));
INSERT INTO trateaza VALUES(89,6, TO_DATE('19-11-2007', 'dd-MM-yyyy'), TO_DATE('29-11-2007', 'dd-MM-yyyy'));


commit;
