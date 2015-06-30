*Download tables  from the FBI CUIS.

*Trim extra top and bottom rows from XLS downloads
	- unmerge all cells
	- add state 2 letter abbreviations for all rows
	- extend university name down.
 
*Import statewide table.
GET DATA
  /TYPE=XLS
  /FILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\13tbl04.xls'
  /SHEET=name '13tbl04'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=150.
DATASET NAME UCR_STATE_2014 WINDOW=FRONT.
*SELECT STATES AND CURRENT YEAR.
DATASET ACTIVATE UCR_STATE_2014.
FILTER OFF.
USE ALL.
SELECT IF (Year = "2013" & length(rtrim(Area)) > 0).
EXECUTE.
*NS VARIABLE NAMES.
STRING  STABB (A2).
COMPUTE STABB=AREA.
 COMPUTE UCR_MURDER_COUNT_S = Murderandnonnegligentmanslaughter.  
 COMPUTE  UCR_RAPE_COUNT_S = Rapereviseddefinition3  .
 COMPUTE UCR_ROBBERY_COUNT_S = Robbery  .
 COMPUTE UCR_ASSAULT_COUNT_S = Aggravatedassault  .
   COMPUTE UCR_BURGLARY_COUNT_S = Burglary  .
  COMPUTE UCR_LARCENY_COUNT_S = Larcenytheft  .
  COMPUTE UCR_MVT_COUNT_S = Motorvehicletheft  .
  COMPUTE POPULATION_S = POPULATION1.
COMPUTE LEGACY_RAPE_COUNT_S = Rapelegacydefinition4.
compute UCR_VIOLENT_COUNT_S = UCR_MURDER_COUNT_S+UCR_RAPE_COUNT_S+UCR_ROBBERY_COUNT_S+UCR_ASSAULT_COUNT_S.
COMPUTE UCR_PROPERTY_COUNT_S = UCR_BURGLARY_COUNT_S+UCR_LARCENY_COUNT_S+UCR_MVT_COUNT_S.
execute.

*get PR adjustments from excel sheet.

COMPUTE UCR_VIOLENT_RATE_S = 1000 * UCR_VIOLENT_COUNT_S / POPULATION_S.
COMPUTE UCR_MURDER_RATE_S = 1000 * UCR_MURDER_COUNT_S / POPULATION_S.
COMPUTE UCR_RAPE_RATE_S = 1000 * UCR_RAPE_COUNT_S / POPULATION_S.
COMPUTE UCR_ROBBERY_RATE_S = 1000 * UCR_ROBBERY_COUNT_S / POPULATION_S.
COMPUTE UCR_ASSAULT_RATE_S = 1000 * UCR_ASSAULT_COUNT_S / POPULATION_S.
COMPUTE UCR_BURGLARY_RATE_S = 1000 * UCR_BURGLARY_COUNT_S / POPULATION_S.
COMPUTE UCR_LARCENY_RATE_S = 1000 * UCR_LARCENY_COUNT_S / POPULATION_S.
COMPUTE UCR_MVT_RATE_S = 1000 * UCR_MVT_COUNT_S / POPULATION_S.
COMPUTE UCR_PROPERTY_RATE_S = 1000 * UCR_PROPERTY_COUNT_S / POPULATION_S.
EXECUTE.

MATCH FILES /FILE=*
/KEEP STABB POPULATION_S	UCR_MURDER_COUNT_S	UCR_RAPE_COUNT_S	UCR_ROBBERY_COUNT_S	
UCR_ASSAULT_COUNT_S	UCR_BURGLARY_COUNT_S	UCR_LARCENY_COUNT_S	UCR_MVT_COUNT_S
	LEGACY_RAPE_COUNT_S	UCR_VIOLENT_RATE_S	UCR_PROPERTY_RATE_S	UCR_VIOLENT_COUNT_S
	UCR_PROPERTY_COUNT_S	UCR_MURDER_RATE_S	UCR_RAPE_RATE_S	UCR_ROBBERY_RATE_S
	UCR_ASSAULT_RATE_S	UCR_BURGLARY_RATE_S	UCR_LARCENY_RATE_S	UCR_MVT_RATE_S.
EXECUTE.
*SAVE FILE.
SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_STATE_2014.sav'
  /COMPRESSED.

*IMPORT CITY TABLE.
GET DATA
  /TYPE=XLS
  /FILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\13tbl08.xls'
  /SHEET=name '13tbl8'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=150.
DATASET NAME UCR_CITY_2014 WINDOW=FRONT.
*ELIMINATE FOOTNOTES.
COMPUTE CITY = RTRIM(RTRIM(CITY), '1').
COMPUTE CITY = RTRIM(RTRIM(CITY), '2').
COMPUTE CITY = RTRIM(RTRIM(CITY), '3').
COMPUTE CITY = RTRIM(RTRIM(CITY), '4').
COMPUTE CITY = RTRIM(RTRIM(CITY), '5').
COMPUTE CITY = RTRIM(RTRIM(CITY), '6').
COMPUTE CITY = RTRIM(RTRIM(CITY), '7').
COMPUTE CITY = RTRIM(RTRIM(CITY), '8').
COMPUTE CITY = RTRIM(RTRIM(CITY), '10').
COMPUTE CITY = RTRIM(RTRIM(CITY), '9').
COMPUTE CITY = RTRIM(RTRIM(CITY), ',').
COMPUTE CITY = RTRIM(RTRIM(CITY), '1').
COMPUTE CITY = RTRIM(RTRIM(CITY), '2').
COMPUTE CITY = RTRIM(RTRIM(CITY), '3').
COMPUTE CITY = RTRIM(RTRIM(CITY), '4').
COMPUTE CITY = RTRIM(RTRIM(CITY), '5').
COMPUTE CITY = RTRIM(RTRIM(CITY), '6').
COMPUTE CITY = RTRIM(RTRIM(CITY), '7').
COMPUTE CITY = RTRIM(RTRIM(CITY), '8').
COMPUTE CITY = RTRIM(RTRIM(CITY), '9').
COMPUTE CITY = RTRIM(RTRIM(CITY), '10').
EXECUTE.
*KEY.
STRING AGENCY_KEY (A155).
COMPUTE AGENCY_KEY = upper(CONCAT(RTRIM(CITY),', ',STATE)).
EXECUTE.
sort cases by agency_key.
*SAVE FILE.
SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_CITY_2014.sav'
  /COMPRESSED.

*IMPORT COLLEGE TABLE.
GET DATA
  /TYPE=XLS
  /FILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\13tbl09.xls'
  /SHEET=name '13tbl9'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=150.
