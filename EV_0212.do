clear
import delimited "/Users/johnkim/EV_survey_0223.csv"

/*
summ car_commute if car_commute == 1 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
 car_commute |      1,016           1           0          1          1

summ carpool_commute if car_commute == 0 & carpool_commute ==1 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
carpool_co~e |          8           1           0          1          1

summ taxi_commute if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 1 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
taxi_commute |          7           1           0          1          1

summ rideshare_commute if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 1 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
rideshare_~e |          7           1           0          1          1

summ bus_commute  if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 1 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
 bus_commute |         13           1           0          1          1

summ train_commute   if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 1 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
train_comm~e |          4           1           0          1          1

summ bike_commute   if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 1 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
bike_commute |          5           1           0          1          1

summ micro_commute   if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 1 & walk_commute == 0 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
micro_comm~e |          5           1           0          1          1

summ walk_commute   if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 1 & subway_commute ==0 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
walk_commute |         31           1           0          1          1

summ subway_commute    if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==1 & other_commute == 0

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
subway_com~e |         11           1           0          1          1

summ other_commute     if car_commute == 0 & carpool_commute ==0 & taxi_commute  == 0 & rideshare_commute == 0 & bus_commute == 0 & train_commute == 0 & bike_commute == 0 & micro_commute == 0 & walk_commute == 0 & subway_commute ==0 & other_commute == 1

    Variable |        Obs        Mean    Std. dev.       Min        Max
-------------+---------------------------------------------------------
other_comm~e |         54           1           0          1          1

*/
tabulate race_code2, generate(race_)

rename race_1 hispanic_dummy
rename race_2 asian_dummy
rename race_3 black_dummy
rename race_4 native_dummy
rename race_5 other_race_dummy
rename race_6 two_race_dummy
rename race_7 white_dummy


tabulate ideo5, generate(political_)

*rename political_1 very_liberal
*rename political_2 liberal
*rename political_3 moderate
*rename political_4 conservative
*rename political_5 very_conservative
*rename political_6 no_affiliation


gen female = 0
replace female = 1 if gender4 == 2

tabulate new_income_cat2 , generate(income_)


rename income_1 High
rename income_2 Low
rename income_3 Low_Mid
rename income_4 Mid
rename income_5 Mid_high
rename income_6 Prefer_not_to_say
rename income_7 Very_high

svyset [pweight = weight]

gen other_race_dummy2 = other_race_dummy + native_dummy + two_race_dummy 

gen travel_mode_num = car_commute + carpool_commute + taxi_commute  + rideshare_commute + bus_commute + train_commute + bike_commute + micro_commute + walk_commute + subway_commute + other_commute

gen single_mod = 0

replace single_mod = 1 if travel_mode_num == 1
*(1,161 real changes made)

gen multi_mod = 0

replace multi_mod = 1 if travel_mode_num > 1
*(511 real changes made)

gen non_commuter = 0
replace non_commuter = 1 if single_mod + multi_mod == 0
*(1,230 real changes made)


gen income_mid = mid_high_income + mid_income
gen income_high = high_income + very_high_income 
gen income_low = low_income + mid_low_income 

gen income_mid2 = mid_income 
gen income_high2 = high_income + very_high_income + mid_high_income 

gen rideshare_commute2 = 0 
replace rideshare_commute2 = 1 if taxi_commute + rideshare_commute > 0

gen pubtrans_commute2 = 0
replace pubtrans_commute2 =1 if bus_commute + train_commute + subway_commute > 0

gen other_commute2 = 0
replace other_commute2 = 1 if other_commute + carpool_commute > 0

*replace num_auto = "." if num_auto == "NA"
destring num_auto, replace


svyset [pweight = weight]




svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income_high income_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female 

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income_high income_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female 

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income_high income_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female 



* with not sure category incorporated to moderate category + 3 income categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi_high hhi_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi_high hhi_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi_high == 1

outreg2 using evreg23feb.tex, append


svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi_low == 1


outreg2 using evreg23feb.tex, append


* with not sure category incorporated to moderate category + 4 income categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi2_high hhi2_low_moderate hhi2_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb2.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi2_high hhi2_low_moderate hhi2_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_high == 1

outreg2 using evreg23feb2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_mid == 1


