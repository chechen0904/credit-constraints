use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2011_hh.dta", clear
merge 1:m hhid using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2011_ind.dta, nogen

*Generate dummy variable of risk preference
gen risk_preference_2011 = .
replace risk_preference_2011 = 4 if a4003 == 1 
replace risk_preference_2011 = 3 if a4003 == 2 
replace risk_preference_2011 = 2 if a4003 == 3 
replace risk_preference_2011 = 1 if a4003 == 4 
replace risk_preference_2011 = 0 if a4003 == 5

rename hhid hhid_2011

keep hhid_2011 risk_preference_2011
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2011data.csv", replace


use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2013_hh.dta", clear
merge 1:m hhid_2013 using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2013_ind.dta, nogen

*Generate variable of financial literacy, higher value means higher concerns
gen financial_literacy_2013 = .
replace financial_literacy_2013 = 4 if a4002a == 1 
replace financial_literacy_2013 = 3 if a4002a == 2 
replace financial_literacy_2013 = 2 if a4002a == 3 
replace financial_literacy_2013 = 1 if a4002a == 4 
replace financial_literacy_2013 = 0 if a4002a == 5 
*Generate dummy variable of risk preference
gen risk_preference_2013 = .
replace risk_preference_2013 = 4 if a4003 == 1 
replace risk_preference_2013 = 3 if a4003 == 2 
replace risk_preference_2013 = 2 if a4003 == 3 
replace risk_preference_2013 = 1 if a4003 == 4 
replace risk_preference_2013 = 0 if a4003 == 5

keep hhid_2013 financial_literacy_2013 risk_preference_2013
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2013data.csv", replace


use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2015_hh.dta", clear
merge 1:m hhid_2015 using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2015_ind.dta, nogen

*Generate variable of financial literacy, higher value means higher concerns
gen financial_literacy_2015 = .
replace financial_literacy_2015 = 4 if a4002a == 1 
replace financial_literacy_2015 = 3 if a4002a == 2 
replace financial_literacy_2015 = 2 if a4002a == 3 
replace financial_literacy_2015 = 1 if a4002a == 4 
replace financial_literacy_2015 = 0 if a4002a == 5 
*Generate dummy variable of risk preference
gen risk_preference_2015 = .
replace risk_preference_2015 = 4 if a4003 == 1 
replace risk_preference_2015 = 3 if a4003 == 2 
replace risk_preference_2015 = 2 if a4003 == 3 
replace risk_preference_2015 = 1 if a4003 == 4 
replace risk_preference_2015 = 0 if a4003 == 5

keep hhid_2015 financial_literacy_2015 risk_preference_2015
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs2015data.csv", replace