DATASET NAME UCR_COLLEGE_2014 WINDOW=FRONT.
*ELIMINATE FOOTNOTES.
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE),"1").
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE), '2').
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE), '3').
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE), '4').
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE), '5').
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE), '6').
COMPUTE UNIVERSITYCOLLEGE = RTRIM(RTRIM(UNIVERSITYCOLLEGE), ',').
COMPUTE CAMPUS = RTRIM(RTRIM(CAMPUS), '1').
COMPUTE CAMPUS = RTRIM(RTRIM(CAMPUS), '2').
COMPUTE CAMPUS = RTRIM(RTRIM(CAMPUS), '3').
COMPUTE CAMPUS = RTRIM(RTRIM(CAMPUS), '4').
COMPUTE CAMPUS = RTRIM(RTRIM(CAMPUS), '5').
EXECUTE.
*KEY.
STRING AGENCY_KEY (A155).
COMPUTE AGENCY_KEY = upper(concat(rtrim(concat(rtrim(UniversityCollege),' ',Campus)),', ',rtrim(state),' (U)')).
EXECUTE.
sort caSES BY AGENCY_KEY.
*SAVE FILE.
SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_COLLEGE_2014.sav'
  /COMPRESSED.

*IMPORT COUNTY TABLE.
GET DATA
  /TYPE=XLS
  /FILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\13tbl10.xls'
  /SHEET=name '13Tbl10'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=150.
DATASET NAME UCR_COUNTY_2014 WINDOW=FRONT.
*ELIMINATE FOOTNOTES.
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '1').
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '2').
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '3').
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '4').
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '5').
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '6').
COMPUTE COUNTY = RTRIM(RTRIM(COUNTY), '7').
EXECUTE.
*KEY.
STRING AGENCY_KEY (A155).
COMPUTE AGENCY_KEY = upper(CONCAT(RTRIM(COUNTY),', ',RTRIM(STATE), ' (C)')).
EXECUTE.
SORT CASES BY AGENCY_KEY.
*SAVE FILE.
SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_COUNTY_2014.sav'
  /COMPRESSED.

*IMPORT SPECIAL TABLE.
GET DATA
  /TYPE=XLS
  /FILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\13tbl11.xls'
  /SHEET=name '13tbl11'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=150.
DATASET NAME UCR_SPECIAL_2014 WINDOW=FRONT.
*ELIMINATE FOOTNOTES.
COMPUTE StateTribalOtherAgencies = RTRIM(RTRIM(StateTribalOtherAgencies), '1').
COMPUTE StateTribalOtherAgencies = RTRIM(RTRIM(StateTribalOtherAgencies), '2').
COMPUTE StateTribalOtherAgencies = RTRIM(RTRIM(StateTribalOtherAgencies), '3').
COMPUTE StateTribalOtherAgencies = RTRIM(RTRIM(StateTribalOtherAgencies), '4').
COMPUTE UnitOffice = RTRIM(RTRIM(UnitOffice), '1').
COMPUTE UnitOffice = RTRIM(RTRIM(UnitOffice), '2').
COMPUTE UnitOffice = RTRIM(RTRIM(UnitOffice), '3').
COMPUTE UnitOffice = RTRIM(RTRIM(UnitOffice), '4').
execute.
*KEY.
STRING AGENCY_KEY (A155).
COMPUTE AGENCY_KEY = concat(rtrim(concat(rtrim(StateTribalOtherAgencies),' ',UnitOffice)),', ',rtrim(state),' (S)').
compute AGENCY_KEY = UPPER(ltrim(agency_key)).
EXECUTE.
SORT CASES BY AGENCY_KEY.
*SAVE FILE.

SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_SPECIAL_2014.sav'
  /COMPRESSED.

*Merge all UCR files.
DATASET ACTIVATE UCR_CITY_2014.
dataset name UCR_CRIME_2014 .

*ADD COLLEGE.
dataset close ucr_college_2014.


*ADD COUNTY.
dataset close ucr_COUNTY_2014.


*ADD SPECIAL.
dataset close ucr_SPECIAL_2014.


COMPUTE UCR_YEAR = 2013.
EXECUTE.
*CHECK FOR DUPLICATES.
SORT CASES BY AGENCY_KEY(A) Population(A).
MATCH FILES
  /FILE=*
  /BY AGENCY_KEY
  /LAST=PrimaryLast.
EXECUTE.

SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_CRIME_2014.sav'
  /COMPRESSED.

*JOIN TO CROSSWALK.
GET
  FILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\UCR_crosswalk_2014.sav'.
DATASET NAME CROSSWALK WINDOW=FRONT.
SORT CASES BY AGENCY_KEY.

*test crosswalk.
DATASET ACTIVATE CROSSWALK.
DATASET DECLARE crosswalk_test.
AGGREGATE
  /OUTFILE='crosswalk_test'
  /BREAK=AGENCY_KEY
  /COUNTY_KEY_first=FIRST(COUNTY_KEY) 
  /city_key_first=FIRST(city_key)
  /N_BREAK=N.

dataset activate crosswalk_test.
DATASET ACTIVATE crosswalk_test.
MATCH FILES /FILE=*
  /FILE='UCR_CRIME_2014'
  /BY AGENCY_KEY.
EXECUTE.

sort cases by n_break (a) violentcrime (d) propertycrime (d) population (d).

*file for muni populations and ID.
GET
  FILE='C:\Users\Jonathan Glick\Documents\Dropbox (Location, Inc.)\Census '+
    'Update\PopEst2013\muni_pop_all_2013.sav'.
DATASET NAME muni_pop WINDOW=FRONT.

*MAKE CHANGES TO CROSSWALK, drop last years crime totals.
DATASET ACTIVATE CROSSWALK.
dataset close crosswalk_test.
MATCH FILES /FILE=*
  /TABLE='UCR_CRIME_2014' 
  /BY AGENCY_KEY.
EXECUTE.

*caluculate share of crimes within county. 
compute Murderandnonnegligentmanslaughter = rnd(within_county_ratio * Murderandnonnegligentmanslaughter).
compute Forciblerape  =  rnd(within_county_ratio * Rapereviseddefinition1).
compute Robbery  =  rnd(within_county_ratio * Robbery).
compute Aggravatedassault  =  rnd(within_county_ratio * Aggravatedassault).
compute Burglary  =  rnd(within_county_ratio * Burglary).
compute Larcenytheft  =  rnd(within_county_ratio * Larcenytheft).
compute Motorvehicletheft  =  rnd(within_county_ratio * Motorvehicletheft).
compute population =  rnd(within_county_ratio * population).
compute violentcrime =Murderandnonnegligentmanslaughter+Forciblerape+Robbery+Aggravatedassault.
compute propertycrime=Burglary+Larcenytheft+Motorvehicletheft.
execute.