outreg2 using evreg23feb2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_low_moderate == 1


outreg2 using evreg23feb2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_low == 1

outreg2 using evreg23feb2.tex, append




* with not sure category excluded + 3 income categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi_high hhi_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb3.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi_high hhi_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb3.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi_high == 1

outreg2 using evreg23feb3.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi_mid == 1

outreg2 using evreg23feb3.tex, append


svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi_low == 1


outreg2 using evreg23feb3.tex, append


* with not sure category excluded + 4 income categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi2_high hhi2_low_moderate hhi2_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb4.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint hhi2_high hhi2_low_moderate hhi2_low hhi_prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg23feb4.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_high == 1

outreg2 using evreg23feb4.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_mid == 1


outreg2 using evreg23feb4.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_low_moderate == 1


outreg2 using evreg23feb4.tex, append


svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if hhi2_low == 1

outreg2 using evreg23feb4.tex, append

* continuous household income
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female income_midpoint

outreg2 using evreg25feb24.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female income_midpoint

outreg2 using evreg25feb24.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female income_midpoint

outreg2 using evreg25feb24.tex, append

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female income_midpoint

outreg2 using evreg25feb24.tex, append


* Income category using family income and non-standardized
* Low income
gen income3_low = 0
replace income3_low = 1 if faminc_new == "10000 - 19999" |faminc_new == "20000 - 29999" | faminc_new =="30000 - 39999"

* Mid income
	gen income3_mid = 0

	replace income3_mid = 1 if faminc_new == "40000 - 49999" |faminc_new == "50000 - 59999" | faminc_new =="60000 - 69999"| faminc_new =="70000 - 79999" | faminc_new =="80000 - 99999"

* High income
	gen income3_high = 0

	replace income3_high = 1 if faminc_new == "100000 - 119999" |faminc_new == "120000 - 149999" | faminc_new =="150000 - 199999"| faminc_new =="200000 - 249999" | faminc_new =="250000 - 349999"| faminc_new =="350000 - 499999" | faminc_new =="500000 or more"

	
*** Using different specifics for low-income	
	gen income4_low = 0
replace income4_low = 1 if faminc_new == "10000 - 19999" |faminc_new == "20000 - 29999" | faminc_new =="30000 - 39999" |faminc_new == "40000 - 49999" 

* Mid income
	gen income4_mid = 0

	replace income4_mid = 1 if faminc_new == "50000 - 59999" | faminc_new =="60000 - 69999"| faminc_new =="70000 - 79999" | faminc_new =="80000 - 99999"

* High income
	gen income4_high = 0

	replace income4_high = 1 if faminc_new == "100000 - 119999" |faminc_new == "120000 - 149999" | faminc_new =="150000 - 199999"| faminc_new =="200000 - 249999" | faminc_new =="250000 - 349999"| faminc_new =="350000 - 499999" | faminc_new =="500000 or more"

* with not sure category incorporated to moderate category + income3 categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income3_high income3_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar.tex, replace

* ownership logit
svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income3_high income3_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income3_high == 1

outreg2 using evreg4mar.tex, append


svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income3_mid == 1


outreg2 using evreg4mar.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income3_low == 1


outreg2 using evreg4mar.tex, append


* with not sure category incorporated to moderate category + income4 categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income4_high income4_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar2.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income4_high income4_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income4_high == 1

outreg2 using evreg4mar2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income4_mid == 1


outreg2 using evreg4mar2.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con2 elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income4_low == 1


outreg2 using evreg4mar2.tex, append



* with not sure category excluded + income3 categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income3_high income3_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar3.tex, replace

* ownership logit
svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income3_high income3_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar3.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income3_high == 1

outreg2 using evreg4mar3.tex, append


svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income3_mid == 1


outreg2 using evreg4mar3.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income3_low == 1


outreg2 using evreg4mar3.tex, append


* with not sure category excluded + income4 categories
svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income4_high income4_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar4.tex, replace

svy: logit bevownership car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income4_high income4_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female

outreg2 using evreg4mar4.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income4_high == 1

outreg2 using evreg4mar4.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income4_mid == 1


outreg2 using evreg4mar4.tex, append

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female if income4_low == 1


outreg2 using evreg4mar4.tex, append
