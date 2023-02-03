libname act "/home/u63122190/sasuser.v94/SAS Stastistique";


proc import out=act.mais 
	datafile="/home/u63122190/sasuser.v94/SAS Stastistique/mais.xls"
	dbms=xls
	replace;
	getnames=yes;	*/Tu vas chercher tout seul le nom des variables;
run;

proc contents data=act.mais; */ Informattion sur les données;
run;

*/ Test de Shapiro sur le Conditions :
	- ;
	
proc univariate data=act.mais Normal;
	var Hauteur;
run;

proc univariate data=act.mais;
	var Hauteur;
	class Verse;
	qqplot Hauteur / Normal(mu=est sigma=est);
run;

*/ Procedure permettant de realiser le test de Student ;

PROC TTEST DATA=act.mais;
	var Hauteur;
	class Verse;
run;