*code multi-place (or unknow place) agencies as part of county remainder.  
if(multplc=1)primary_police = 0.
*if no recent report and "covered by" then code as non-primary.
if(length(rtrim(ucovby))>0&ucr_any=0) primary_police=0.
execute.
* if UCR population make sure has population in crosswalk.
if(population>0) primary_police=1.
if(multplc=1)primary_police = 0.
execute.

sort cases by town_key primary_police upop.
MATCH FILES
  /FILE=*
  /BY town_key
 /last=Primary_last.
execute.

if(primary_last = 0) primary_police=0.
execute.

*create list of places with primary coverage.
DATASET ACTIVATE CROSSWALK.
DATASET DECLARE primary_cov.
AGGREGATE
  /OUTFILE='primary_cov'
  /BREAK=town_key
  /PRIMARY_POLICE_max=MAX(PRIMARY_POLICE).
dataset activate primary_cov.
select if(primary_police_max=1).
string city_county_key (a10).
compute city_county_key = town_key.
execute.

dataset activate muni_pop.
sort cases by city_county_key.
MATCH FILES /FILE=*
  /TABLE='primary_cov'
/rename primary_police_max = city_pd
  /BY city_county_key.
EXECUTE.

sort cases by town_key.
MATCH FILES /FILE=*
  /TABLE='primary_cov'
/rename primary_police_max = town_pd
  /BY town_key.
EXECUTE.

if(city_pd=1) pd_pop = popestimate2013.
if(town_pd=1) pdt_pop = popestimate2013.
if(town_pd=1 &  city_pd=1) pdt_pop = 0.
execute.

DATASET ACTIVATE muni_pop.
DATASET DECLARE juris_pop.
AGGREGATE
  /OUTFILE='juris_pop'
  /BREAK=city_county_key
  /city_county_pop=SUM(pd_pop).

DATASET DECLARE juris_town.
AGGREGATE
  /OUTFILE='juris_town'
  /BREAK=town_key
  /city_county_pop=SUM(pdt_pop).

DATASET ACTIVATE juris_town.
ADD FILES /FILE=*
  /FILE='juris_pop'
  /RENAME city_county_key=town_key.
EXECUTE.

* Identify Duplicate Cases.
SORT CASES BY town_key(A) city_county_pop(A).
MATCH FILES
  /FILE=*
  /BY town_key
  /LAST=PrimaryLast.
EXECUTE.
select if (primarylast=1).
execute.

dataset activate crosswalk.
sort cases by town_key.
DATASET ACTIVATE CROSSWALK.
MATCH FILES /FILE=*
  /TABLE='juris_town'
  /RENAME (PrimaryLast = d0) 
  /BY town_key
  /DROP= d0.
EXECUTE.

dataset close juris_town.
dataset close juris_pop.

sort cases by city_county_pop (a) population (d).

*check places missing new populaiton estimates.  May not be available for CDP - use FBI estimate to keep.

if(missing(city_county_pop) and population>0) city_county_pop = city_county_pop_2010.
execute.

if(primary_police = 0) city_county_pop=0.
recode city_county_pop (sysmis=0).
execute.


*investigate places with discrepancies in reported population.
USE ALL.
COMPUTE filter_$=(abs(Population-city_county_pop)/city_county_pop>.25).
FILTER BY filter_$.
EXECUTE.
use all.

*code as part of county remainder if populations not consistent.
do if(primary_police=1 and population > 0 and city_county_pop =0 and NOT char.substr(city_key,3,2)='99' ).
*compute city_key = concat(char.substr(county_key, 1,2), "99", char.substr(county_key, 3)).
*compute town_key= concat(county_key, "99", char.substr(county_key, 3)).
*compute primary_police = 0.
end if.
execute.

DATASET ACTIVATE CROSSWALK.
sort cases by county_key.
MATCH FILES /FILE=*
  /TABLE='county_pop_2013'
  /BY county_key.
EXECUTE.

*adjust county remainder populatitons.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES OVERWRITE=yes
  /BREAK=COUNTY_KEY
  /county_pop_sum=SUM(city_county_pop).

if(primary_police=1 & char.substr(city_key,3,2)='99' & NOT char.substr(city_key,5,3)='999' ) 
city_county_pop = city_county_pop - (county_pop_sum - county_pop_2013).
execute.

*check county sums now correct.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES OVERWRITE=yes
  /BREAK=COUNTY_KEY
  /county_pop_sum=SUM(city_county_pop).

USE ALL.
COMPUTE filter_$=(county_pop_sum = county_pop_2013).
FILTER BY filter_$.
EXECUTE.

*check for negative.
USE ALL.
COMPUTE filter_$=(city_county_pop_2010 >=0).
FILTER BY filter_$.
EXECUTE.
USE ALL.
recode filter_$ (sysmis=0).
execute.
sort cases by filter_$ (a) county_key (a) city_county_pop_2010 (d).
USE ALL.

*check for extreme rates.
compute aslt_rate = 1000*aggravatedassault / city_county_pop.
compute theft_rate = 1000*larcenytheft / city_county_pop.
execute.
sort cases by aslt_rate (d).


*IF no new PR municipio data...
*use worksheet crime/2014/PR2010.xlsx to adjust

*missing prmiary police.
do if (primary_police =1 and city_county_pop > 0).
recode Murderandnonnegligentmanslaughter(SYSMIS = -999999).
recode Forciblerape(SYSMIS = -999999).
recode Rapelegacydefinition2 (SYSMIS = -999999).
recode Robbery(SYSMIS = -999999).
recode Aggravatedassault(SYSMIS = -999999).
recode Burglary(SYSMIS = -999999).
recode Larcenytheft(SYSMIS = -999999).
recode Motorvehicletheft(SYSMIS = -999999).
end if.
execute.

*aggregate to places.
sort cases by town_key (a) primary_police(d).
DATASET DECLARE ucr_sum_2014_new.
AGGREGATE
  /OUTFILE='ucr_sum_2014_new'
  /BREAK=COUNTY_KEY town_key city_key
 /AGENCY_KEY=FIRST(agency_key) 
  /UCR_PLACENM=FIRST(placenm) 
  /JURISDICTION_POP_2013=SUM(city_county_pop) 
