import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/processed_chfs_data.csv", clear 

*Descriptive Statistics
summarize age gender married health unemployment education_level family_member_number own_house rural_household_registration financial_literacy risk_preference happiness total_income total_consump total_asset total_debt credit_constraints stock_investment

*OLS regression
reg stock_investment credit_constraints age gender married health unemployment education_level family_member_number own_house rural_household_registration financial_literacy risk_preference happiness total_income total_consump total_asset total_debt

*2SLS Regression
ivregress 2sls stock_investment (credit_constraints = bank_density) age gender married health unemployment education_level family_member_number own_house rural_household_registration financial_literacy risk_preference happiness total_income total_consump total_asset total_debt, first

*F test
estat first
