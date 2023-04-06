***********************************************************************.
* PATCHFILE FOR CORRECTING ERRATA IN ALLBUS/GGSS 2006                 *.
*                                                                     *.
*                                                                     *.
* FOR USE WITH RELEASE 2.0.0, doi:10.4232/1.10832 		              *.
*                                                                     *.
*                                                                     *.
* THIS PATCH CORRECTS WEIGHT VARIABLES v736 and v738 AND RECODES      *.
* CASES LACKING INFORMATION ABOUT HOUSEHOLD SIZE TO MISSING	          *.
*                                                                     *.
* ALSO,                                                               *.
*                                                                     *.
* THIS PATCH RECODES MISSING VALUE CODES TO INTEGERS FOR VARIABLES    *.
* WITH DECIMAL PLACES AND ASSIGNS LABELS TO THEM		              *.
*             							                              *.
***********************************************************************.

global data "<ENTER DATA PATH>"
use "$data\ZA4500_v2-0-0.dta", clear
notes drop _all
*	v736, TRANSFORMATIONSGEWICHT HAUSHALT
*	v738, OST-WEST TRANSFORMATIONSGEWICHT HAUSHALT
* 	DATA CORRECTION: RECODING CASES LACKING INFORMATION ABOUT HOUSEHOLD SIZE TO MISSING (.a "KEINE ANGABE")

recode v736 v738 (8/10 = .a)
capture label define Gewichte .a "KEINE ANGABE"
label values v736 v738 Gewichte
foreach var in v736 v738{
note `var' : TS CASES LACKING INFORMATION ABOUT HOUSEHOLD SIZE WERE SET TO MISSING
}


*RECODING VARIABLES AND ASSIGNING LABELS TO MISSING VALUES FOR VARIABLES WITH DECIMAL PLACES

foreach var in v197 v207 v215 v228 v275 v319 v345 v362{
replace `var' = 999 if `var' ==999.9
notes `var': TS CODES FOR MISSING VALUES DIFFER FROM SPSS DATA SET
}


foreach var in v197 v207 v215 v228 v275 v319 v345 v362{
capture label define `var' 999 "KEINE ANGABE", add
label values `var' `var'
}


foreach var in v193 v224 v271 v315 v341 v358{
replace `var' = 99 if `var' ==99.9
notes `var': TS CODES FOR MISSING VALUES DIFFER FROM SPSS DATA SET
}


foreach var in v193 v224 v271 v315 v341 v358{
capture label define `var' 99 "KEINE ANGABE", add
label values `var' `var'
}


foreach var in v510 v513{
replace `var' = 99 if `var' ==99.99
notes `var': TS CODES FOR MISSING VALUES DIFFER FROM SPSS DATA SET
}


foreach var in v510 v513{
capture label define `var' 99 "KEINE ANGABE", add
label values `var' `var'
}


note: TS CODES AND LABELS OF MISSING VALUES UPDATED FOR VARIABLES WITH DECIMAL PLACES: ///
PLEASE NOTE THAT FOR THESE VARIABLES THE STATA CODES MIGHT BE DIFFERENT FROM THOSE OF THE SPSS DATA SET

label data "ALLBUS 2006"

save "$data\ZA4500_v2-0-0.dta", replace