/UCR_POPULATION_2013=SUM(population) 
/COUNTY_POP_2013 = first(county_pop_2013)
  /UCR_MURDER_M=SUM(Murderandnonnegligentmanslaughter) 
  /UCR_RAPE_M=SUM(Forciblerape) 
/UCR_RAPE_OLD_M = sum(Rapelegacydefinition2)
  /UCR_ROBBERY_M=SUM(Robbery) 
  /UCR_ASSAULT_M=SUM(Aggravatedassault) 
  /UCR_BURGLARY_M=SUM(Burglary) 
  /UCR_THEFT_M=SUM(Larcenytheft) 
  /UCR_MVT_M=SUM(Motorvehicletheft).
*recode missing.
DATASET ACTIVATE ucr_sum_2014_new.
RECODE UCR_MURDER_M UCR_RAPE_M UCR_ROBBERY_M UCR_ASSAULT_M UCR_BURGLARY_M UCR_THEFT_M UCR_MVT_M 
  UCR_RAPE_OLD_M  (Lowest thru -1=SYSMIS).
EXECUTE.

*distribute county-wide crimes.
DATASET ACTIVATE ucr_sum_2014_new.
DATASET DECLARE countywide.
AGGREGATE
  /OUTFILE='countywide'
  /BREAK=COUNTY_KEY JURISDICTION_POP_2013
  /UCR_MURDER_M_sum=SUM(UCR_MURDER_M) 
  /UCR_RAPE_M_sum=SUM(UCR_RAPE_M) 
  /UCR_RAPE_OLD_M_sum=SUM(UCR_RAPE_OLD_M) 
  /UCR_ROBBERY_M_sum=SUM(UCR_ROBBERY_M) 
  /UCR_ASSAULT_M_sum=SUM(UCR_ASSAULT_M) 
  /UCR_BURGLARY_M_sum=SUM(UCR_BURGLARY_M) 
  /UCR_THEFT_M_sum=SUM(UCR_THEFT_M) 
  /UCR_MVT_M_sum=SUM(UCR_MVT_M).
DATASET activate countywide.
select if (jurisdiction_pop_2013=0).
execute.
dataset activate ucr_sum_2014_new.
MATCH FILES /FILE=*
  /TABLE='countywide'
  /RENAME (JURISDICTION_POP_2013 = d0) 
  /BY COUNTY_KEY
  /DROP= d0.
EXECUTE.
dataset close countywide.
if(ucr_murder_m>=0 and ucr_murder_m_sum>0) ucr_murder_m = ucr_murder_m + rnd(ucr_murder_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_rape_m>=0 and ucr_rape_m_sum>0) ucr_rape_m = ucr_rape_m + rnd(ucr_rape_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_assault_m>=0 and ucr_assault_m_sum>0) ucr_assault_m = ucr_assault_m + rnd(ucr_assault_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_robbery_m>=0 and ucr_robbery_m_sum>0) ucr_robbery_m = ucr_robbery_m + rnd(ucr_robbery_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_theft_m>=0 and ucr_theft_m_sum>0) ucr_theft_m = ucr_theft_m + rnd(ucr_theft_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_mvt_m>=0 and ucr_mvt_m_sum>0) ucr_mvt_m = ucr_mvt_m + rnd(ucr_mvt_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_burglary_m>=0 and ucr_burglary_m_sum>0) ucr_burglary_m = ucr_burglary_m + rnd(ucr_burglary_m_sum* jurisdiction_pop_2013/ county_pop_2013).
if(ucr_rape_old_m>=0 and ucr_rape_old_m_sum>0) ucr_rape_old_m = ucr_rape_old_m + rnd(ucr_rape_old_m_sum* jurisdiction_pop_2013/ county_pop_2013).
execute.
match files /file=*
/drop UCR_MURDER_M_sum UCR_RAPE_M_sum ucr_rape_old_m_sum UCR_RAPE_OLD_M_sum UCR_ROBBERY_M_sum UCR_ASSAULT_M_sum
UCR_BURGLARY_M_sum UCR_THEFT_M_sum UCR_MVT_M_sum.
execute.

select if (jurisdiction_pop_2013>0).
execute.

 *get city total across counties.
sort cases by city_key (a) jurisdiction_pop_2013 (d).
DATASET DECLARE UCR_MUNI_SUM.
AGGREGATE
  /OUTFILE='UCR_MUNI_SUM'
  /BREAK=city_key
/town_key=first(town_key)
 /AGENCY_KEY=FIRST(AGENCY_KEY) 
/POPULATION_2013=SUM(JURISDICTION_POP_2013) 
/POPULATION_UCR=FIRST(UCR_POPULATION_2013) 
  /UCR_MURDER_M=SUM(UCR_MURDER_M) 
  /UCR_RAPE_M=SUM(UCR_RAPE_M) 
 /UCR_RAPE_OLD_M=SUM(UCR_RAPE_OLD_M) 
  /UCR_ROBBERY_M=SUM(UCR_ROBBERY_M) 
  /UCR_ASSAULT_M=SUM(UCR_ASSAULT_M) 
  /UCR_BURGLARY_M=SUM(UCR_BURGLARY_M) 
  /UCR_THEFT_M=SUM(UCR_THEFT_M) 
  /UCR_MVT_M=SUM(UCR_MVT_M).
DATASET ACTIVATE UCR_MUNI_SUM.
compute UCR_VIOLENT_M = UCR_MURDER_M+UCR_RAPE_M+UCR_ROBBERY_M+UCR_ASSAULT_M.
if(missing(ucr_rape_m))UCR_VIOLENT_M = UCR_MURDER_M+ rnd(1.417*UCR_RAPE_OLD_M)+UCR_ROBBERY_M+UCR_ASSAULT_M.
if(missing(ucr_rape_m))UCR_rape_M = rnd(1.417*UCR_RAPE_OLD_M).
COMPUTE UCR_PROPERTY_M = UCR_BURGLARY_M+UCR_THEFT_M+UCR_MVT_M.
EXECUTE.

*compute rates.
compute UCR_MURDER_PT_M = 1000 * UCR_MURDER_M /population_2013.
compute UCR_rape_PT_M = 1000 * UCR_rape_M /population_2013.
compute UCR_assault_PT_M = 1000 * UCR_assault_M /population_2013.
compute UCR_robbery_PT_M = 1000 * UCR_robbery_M /population_2013.
compute UCR_theft_PT_M = 1000 * UCR_theft_M /population_2013.
compute UCR_burglary_PT_M = 1000 * UCR_burglary_M /population_2013.
compute UCR_mvt_PT_M = 1000 * UCR_mvt_M /population_2013.
EXECUTE.
*violent and property.
compute UCR_VIOLENT_PT_M =1000* UCR_violent_M /population_2013.
compute UCR_PROPERTY_PT_M = 1000*UCR_property_m / population_2013.
EXECUTE.

