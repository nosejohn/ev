clear
use "/Users/johnkim/Documents/study/gatech/research/EV/EV_0207.dta"

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

/*
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

replace num_auto = "." if num_auto == "NA"
destring num_auto, replace

*/

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income_high income_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female 

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income_high income_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female 

svy: reg bev_intent car_commute rideshare_commute2 pubtrans_commute2 bike_commute walk_commute micro_commute other_commute2 authorized_parking comm_charger_ex work_charger_ex dwelling3 homeownership_dummy2 num_auto milesmidpoint income_high income_low Prefer_not_to_say cost_and_charging_factor range_quality_factor fedtrust localgovtrust poli_con elecgasratio urban educ black_dummy hispanic_dummy asian_dummy other_race_dummy2 age female 
