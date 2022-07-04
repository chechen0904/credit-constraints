*Import 2017 CHFS data
import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2017.csv", clear

*Generate variables
gen age = 2017 - a2005
*Calculate the total number of family members 
bys hhid_2017: egen hrnumber = max(pline)
replace a1111 = 0 if a1111 == .
gen family_member_number = hrnumber + a1111
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
rename d3109 stock_values
*Generate variable of health, higher value means healthier
gen health = .
replace health = 4 if a2025b == 1
replace health = 3 if a2025b == 2
replace health = 2 if a2025b == 3
replace health = 1 if a2025b == 4
replace health = 0 if a2025b == 5
*Generate dummy variable of unemployment
gen unemployment = 0
replace unemployment = 1 if a3131 == 1 | a3131 == 4 | a3131 == 5 | a3131 == 7
*Generate dummy variable of house, 0 means no house, 1 is the converse case
gen own_house = .
replace own_house = 1 if c2001 == 1 | c2002 > 0 | c2001b ==1
replace own_house = 0 if c2001 == 2
*Generate dummy variable of happiness
gen happiness = .
replace happiness = 3 if h3514 == 1 
replace happiness = 2 if h3514 == 2 
replace happiness = 1 if h3514 == 3
replace happiness = 0 if h3514 == 4
*Generate dummy variable of rural household registration
gen rural_household_registration = .
replace rural_household_registration = 1 if a2022 == 1
replace rural_household_registration = 0 if a2022 != 1
*Generate dummy variable of credit constraints
gen credit_constraints = 0
replace credit_constraints = 1 if b3057b_2_1_mc == 1 | b3057b_2_3_mc == 1 | e3006a == 1 | e3005dc_1 == 1 | e3005dc_1 == 3 | e3005dc_2 == 1 | e3005dc_2 == 3 | e3005dc_3 == 1 | e3005dc_3 == 3 | e3005dc_4 == 1 | e3005dc_4 == 3 | e3005dc_5 == 1 | e3005dc_5 == 3 | e3005dc_6 == 1 | e3005dc_6 == 3 | e3005dc_7 == 1 | e3005dc_7 == 3 | e3005dc_8 == 1 | e3005dc_8 == 3 
*Generate dummy variable of credit constraints - supply side
gen supply_side_credit_constraints = 0
replace supply_side_credit_constraints = 1 if b3057b_2_1_mc == 1 | e3006a == 1 | e3005dc_1 == 1 | e3005dc_2 == 1 | e3005dc_3 == 1 | e3005dc_4 == 1 | e3005dc_5 == 1 | e3005dc_6 == 1 | e3005dc_7 == 1 | e3005dc_8 == 1 
*Generate dummy variable of credit constraints - demand side
gen demand_side_credit_constraints = 0
replace demand_side_credit_constraints = 1 if b3057b_2_3_mc == 1 | e3005dc_1 == 3 | e3005dc_2 == 3 | e3005dc_3 == 3 | e3005dc_4 == 3 | e3005dc_5 == 3 | e3005dc_6 == 3 | e3005dc_7 == 3 | e3005dc_8 == 3 
*Generate variable of financial literacy, higher value means higher concerns
gen econ_fin_info_concern = .
replace econ_fin_info_concern = 4 if h3101 == 1 
replace econ_fin_info_concern = 3 if h3101 == 2 
replace econ_fin_info_concern = 2 if h3101 == 3 
replace econ_fin_info_concern = 1 if h3101 == 4 
replace econ_fin_info_concern = 0 if h3101 == 5 
*Generate dummy variable of investment risk preference
gen risk_preference = .
replace risk_preference = 0 if h3104 == 5 
replace risk_preference = 1 if h3104 == 4 
replace risk_preference = 2 if h3104 == 3 
replace risk_preference = 3 if h3104 == 2
replace risk_preference = 4 if h3104 == 1
*Select variables 
keep hhid hhid_2011 hhid_2013 hhid_2015 hhid_2017 pline hhead age gender family_member_number education_level married health unemployment own_house happiness rural_household_registration credit_constraints supply_side_credit_constraints demand_side_credit_constraints econ_fin_info_concern risk_preference stock_account stock_values total_income total_consump total_asset total_debt prov_code
*Export 2017 CHFS data
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2017data", replace


*Import 2015 CHFS data
import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2015.csv", clear
*Generate variable of financial literacy, higher value means higher concerns
gen econ_fin_info_concern_2015 = .
replace econ_fin_info_concern_2015 = 4 if a4002a == 1 
replace econ_fin_info_concern_2015 = 3 if a4002a == 2 
replace econ_fin_info_concern_2015 = 2 if a4002a == 3 
replace econ_fin_info_concern_2015 = 1 if a4002a == 4 
replace econ_fin_info_concern_2015 = 0 if a4002a == 5 
*Generate dummy variable of risk preference
gen risk_preference_2015 = .
replace risk_preference_2015 = 4 if a4003 == 1 
replace risk_preference_2015 = 3 if a4003 == 2 
replace risk_preference_2015 = 2 if a4003 == 3 
replace risk_preference_2015 = 1 if a4003 == 4 
replace risk_preference_2015 = 0 if a4003 == 5
*Select variables
keep hhid_2015 econ_fin_info_concern_2015 risk_preference_2015
*Export 2015 CHFS data
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2015data.csv", replace


*Import 2013 CHFS data
import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2013.csv", clear
*Generate variable of financial literacy, higher value means higher concerns
gen econ_fin_info_concern_2013 = .
replace econ_fin_info_concern_2013 = 4 if a4002a == 1 
replace econ_fin_info_concern_2013 = 3 if a4002a == 2 
replace econ_fin_info_concern_2013 = 2 if a4002a == 3 
replace econ_fin_info_concern_2013 = 1 if a4002a == 4 
replace econ_fin_info_concern_2013 = 0 if a4002a == 5 
*Generate dummy variable of risk preference
gen risk_preference_2013 = .
replace risk_preference_2013 = 4 if a4003 == 1 
replace risk_preference_2013 = 3 if a4003 == 2 
replace risk_preference_2013 = 2 if a4003 == 3 
replace risk_preference_2013 = 1 if a4003 == 4 
replace risk_preference_2013 = 0 if a4003 == 5
*Select variables
keep hhid_2013 econ_fin_info_concern_2013 risk_preference_2013
*Export 2013 CHFS data
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2013data.csv", replace


*Import 2011 CHFS data
import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2011.csv", clear
*Generate dummy variable of risk preference
gen risk_preference_2011 = .
replace risk_preference_2011 = 4 if a4003 == 1 
replace risk_preference_2011 = 3 if a4003 == 2 
replace risk_preference_2011 = 2 if a4003 == 3 
replace risk_preference_2011 = 1 if a4003 == 4 
replace risk_preference_2011 = 0 if a4003 == 5
*Rename the household id
rename hhid hhid_2011
*Select variables
keep hhid_2011 risk_preference_2011
*Export 2011 CHFS data
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2011data.csv", replace