*update ct10 crosswalk.
*open splits.
GET
  FILE='C:\Users\Jonathan Glick\Census data\SF1 2010\sf1_2010_splits.sav'.
DATASET NAME sf1_splits WINDOW=FRONT.
string town_key_c (a10).
string town_key_a (a10).
compute town_key_a = concat(state, county, place).
compute town_key_c = concat(state, county, "99",county).
recode town_key_c ('3600599005'='3600099000')('3604799047'='3600099000') ('3606199061'='3600099000')
 ('3608199081'='3600099000') ('3608599085'='3600099000').
recode town_key ('3402160915'='3402160900').
execute.

dataset activate ucr_sum_2014_new.
sort cases by town_key.
string town_key_c (a10).
string town_key_a (a10).
compute town_key_a = town_key.
compute town_key_c = town_key.
execute.

DATASET ACTIVATE sf1_splits.
sort cases by town_key_a.
MATCH FILES /FILE=*
  /TABLE='ucr_sum_2014_new'
  /BY town_key_a.
EXECUTE.
DATASET ACTIVATE sf1_splits.
sort cases by town_key.
MATCH FILES /FILE=*
  /TABLE='ucr_sum_2014_new'
  /RENAME (agency_key jurisdiction_pop_2013 town_key_a town_key_c = agency_town juris_town d2 d3) 
  /BY town_key
  /DROP=  d2 d3 .
EXECUTE.
DATASET ACTIVATE sf1_splits.
sort cases by town_key_c.
MATCH FILES /FILE=*
  /TABLE='ucr_sum_2014_new'
  /RENAME (agency_key jurisdiction_pop_2013 town_key_a town_key = agency_cou juris_cou d2 d3) 
  /BY town_key_c
  /DROP=  d2 d3 .
EXECUTE.

compute city_key=concat(char.substr(town_key_c,1,2),char.substr(town_key_c,6)).
if(juris_town >0) city_key=concat(char.substr(town_key_c,1,2),char.substr(town_key,6)).
if(jurisdiction_pop_2013>0) city_key=concat(char.substr(town_key_c,1,2),char.substr(town_key_a,6)).
execute.

*check if all places have coverage.
compute juris = 0.
if (max(jurisdiction_pop_2013,juris_town, juris_cou)>0) juris=1.
if(population_ct10>0 and p0010001=0)juris=1.
execute.

*aggregate by splits..
DATASET DECLARE city_SUM_SF1.
AGGREGATE
  /OUTFILE='city_SUM_SF1'
  /BREAK= city_key
   /p0010001=SUM(p0010001)
