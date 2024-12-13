//Datos 2005
import delimited "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2005_dbf\DEFUN05.csv", clear
save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2005_dbf\base1.dta", replace 
//Datos 2006
import delimited "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2006_dbf\DEFUN06.csv", clear
save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2006_dbf\base2.dta", replace 
//Datos 2008
import delimited "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\DEFUN08.csv", clear
save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\base3.dta", replace
//Pegamos las bases de datos
use "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2005_dbf\base1.dta", clear
append using "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2006_dbf\base2.dta"
save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2006_dbf\base.dta", replace 
use "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2006_dbf\base.dta", clear
append using "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\base3.dta"
save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\base.dta", replace

//Limpiamos la nueva base
use "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\base.dta", clear 
// abajo los hombres
replace sexo=0 if sexo == 1
replace sexo=1 if sexo == 2
rename sexo mujer
drop if mujer == 9
**Quitamos las localidades no especificadas y con clave confidencial
drop if loc_ocurr == 7777 
drop if loc_ocurr == 9999
drop if loc_ocurr == 0000
**Quitamos los municipios no especificados y con clave confidencial
drop if mun_ocurr == 9999
drop if mun_ocurr == 7777
drop if mun_ocurr == 0000
**Nos quedamos con los años que nos interesan
keep if anio_ocur == 2005 | anio_ocur == 2006 | anio_ocur == 2008
save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\base.dta", replace
use "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf\base.dta", clear
***********************************************************************
cd "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\datos 2005 2009\defunciones_generales_base_datos_2005_2009_dbf\defunciones_base_datos_2008_dbf"
use "base.dta", clear
keep if mujer == 1

//Generamos una nueva variable para muertes por otro tipo de aborto y por aborto espontaneo
gen m_aborto = 1 if lista_mex == "43C" | lista_mex == "43A" | causa_def == "O021" |  causa_def == "O030" | causa_def == "O031" | causa_def == "O032" | causa_def == "O035" | causa_def == "O036" | causa_def == "O038"| causa_def == "O041" |causa_def == "O050" | causa_def == "O051" | causa_def == "O053" | causa_def == "O055" | causa_def == "O056" | causa_def == "O058" | causa_def == "O060" | causa_def == "O068" | causa_def == "O061" | causa_def == "O062" | causa_def == "O063" |causa_def == "O064" | causa_def == "O065"  | causa_def == "O066"  | causa_def == "O067" |  causa_def == "O069"
replace m_aborto = 0 if m_aborto == .

**Nos quedamos con nuestros grupos control y tratamiento
**Control = Morelos, Queretaro, Hidalgo y Edo. Mex
**Tratamiento = CDMX

keep if ent_ocurr == 09 | ent_ocurr == 15 | ent_ocurr == 17 | ent_ocurr == 13 | ent_ocurr == 22

//Generamos una nueva  variable para identificar a nuestros grupos 
gen tratados = 1 if ent_ocurr == 09 
replace tratados = 0 if tratados ==.

drop if edo_civil == 8
replace edo_civil = 2 if edo_civil == 9
replace edo_civil = 0 if edo_civil == 4 | edo_civil ==5
replace edo_civil = 1 if edo_civil == 1 |edo_civil == 2 | edo_civil == 3| edo_civil == 6
rename edo_civil soltera
replace vio_fami = 3 if vio_fami ==8
replace vio_fami = 0 if vio_fami ==2
replace vio_fami = 2 if vio_fami ==9
replace asist_medi = 2 if asist_medi == 9
replace asist_medi = 0 if asist_medi == 2
replace area_ur = 0 if area_ur == 2
replace area_ur = 2 if area_ur == 9
replace derechohab = 2 if derechohab == 99
replace derechohab = 0 if  derechohab ==1
replace derechohab = 1 if  derechohab ==2 |derechohab ==3 |derechohab ==4 |derechohab == 5| derechohab == 6 | derechohab == 7 | derechohab == 8 | derechohab ==9

save "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\Prbase.dta", replace

************************************************************************
//Analisis de Diferencias en Diferencias
use "C:\Users\AnA LuIsA\Dropbox\Mi PC (DESKTOP-N0S932P)\Desktop\ProyectoF AD\Prbase.dta", clear
**Para la prueba de tendencias paralelas
*Hacemos dos regresiones 
*para los periodos 2005 y 2006
keep if anio_ocur == 2005 | anio_ocur == 2006
gen AAntes = 0 if anio_ocur == 2005
replace AAntes = 1 if AAntes ==.
gen inter = tratados*AAntes
asdoc reg m_aborto AAntes tratados inter ent_ocurr mun_ocurr tloc_ocurr  loc_ocurr soltera vio_fami asist_medi area_ur derechohab, dec(7), save(AAntes.doc)
************************************************
*Para los periodos 2006 y 2008
use "C:\Users\AnA LuIsA\Desktop\Materias\8 semestre\Analisis de datos\ProyectoF AD\Prbase.dta", clear
keep if mujer == 1
keep if anio_ocur == 2006 | anio_ocur == 2008
gen Antes = 0 if anio_ocur == 2006
replace Antes = 1 if Antes ==.
gen inter = tratados*Antes
asdoc reg m_aborto Antes tratados inter ent_ocurr mun_ocurr tloc_ocurr  loc_ocurr soltera vio_fami asist_medi area_ur derechohab, dec(7), save(Antes.doc)
*Hacemos la gráfica
gen n = _n
sum m_aborto if Antes == 0 & tratados == 0
gen m_aborto_con = r(mean) if n == 1
sum m_aborto if Antes == 1 & tratados == 0
replace m_aborto_con = r(mean) if n == 2

sum m_aborto if Antes == 0 & tratados == 1
gen m_aborto_trat = r(mean) if n == 1
sum m_aborto if Antes == 1 & tratados == 1
replace m_aborto_trat = r(mean) if n == 2

twoway (connected m_aborto_con n if n <= 2 ) (connected m_aborto_trat n if n<=2), ////
xlabel(1 "Antes" 2 "Despues", labsize(vsmall) angle(45)) ////
legend(order(1 "Controles" 2 "Tratados")) ////
xtitle("") ////
ytitle("Muertes por aborto")
*************************************
*Aplicamos el método usando diff
*Para comprobar la robustez
*Primero aplicamos el método sin variables de control
asdoc diff m_aborto, treated(tratados) p(Antes), dec(7), save(diff.doc)
*Ahora con variables de control
asdoc diff m_aborto, treated(tratados) p(Antes) cov(ent_ocurr mun_ocurr tloc_ocurr  loc_ocurr soltera vio_fami asist_medi area_ur derechohab), dec(7), save(diffc.doc)
