*/ Cours de SAS;

/* creation de la bibliotheque ma_bibli*/

/* Creation d'une table;
libname ma_bibli "/home/u63122230/ma_bibli";
data ma_bibli.donnees;
length prenom $16 profession $16;
input prenom $ profession $ age montant_pret;
cards;
MARINE CADRE 29 250000
PIERRE OUVRIER 45 50000
ALEXIA MEDECIN 38 120000
ALEXANDRE ENSEIGNANT 52 180000
OLIVIA JURISTE 32 65000
BENJAMIN EMPLOYE 25 75000
YOHAN ACTUARE 23 1000000
;
run; 


* Etape DATA KEEP;
data E_1 ;
set ma_bibli.donnees;
keep prenom montant_pret;
run;

*Etape DATA DROP;
data E_2;
set ma_bibli.donnees;
drop age;
run;

*Etaoe DATA RENAME 3;
data E_3; 
set ma_bibli.donnees; 
rename profession = emploi;
run;

* Etape DATA WHERE;

data E_4; 
set ma_bibli.donnees; 
where montant_pret > 150000;
run;

data E_5; 
set ma_bibli.donnees; 
where profession = "CADRE" or profession = "ENSEIGNANT";
run;

* Ou;
 
data E_5; 
set ma_bibli.donnees; 
where profession in ("CADRE" ,"ENSEIGNANT");
run;

* Etape DATA IF & THEN;

data E_6; 
set ma_bibli.donnees; 
if montant_pret < 150000;
run;

* Etape DATA DO ... END & ELSE DO ... END;

data E_7; 
set ma_bibli.donnees; 
if age > 30 then prime = 50;
else prime = 100;
run;

* Etape DATA DELETE;

data E_8; 
set E_7; 
if prime  = 50 then delete;
run;

data E_9; 
set ma_bibli.donnees; 
length info_fumeur $18;
if age <= 35 then do;
  prime = 100;
  reduction = 0.5 ;
  info_fumeur ="Fumeur";
end;         * Exemple de l'utilité de la longeur des caracteres;
else do;
  prime = 200;
  reduction = 0.1 ;
  info_fumeur = "Non Fumeur";
end;
run;

*CONCATENATION DE TABLES;
data E_10;
set E_4 E_6;
run;

* FORMAT ;
data E_11;
set ma_bibli.donnees;
montant_pret_2 = montant_pret/3;
run;

data E_11_bis;
set E_11;
format montant_pret_2 NUMX8.2 ;
montant_pret_2 = montant_pret/3;
run;

*DATE;
data E_12;
set ma_bibli.donnees;
date = 1000;
run;

data ex_12_bis;
set ex_12;
format date DDMMYY10;
date = INTCK(200);
run;