/P0020001       =SUM(P0020001       )
/P0020002       =SUM(P0020002       )
/P0020003       =SUM(P0020003       )
/P0020004       =SUM(P0020004       )
/P0020005=SUM(P0020005)
/P0120001       =SUM(P0120001       )
/P0120002       =SUM(P0120002       )
/P0120003       =SUM(P0120003       )
/P0120004       =SUM(P0120004       )
/P0120005       =SUM(P0120005       )
/P0120006       =SUM(P0120006       )
/P0120007       =SUM(P0120007       )
/P0120008       =SUM(P0120008       )
/P0120009       =SUM(P0120009       )
/P0120010       =SUM(P0120010       )
/P0120011       =SUM(P0120011       )
/P0120012       =SUM(P0120012       )
/P0120013       =SUM(P0120013       )
/P0120014       =SUM(P0120014       )
/P0120015       =SUM(P0120015       )
/P0120016       =SUM(P0120016       )
/P0120017       =SUM(P0120017       )
/P0120018       =SUM(P0120018       )
/P0120019       =SUM(P0120019       )
/P0120020       =SUM(P0120020       )
/P0120021       =SUM(P0120021       )
/P0120022       =SUM(P0120022       )
/P0120023       =SUM(P0120023       )
/P0120024       =SUM(P0120024       )
/P0120025       =SUM(P0120025       )
/P0120026       =SUM(P0120026       )
/P0120027       =SUM(P0120027       )
/P0120028       =SUM(P0120028       )
/P0120029       =SUM(P0120029       )
/P0120030       =SUM(P0120030       )
/P0120031       =SUM(P0120031       )
/P0120032       =SUM(P0120032       )
/P0120033       =SUM(P0120033       )
/P0120034       =SUM(P0120034       )
/P0120035       =SUM(P0120035       )
/P0120036       =SUM(P0120036       )
/P0120037       =SUM(P0120037       )
/P0120038       =SUM(P0120038       )
/P0120039       =SUM(P0120039       )
/P0120040       =SUM(P0120040       )
/P0120041       =SUM(P0120041       )
/P0120042       =SUM(P0120042       )
/P0120043       =SUM(P0120043       )
/P0120044       =SUM(P0120044       )
/P0120045       =SUM(P0120045       )
/P0120046       =SUM(P0120046       )
/P0120047       =SUM(P0120047       )
/P0120048       =SUM(P0120048       )
/P0120049=SUM(P0120049)
/P0160001       =SUM(P0160001       )
/P0180001       =SUM(P0180001       )
/P0180002       =SUM(P0180002       )
/P0180003       =SUM(P0180003       )
/P0180004       =SUM(P0180004       )
/P0180005       =SUM(P0180005       )
/P0180006       =SUM(P0180006       )
/P0180007       =SUM(P0180007       )
/P0180008       =SUM(P0180008       )
/P0180009 =SUM(P0180009 )
/PCT0200001     =SUM(PCT0200001     )
/PCT0200002     =SUM(PCT0200002     )
/PCT0200003     =SUM(PCT0200003     )
/PCT0200004     =SUM(PCT0200004     )
/PCT0200005     =SUM(PCT0200005     )
/PCT0200006     =SUM(PCT0200006     )
/PCT0200007     =SUM(PCT0200007     )
/PCT0200008     =SUM(PCT0200008     )
/PCT0200009     =SUM(PCT0200009     )
/PCT0200010     =SUM(PCT0200010     )
/PCT0200011     =SUM(PCT0200011     )
/PCT0200012     =SUM(PCT0200012     )
/PCT0200013 =SUM(PCT0200013 )
/PCT0150001     =SUM(PCT0150001     )
/PCT0150002     =SUM(PCT0150002     )
/PCT0150003     =SUM(PCT0150003     )
/PCT0150004     =SUM(PCT0150004     )
/PCT0150005     =SUM(PCT0150005     )
/PCT0150006     =SUM(PCT0150006     )
/PCT0150007     =SUM(PCT0150007     )
/PCT0150008     =SUM(PCT0150008     )
/PCT0150009     =SUM(PCT0150009     )
/PCT0150010     =SUM(PCT0150010     )
/PCT0150011     =SUM(PCT0150011     )
/PCT0150012     =SUM(PCT0150012     )
/PCT0150013     =SUM(PCT0150013     )
/PCT0150014     =SUM(PCT0150014     )
/PCT0150015     =SUM(PCT0150015     )
/PCT0150016     =SUM(PCT0150016     )
/PCT0150017     =SUM(PCT0150017     )
/PCT0150018     =SUM(PCT0150018     )
/PCT0150019     =SUM(PCT0150019     )
/PCT0150020     =SUM(PCT0150020     )
/PCT0150021     =SUM(PCT0150021     )
/PCT0150022     =SUM(PCT0150022     )
/PCT0150023     =SUM(PCT0150023     )
/PCT0150024     =SUM(PCT0150024     )
/PCT0150025     =SUM(PCT0150025     )
/PCT0150026     =SUM(PCT0150026     )
/PCT0150027     =SUM(PCT0150027     )
/PCT0150028     =SUM(PCT0150028     )
/PCT0150029     =SUM(PCT0150029     )
/PCT0150030     =SUM(PCT0150030     )
/PCT0150031     =SUM(PCT0150031     )
/PCT0150032     =SUM(PCT0150032     )
/PCT0150033     =SUM(PCT0150033     )
/PCT0150034     =SUM(PCT0150034      )
/PCT0200022 =SUM(PCT0200022             )
/PCT0200023 =SUM(PCT0200023        )
/P0380001       =SUM(P0380001       )
/P0380002       =SUM(P0380002       )
/P0380003       =SUM(P0380003       )
/P0380004       =SUM(P0380004       )
/P0380005       =SUM(P0380005       )
/P0380006       =SUM(P0380006       )
/P0380007       =SUM(P0380007       )
/P0380008       =SUM(P0380008       )
/P0380009       =SUM(P0380009       )
/P0380010       =SUM(P0380010       )
/P0380011       =SUM(P0380011       )
/P0380012       =SUM(P0380012       )
/P0380013       =SUM(P0380013       )
/P0380014       =SUM(P0380014       )
/P0380015       =SUM(P0380015       )
/P0380016       =SUM(P0380016       )
/P0380017       =SUM(P0380017       )
/P0380018       =SUM(P0380018       )
/P0380019       =SUM(P0380019       )
/P0380020=SUM(P0380020)
/PCT0140001     =SUM(PCT0140001     )
/PCT0140002     =SUM(PCT0140002     )
/PCT0140003               =SUM(PCT0140003               )
/H0030001       =SUM(H0030001       )
/H0030002       =SUM(H0030002       )
/H0030003=SUM(H0030003)
/H0040001       =SUM(H0040001       )
/H0040002       =SUM(H0040002       )
/H0040003       =SUM(H0040003       )
/H0040004=SUM(H0040004)
/H0050001       =SUM(H0050001       )
/H0050002       =SUM(H0050002       )
/H0050003       =SUM(H0050003       )
/H0050004       =SUM(H0050004       )
/H0050005       =SUM(H0050005       )
/H0050006       =SUM(H0050006       )
/H0050007       =SUM(H0050007       )
/H0050008          =SUM(H0050008          ).
dataset activate city_sum_sf1.
string ct10_key (a11).
compute ct10_key = city_key.
execute.

dataset activate sf1_splits.

*aggregate by splits..
DATASET DECLARE split10_SUM_SF1.
AGGREGATE
  /OUTFILE='split10_SUM_SF1'
  /BREAK= city_key ct10_key
   /p0010001=SUM(p0010001)
