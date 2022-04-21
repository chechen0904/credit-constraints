*Merge CHFS 2017 data
use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2017_hh.dta", clear
merge 1:m hhid using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2017_ind.dta, nogen
merge 1:1 hhid pline using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2017_master.dta, nogen
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2017.csv", replace

*Merge CHFS 2015 data
use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2015_hh.dta", clear
merge 1:m hhid_2015 using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2015_ind.dta, nogen
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2015.csv", replace

*Merge CHFS 2013 data
use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2013_hh.dta", clear
merge 1:m hhid_2013 using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2013_ind.dta, nogen
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2013.csv", replace

*Merge CHFS 2011 data
use "/Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2011_hh.dta", clear
merge 1:m hhid using /Users/chenche/Documents/workspace/credit-constraints/data/raw/chfs2011_ind.dta, nogen
export delimited using "/Users/chenche/Documents/workspace/credit-constraints/data/derived/chfs_2011.csv", replace
