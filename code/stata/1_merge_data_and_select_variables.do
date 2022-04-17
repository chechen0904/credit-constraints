use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2017_hh.dta", clear
merge 1:m hhid using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2017_ind.dta, nogen
merge 1:1 hhid pline using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2017_master.dta, nogen

gen age = 2017 - a2005
gen age2 = age*age
*Calculate the total number of family members 
bys hhid_2017: egen hrnumber = max(pline)
replace a1111 = 0 if a1111 == .
gen family_member_number = hrnumber + a1111
*Calculate siblings numbers
gen siblings = a2028 + a2029
*Gender variable. Male if gender = 0, female if gender = 1
gen gender = .
replace gender = 0 if a2003 == 1
replace gender = 1 if a2003 == 2
rename a2012 education_level
*Dummy variable related with married, 1 means married, 0 means not married.
gen married = 0
replace married = 1 if a2024 == 2
*Stock-related variables
gen stock_account = .
replace stock_account = 1 if d3101 == 1
replace stock_account = 0 if d3101 == 2
rename d3103 stock_account_cash_balance
rename d3103it stock_account_cash_balance_scope
rename d3104 stock_numbers
rename d3109 stock_values
rename d3109it stock_values_scope
rename d3110 stock_investment
rename d3110it stock_investment_scope
*Generate variable of health, higher value means healthier
gen health = .
replace health = 4 if a2025b == 1
replace health = 3 if a2025b == 2
replace health = 2 if a2025b == 3
replace health = 1 if a2025b == 4
replace health = 0 if a2025b == 5
*Generate dummy variable of house, 0 means no house, 1 is the converse case
gen own_house = .
replace own_house = 1 if c2001 == 1 | c2002 > 0 | c2000_1 == 1 | c2000_2 == 1 | c2000_3 == 1 | c2001b ==1 | c2001ba > 0
replace own_house = 0 if c2001 == 2
*Generate dummy variable of happiness
gen happiness = .
replace happiness = 1 if h3514 == 1 | h3514 == 2
replace happiness = 0 if h3514 == 3 | h3514 == 4
*Generate dummy variable of rural household registration
gen rural_household_registration = .
replace rural_household_registration = 1 if a2022 == 1
replace rural_household_registration = 0 if a2022 != 1
*Generate dummy variable of credit constraints
gen credit_constraints = 0
replace credit_constraints = 1 if b3057b_2_1_mc == 1 | b3057b_2_3_mc == 1 | e3006a == 1 | e3005dc_1 == 1 | e3005dc_1 == 3 | e3005dc_2 == 1 | e3005dc_2 == 3 | e3005dc_3 == 1 | e3005dc_3 == 3 | e3005dc_4 == 1 | e3005dc_4 == 3 | e3005dc_5 == 1 | e3005dc_5 == 3 | e3005dc_1 == 6 | e3005dc_6 == 3 | e3005dc_7 == 1 | e3005dc_7 == 3 | e3005dc_8 == 1 | e3005dc_8 == 3 
*Generate variable of financial literacy, higher value means higher concerns
gen financial_literacy = .
replace financial_literacy = 4 if h3101 == 1 
replace financial_literacy = 3 if h3101 == 2 
replace financial_literacy = 2 if h3101 == 3 
replace financial_literacy = 1 if h3101 == 4 
replace financial_literacy = 0 if h3101 == 5 
*Generate dummy variable of risk preference
gen risk_preference = .
replace risk_preference = 1 if h3104 == 5 
replace risk_preference = 2 if h3104 == 4 
replace risk_preference = 3 if h3104 == 3 
replace risk_preference = 4 if h3104 == 2
replace risk_preference = 5 if h3104 == 1
*The following is about the variable of distance between home and financial institutions
rename d2110a distance
*Business-insurance-related variables
gen business_insurances = .
replace business_insurances = 1 if f6001a_7788_mc == 0
replace business_insurances = 0 if f6001a_7788_mc == 1

keep hhid hhid_2011 hhid_2013 hhid_2015 hhid_2017 pline hhead age age2 gender family_member_number siblings education_level married health own_house happiness rural_household_registration credit_constraints financial_literacy risk_preference distance stock_account stock_account_cash_balance stock_account_cash_balance_scope stock_numbers stock_values stock_values_scope stock_investment stock_investment_scope total_income total_consump total_asset total_debt business_insurances

export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2017data.csv", replace