/P0020001       =SUM(P0020001       )
/P0020002       =SUM(P0020002       )
/P0020003       =SUM(P0020003       )
/P0020004       =SUM(P0020004       )
/P0020005=SUM(P0020005)
/P0120001       =SUM(P0120001       )
/P0120002       =SUM(P0120002       )
/P0120003       =SUM(P0120003       )
/P0120004       =SUM(P0120004       )
/P0120005       =SUM(P0120005       )
/P0120006       =SUM(P0120006       )
/P0120007       =SUM(P0120007       )
/P0120008       =SUM(P0120008       )
/P0120009       =SUM(P0120009       )
/P0120010       =SUM(P0120010       )
/P0120011       =SUM(P0120011       )
/P0120012       =SUM(P0120012       )
/P0120013       =SUM(P0120013       )
/P0120014       =SUM(P0120014       )
/P0120015       =SUM(P0120015       )
/P0120016       =SUM(P0120016       )
/P0120017       =SUM(P0120017       )
/P0120018       =SUM(P0120018       )
/P0120019       =SUM(P0120019       )
/P0120020       =SUM(P0120020       )
/P0120021       =SUM(P0120021       )
/P0120022       =SUM(P0120022       )
/P0120023       =SUM(P0120023       )
/P0120024       =SUM(P0120024       )
/P0120025       =SUM(P0120025       )
/P0120026       =SUM(P0120026       )
/P0120027       =SUM(P0120027       )
/P0120028       =SUM(P0120028       )
/P0120029       =SUM(P0120029       )
/P0120030       =SUM(P0120030       )
/P0120031       =SUM(P0120031       )
/P0120032       =SUM(P0120032       )
/P0120033       =SUM(P0120033       )
/P0120034       =SUM(P0120034       )
/P0120035       =SUM(P0120035       )
/P0120036       =SUM(P0120036       )
/P0120037       =SUM(P0120037       )
/P0120038       =SUM(P0120038       )
/P0120039       =SUM(P0120039       )
/P0120040       =SUM(P0120040       )
/P0120041       =SUM(P0120041       )
/P0120042       =SUM(P0120042       )
/P0120043       =SUM(P0120043       )
/P0120044       =SUM(P0120044       )
/P0120045       =SUM(P0120045       )
/P0120046       =SUM(P0120046       )
/P0120047       =SUM(P0120047       )
/P0120048       =SUM(P0120048       )
/P0120049=SUM(P0120049)
/P0160001       =SUM(P0160001       )
/P0180001       =SUM(P0180001       )
/P0180002       =SUM(P0180002       )
/P0180003       =SUM(P0180003       )
/P0180004       =SUM(P0180004       )
/P0180005       =SUM(P0180005       )
/P0180006       =SUM(P0180006       )
/P0180007       =SUM(P0180007       )
/P0180008       =SUM(P0180008       )
/P0180009 =SUM(P0180009 )
/PCT0200001     =SUM(PCT0200001     )
/PCT0200002     =SUM(PCT0200002     )
/PCT0200003     =SUM(PCT0200003     )
/PCT0200004     =SUM(PCT0200004     )
/PCT0200005     =SUM(PCT0200005     )
/PCT0200006     =SUM(PCT0200006     )
/PCT0200007     =SUM(PCT0200007     )
/PCT0200008     =SUM(PCT0200008     )
/PCT0200009     =SUM(PCT0200009     )
/PCT0200010     =SUM(PCT0200010     )
/PCT0200011     =SUM(PCT0200011     )
/PCT0200012     =SUM(PCT0200012     )
/PCT0200013 =SUM(PCT0200013 )
/PCT0150001     =SUM(PCT0150001     )
/PCT0150002     =SUM(PCT0150002     )
/PCT0150003     =SUM(PCT0150003     )
/PCT0150004     =SUM(PCT0150004     )
/PCT0150005     =SUM(PCT0150005     )
/PCT0150006     =SUM(PCT0150006     )
/PCT0150007     =SUM(PCT0150007     )
/PCT0150008     =SUM(PCT0150008     )
/PCT0150009     =SUM(PCT0150009     )
/PCT0150010     =SUM(PCT0150010     )
/PCT0150011     =SUM(PCT0150011     )
/PCT0150012     =SUM(PCT0150012     )
/PCT0150013     =SUM(PCT0150013     )
/PCT0150014     =SUM(PCT0150014     )
/PCT0150015     =SUM(PCT0150015     )
/PCT0150016     =SUM(PCT0150016     )
/PCT0150017     =SUM(PCT0150017     )
/PCT0150018     =SUM(PCT0150018     )
/PCT0150019     =SUM(PCT0150019     )
/PCT0150020     =SUM(PCT0150020     )
/PCT0150021     =SUM(PCT0150021     )
/PCT0150022     =SUM(PCT0150022     )
/PCT0150023     =SUM(PCT0150023     )
/PCT0150024     =SUM(PCT0150024     )
/PCT0150025     =SUM(PCT0150025     )
/PCT0150026     =SUM(PCT0150026     )
/PCT0150027     =SUM(PCT0150027     )
/PCT0150028     =SUM(PCT0150028     )
/PCT0150029     =SUM(PCT0150029     )
/PCT0150030     =SUM(PCT0150030     )
/PCT0150031     =SUM(PCT0150031     )
/PCT0150032     =SUM(PCT0150032     )
/PCT0150033     =SUM(PCT0150033     )
/PCT0150034     =SUM(PCT0150034      )
/PCT0200022 =SUM(PCT0200022             )
/PCT0200023 =SUM(PCT0200023        )
/P0380001       =SUM(P0380001       )
/P0380002       =SUM(P0380002       )
/P0380003       =SUM(P0380003       )
/P0380004       =SUM(P0380004       )
/P0380005       =SUM(P0380005       )
/P0380006       =SUM(P0380006       )
/P0380007       =SUM(P0380007       )
/P0380008       =SUM(P0380008       )
/P0380009       =SUM(P0380009       )
/P0380010       =SUM(P0380010       )
/P0380011       =SUM(P0380011       )
/P0380012       =SUM(P0380012       )
/P0380013       =SUM(P0380013       )
/P0380014       =SUM(P0380014       )
/P0380015       =SUM(P0380015       )
/P0380016       =SUM(P0380016       )
/P0380017       =SUM(P0380017       )
/P0380018       =SUM(P0380018       )
/P0380019       =SUM(P0380019       )
/P0380020=SUM(P0380020)
/PCT0140001     =SUM(PCT0140001     )
/PCT0140002     =SUM(PCT0140002     )
/PCT0140003               =SUM(PCT0140003               )
/H0030001       =SUM(H0030001       )
/H0030002       =SUM(H0030002       )
/H0030003=SUM(H0030003)
/H0040001       =SUM(H0040001       )
/H0040002       =SUM(H0040002       )
/H0040003       =SUM(H0040003       )
/H0040004=SUM(H0040004)
/H0050001       =SUM(H0050001       )
/H0050002       =SUM(H0050002       )
/H0050003       =SUM(H0050003       )
/H0050004       =SUM(H0050004       )
/H0050005       =SUM(H0050005       )
/H0050006       =SUM(H0050006       )
/H0050007       =SUM(H0050007       )
/H0050008          =SUM(H0050008          ).
dataset activate split10_sum_sf1.

ADD FILES /FILE=*
  /FILE='city_SUM_SF1'.
EXECUTE.
dataset close city_sum_sf1.

