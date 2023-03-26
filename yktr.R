 
# yktr

# make also: 
# FIX: create basic yktr: DYR_INFO, BES_INFO, PARITY, CALVING_DATE, DIM
# To add to various data, to get overview of what happens in each lactation phase

# maybe get df5 ???? The one we already have used for various stuff.
# Check script where it is..

# distribution:
## milk
## SCC
## fat, proteins etc




# 11 controls per year.

# basic cleaning: Keeping pos controls and only from 2010
production <- yktr %>%
  dplyr::select(DYR_ID, BES_ID, KONTROLDATO, CELLETAL, KGMAELK) %>%
  drop_na() %>%
  filter(CELLETAL > 0) %>%
  filter(KGMAELK > 0) %>%
  filter(KGMAELK < 100) %>%
  filter(KONTROLDATO > as.Date("2009-12-31"))

# descriptives:
summary(yktr)
dplyr::n_distinct(yktr$DYR_ID)  # 2.609.380 unique animals
dplyr::n_distinct(yktr$BES_ID)  # 3942 

