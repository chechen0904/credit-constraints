# credit-constraints
![](https://img.shields.io/badge/Language-Python|Stata-9cf.svg) 
![](https://img.shields.io/badge/Email-chen__che@student.ceu.edu-lightgrey.svg?style=social&logo=github)

## Author
- [Che CHEN](https://helloche.cc/)

# Data
## Source of the CHFS data
> [CHFS data source link](http://chfs.swufe.edu.cn "CHFS data source link")

## Source of the IV data
> [IV data link](https://github.com/chechen0904/credit-constraints/blob/main/data/raw/Bank_density_data.csv "IV data link")

Note: 

1. To access the CHFS data you need to apply with your real name and sign a contract after approval before you can use it.

2. The IV data `Bank_density_data.csv` is collected by myself. Please check the `process_data.ipynb` file, this file contains detail information for the IV data.

The data used in this study is from the China Household Financial Survey Project (CHFS) organized and managed by China Household Financial Survey and Research Center, Southwestern University of Finance and Economics. 


## Repository organization
```
credit-constraints                 # Project folder
├── code                           # Code folder for python and stata
|   ├── python    
|   ├── stata               
├── data                           # Data folder
|   ├── raw                        # Raw datas: 2017/2015/2013/2011 CHFS  
|   ├── derived                    # Derived data from running .do files or .ipynb file
├── results                        # Output files (Empty and will be used later)
└── README.md                                                 
```
The organization of this repository are shown above. 

1. I only focus on data from 2017 CHFS, and use data from other years mainly to solve some missing values issues.

2. Due to some derived data are too large, I didn't upload the `derived` folder, so you cannot it. However, you can get those in the `derived` folder by unzipping the data in the `raw` folder and running the code (remember: you need to create a `derived` folder within the `data` folder first).

## Order for running code files
1. 1_merge_data.do

2. 2_gen_and_select_variables.do

3. process_data.ipynb

4. 3_analysis.do

Note: I used absolute path in `.do` files, you need to change the path first if you want to replicate my results. `.ipynb` file used relative path, no need to change it. If you have any questions or suggestions, please feel free to contact me.