COMPUTE PCTAGE_0_4 = 100 * (P0120003+P0120027)/P0120001.         
COMPUTE PCTAGE_5_17 = 100 * (P0120004+P0120005+P0120006+P0120028+P0120029+P0120030)/P0120001.     
COMPUTE PCTAGE_18_24 = 100 * (P0120007+P0120008+P0120009+P0120010+P0120031+P0120032+P0120033+P0120034) /   P0120001.     
COMPUTE PCTAGE_25_34 = 100 * (P0120011+P0120012+P0120035+P0120036) /   P0120001.                  
COMPUTE PCTAGE_35_54 = 100 * (P0120015+P0120016+P0120013+P0120014+P0120039+P0120040+P0120037+P0120038) /   P0120001. 
COMPUTE PCTAGE_55_64 = 100 * (P0120017+P0120018+P0120019+P0120041+P0120042+P0120043) /   P0120001.  
COMPUTE HOUSEHOLD = p0180001.
COMPUTE POPULATION = P0010001.
COMPUTE PCTAGE_0_17 = 100 * (P0120003+P0120004+P0120005+P0120006+P0120027+P0120028+P0120029+P0120030)/P0120001.              
COMPUTE PCTAGE_18_29_MALE = 100 * (P0120007+P0120008+P0120009+P0120010+P0120011) /   P0120001.     
COMPUTE PCTAGE_18_29 = 100 * (P0120007+P0120008+P0120009+P0120010+P0120011+P0120031+P0120032+P0120033+P0120034+P0120035) /   P0120001.     
COMPUTE PCTAGE_30_44 = 100 * (P0120012+P0120013+P0120014+P0120036+P0120037+P0120038) /   P0120001.                  
COMPUTE PCTAGE_45_64 = 100 * (P0120015+P0120016+P0120017+P0120018+P0120019+P0120039+P0120040+P0120041+P0120042+P0120043) /   P0120001.             
COMPUTE PCTAGE_65_UP = 100 * (P0120020+P0120021+P0120022+P0120023+P0120024+P0120025+P0120044+P0120045+P0120046+P0120047+P0120048+P0120049  ) /   P0120001.        
COMPUTE AVG_HHSIZE = P0160001  /   P0180001.
COMPUTE IN_HOUSEHOLD_PCT = 100 * P0160001   /    P0010001.
COMPUTE INCARC_PCT = 100 * (PCT0200003+PCT0200013)  /   P0010001.
COMPUTE PCTAGE_0_4 = 100 * (P0120003+P0120027)/P0120001.   
compute DORMS_PCT = 100 * PCT0200022    /   P0010001.
compute BASE_PCT = 100 * PCT0200023     /   P0010001. 
EXECUTE.
*define pseudo households for non-correnctional group housing - make proportional to the percent of population in this type of housing.
COMPUTE GROUP_PHH_PCT   = 100* (PCT0200001 - PCT0200003 -PCT0200013)/   P0010001.  
*add group pseudo households to the denominator of other houshold types.
COMPUTE ALONE_PCT = 100  * ( P0180008  /   P0180001) * (p0160001 / p0010001).
COMPUTE NONFAM_PCT = 100  * ( P0180007  /   P0180001) * (p0160001 / p0010001).
COMPUTE MARWKIDS_PCT = 100  * ( P0380003   /   P0180001) * (p0160001 / p0010001).
COMPUTE SINGLEMOM_PCT = 100 * ((P0380016) / P0180001)  * (p0160001 / p0010001).   
COMPUTE SINGLEDAD_PCT = 100 * ((P0380010) /   P0180001) * (p0160001 / p0010001).
compute SAMESEX_PCT = 100 * ((PCT0150014+PCT0150024) /   P0180001) * (p0160001 / p0010001).
compute OPPSEX_PCT = 100 * ((PCT0150019+PCT0150029) /   pct0150001) * (p0160001 / p0010001).
compute single_par_pct = singlemom_pct + singledad_pct.
execute.
compute SAMESEXWKIDS_PCT = 100 * ((PCT0150015+PCT0150025) /   P0180001) * (p0160001 / p0010001).
cOMPUTE MULTIGEN_PCT = 100 * (PCT0140002  /    P0180001) * (p0160001 / p0010001).
COMPUTE VACANT_PCT = 100 * H0030003 / H0030001  * (p0160001 / p0010001).
COMPUTE SEASONAL_PCT = 100 * H0050006 /  H0030001  * (p0160001 / p0010001).
*add psedo households to denominator for tenure.
COMPUTE OWN_PCT = 100 *  (H0040002+H0040003)/ H0040001 * (p0160001 / p0010001).
COMPUTE  RNT_PCT =   100 *  ((H0040004/ H0040001) * (p0160001 / p0010001) + (PCT0200001 - PCT0200003 -PCT0200013)/   P0010001).
COMPUTE OWNCLEAR_PCT = 100 * H0040003/ H0040001* (p0160001 / p0010001).

execute.

DATASET ACTIVATE split10_SUM_SF1.
AGGREGATE
  /OUTFILE=* MODE=ADDVARIABLES
  /BREAK=ct10_key
  /POPULATION_ct10=sum(POPULATION).

SELECT IF (POPULATION > 0 | POPULATION_ct10 = 0).
EXECUTE.

MATCH FILES /file=*
/keep city_key ct10_key   PCTAGE_0_4	PCTAGE_5_17	PCTAGE_18_24	PCTAGE_25_34	PCTAGE_35_54	PCTAGE_55_64
	HOUSEHOLD	POPULATION	PCTAGE_0_17	PCTAGE_18_29_MALE	PCTAGE_18_29	PCTAGE_30_44
	PCTAGE_45_64	PCTAGE_65_UP	AVG_HHSIZE	IN_HOUSEHOLD_PCT	INCARC_PCT	DORMS_PCT
	BASE_PCT	GROUP_PHH_PCT	ALONE_PCT	NONFAM_PCT	MARWKIDS_PCT	SINGLEMOM_PCT
	SINGLEDAD_PCT	SAMESEX_PCT	OPPSEX_PCT	single_par_pct	SAMESEXWKIDS_PCT	MULTIGEN_PCT
	VACANT_PCT	SEASONAL_PCT	OWN_PCT	RNT_PCT	OWNCLEAR_PCT		POPULATION_ct10.
execute.

*VI.
GET
  FILE='C:\Users\Jonathan Glick\Documents\Dropbox (Location, Inc.)\Census Update\VI_SF.sav'.
DATASET NAME VI_data WINDOW=FRONT.

select if(length(rtrim(bg10_key))=0 and char.substr(city_key,1,2)='78' and year= 2013).
execute.

MATCH FILES /file=*
/keep city_key ct10_key   PCTAGE_0_4	PCTAGE_5_17	PCTAGE_18_24	PCTAGE_25_34	PCTAGE_35_54	PCTAGE_55_64
	HOUSEHOLD	POPULATION	PCTAGE_0_17	PCTAGE_18_29_MALE	PCTAGE_18_29	PCTAGE_30_44
	PCTAGE_45_64	PCTAGE_65_UP	AVG_HHSIZE	IN_HOUSEHOLD_PCT	INCARC_PCT	DORMS_PCT
	BASE_PCT	GROUP_PHH_PCT	ALONE_PCT	NONFAM_PCT	MARWKIDS_PCT	SINGLEMOM_PCT
	SINGLEDAD_PCT		
	VACANT_PCT	SEASONAL_PCT	OWN_PCT	RNT_PCT	OWNCLEAR_PCT		.
execute.
compute population_ct10 = population.
if(length(rtrim(ct10_key))=0) ct10_key = city_key.
execute.

dataset activate split10_sum_sf1.
ADD FILES /FILE=*
  /FILE='VI_data'.
EXECUTE.
dataset close vi_data.

sort cases by city_key.
MATCH FILES /FILE=*
  /TABLE='UCR_MUNI_SUM'
  /BY city_key.
EXECUTE.

SAVE OUTFILE='C:\Users\Jonathan Glick\Documents\Dropbox\Crime\2014\all_variate.sav'
  /COMPRESSED.
dataset close sf1_splits.

