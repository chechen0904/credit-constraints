import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/processed_chfs_data.csv", clear 

*Descriptive Statistics
summarize age age2 gender married health unemployment education_level family_member_number own_house rural_household_registration econ_fin_info_concern risk_preference happiness total_income total_consump total_asset total_debt credit_constraints share_of_stock_asset

*OLS regression
reg share_of_stock_asset credit_constraints age age2 gender married health unemployment education_level family_member_number own_house rural_household_registration econ_fin_info_concern risk_preference happiness total_income total_consump total_asset total_debt

*2SLS Regression
ivregress 2sls share_of_stock_asset (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_member_number own_house rural_household_registration econ_fin_info_concern risk_preference happiness total_income total_consump total_asset total_debt, first

*F test
estat first
