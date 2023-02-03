/* Lien de la biliothèque ma_bibli */

libname ma_bibli "/folders/myfolders/ma_bibli";


/* Importation des données emprunteur dans SAS avec une PROC IMPORT */

proc import datafile="/folders/myfolders/Donnees_emprunteur.xlsx"
	out=ma_bibli.donnees_emprunteur
	dbms=xlsx
	replace;
	getnames=yes;
run;


/* A cause d'un problème d'importation, des colonnes se sont ajoutées */
/* On conserve uniquement les variables d'origine avec un keep */

data ma_bibli.donnees_emprunteur;
set ma_bibli.donnees_emprunteur; 
keep Numero_contrat	Numero_assure Date_naissance Profession Fumeur Date_ouverture Montant_pret Taux_pret Mensualite Duree_ini_mois Quotite;
run;


/* On change le format de la variable numero_contrat pour que l'affichage ne soit pas
en écriture scientifique */

data ma_bibli.donnees_emprunteur;
set ma_bibli.donnees_emprunteur;
format numero_contrat numx25.;
run;


/* Réaliser une PROC CONTENTS sur la table Donnees_emprunteur */

proc contents data=ma_bibli.donnees_emprunteur;
run;


/* exercice 1 */

proc sort data=ma_bibli.donnees_emprunteur out=ex_1;
by montant_pret;
run;


/* exercice 2 */

proc sort data=ma_bibli.donnees_emprunteur out=ex_2;
by descending profession descending mensualite;
run;


/* exercice 3 */

proc sort data=ma_bibli.donnees_emprunteur out=ex_3;
by numero_contrat;
run;

data ex_3;
set ex_3;
by numero_contrat;
if first.numero_contrat then compteur=1;
else compteur=0;
run;

data ex_3;
set ex_3;
keep numero_contrat compteur;
run;


/* exercice 4 */

proc means data=ma_bibli.donnees_emprunteur;
var montant_pret;
output out=ex_4;
run;

/* Exportation de la table SAS ex_4 */
proc export data=ex_4
outfile="/folders/myfolders/ex_4.xlsx"
dbms=xlsx replace;
run;


/* exercice 4 bis */

data ex_4_bis;
set ma_bibli.donnees_emprunteur;
duree_ini_annee=ceil(duree_ini_mois/12);
run;

proc means data=ex_4_bis;
class duree_ini_annee;
var montant_pret;
run;


/* exercice 5 */

/* Avec écriture dans RESULTATS */
proc freq data=ma_bibli.donnees_emprunteur;
table profession;
run;

/* Sans écriture dans RESULTATS et stockage dans une table */
proc freq data=ma_bibli.donnees_emprunteur noprint;
table profession * fumeur / out=ex_5;
run;

/* Exportation de la table SAS ex_5 */
proc export data=ex_5
outfile="/folders/myfolders/ex_5.xlsx"
dbms=xlsx replace;
run;
