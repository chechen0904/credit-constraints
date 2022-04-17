import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/processed_chfs_data.csv", clear 

*If you want to replicate the results in my report related to the original research idea, please run `process_rural_data.ipynb` first and then run the code below with * marks.
*egen mis = rowmiss(_all)
*drop if mis
*drop mis
*summarize stock_values distance education_level age age2 gender married family_member_number health own_house happiness credit_constraints financial_literacy risk_preference total_income total_consump total_asset total_debt
*ivregress 2sls stock_values (credit_constraints = distance) education_level total_income total_consump total_asset total_debt age age2 family_member_number gender married health own_house financial_literacy happiness risk_preference, first

*Descriptive Statistics
summarize education_level age age2 gender married siblings family_member_number health own_house rural_household_registration happiness credit_constraints financial_literacy risk_preference business_insurances total_income total_consump total_asset total_debt

*2SLS Regression
ivregress 2sls credit_constraints (education_level = siblings) total_income total_consump total_asset total_debt age age2 family_member_number gender married health own_house rural_household_registration financial_literacy happiness risk_preference, first
