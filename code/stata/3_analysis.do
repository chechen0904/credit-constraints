import delimited "/Users/chenche/Documents/workspace/credit-constraints/data/derived/processed_chfs_data.csv", clear 

*Descriptive Statistics
tabstat log_stock_assets credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, s(n mean sd min max) c(s) f(%6.2f)

/*
If you want to know the proportion of households with stock holdings, you need to run the following codes:
gen stock_ownership = 1
replace stock_ownership = 0 if stock_assets == 0
and then add to summarize
*/

outreg2 using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table2.doc, replace sum(log) keep(log_stock_assets credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets) title(Decriptive statistics)

*OLS regression
reg log_stock_assets credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration, robust
est store model1
reg log_stock_assets credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness, robust
est store model2
reg log_stock_assets credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, robust
est store model3
reg log_stock_assets supply_side_credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, robust
est store model4
reg log_stock_assets demand_side_credit_constraints age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, robust
est store model5
outreg2 [model1 model2 model3 model4 model5] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table3a.doc,replace

/* Code for the sub-sample | Table 3b
drop if own_house == 1
reg log_stock_assets credit_constraints age age2 gender married health unemployment education_level family_size rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, robust
est store model1
reg log_stock_assets supply_side_credit_constraints age age2 gender married health unemployment education_level family_size rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, robust
est store model2
reg log_stock_assets demand_side_credit_constraints age age2 gender married health unemployment education_level family_size rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, robust
est store model3
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r
est store model4
outreg2 [model1 model2 model3 model4] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table3b.doc,replace
*/

*2SLS Regression
reg credit_constraints bank_density age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r 
est store first
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r 
est store second
outreg2 [first second] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table4a.doc,replace

ivregress 2sls stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r
est store tsls
outreg2 [tsls] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table4b.doc,replace

*Mechanism analysis
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration, r
est store m1
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern, r
est store m2
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration risk_preference, r
est store m3
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration happiness, r
est store m4
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration log_income, r
est store m5
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration log_assets, r
est store m6
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r
est store m7
outreg2 [m1 m2 m3 m4 m5 m6 m7] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table5.doc,replace

*Check the relationship between credit constraints and household total assets
pwcorr log_stock_assets credit_constraints, sig

*Test

*F test
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r
estat first 

*Durbin-Wu-Huasman test
estat endogenous

*Robustness check
*Probit-ols twostep model for supply- and demand-side credit constraints
probit supply_side_credit_constraints bank_density, r
predict y_hat, xb
gen pdf = normalden(y_hat)
gen cdf = normal(y_hat)
gen imr1 = pdf/cdf 
gen imr2 = (-pdf) / (1 - cdf)
gen imr = imr1 
replace imr = imr2 if supply_side_credit_constraints == 0
reg log_stock_assets age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets supply_side_credit_constraints imr, r
est store pomodel1
probit demand_side_credit_constraints bank_density, r
predict y_hat2, xb
gen pdf2 = normalden(y_hat2)
gen cdf2 = normal(y_hat2)
gen imr1m2 = pdf2/cdf2
gen imr2m2 = (-pdf2) / (1 - cdf2)
gen imrm2 = imr1m2
replace imrm2 = imr2m2 if demand_side_credit_constraints == 0
reg log_stock_assets age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets demand_side_credit_constraints imrm2, r
est store pomodel2
outreg2 [pomodel1 pomodel2] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table9.doc,replace

*Install the commond:ssc install winsor2
*Winsorize the top 1% and bottom 1% of data points
winsor2 age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets credit_constraints log_stock_assets, replace
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration, r
est store m1
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern, r
est store m2
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration risk_preference, r
est store m3
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration happiness, r
est store m4
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration log_income, r
est store m5
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration log_assets, r
est store m6
ivregress 2sls log_stock_assets (credit_constraints = bank_density) age age2 gender married health unemployment education_level family_size own_house rural_household_registration econ_fin_info_concern risk_preference happiness log_income log_assets, r
est store m7
outreg2 [m1 m2 m3 m4 m5 m6 m7] using /Users/chenche/Documents/workspace/credit-constraints/Outputs/table8.doc,replace
