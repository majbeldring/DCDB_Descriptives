

# FIX add yktr, as we only look at animals in milk production

# calvings 

str(kaelvninger) # kaelvedato format: POSIXc
dplyr::n_distinct(kaelvninger$DYR_ID)

# calvings per year:
calvings <- kaelvninger
calvings$KAELVEDATO = format(as.Date(calvings$KAELVEDATO, format='%Y-%m-%d'),'%Y') # only years
calvings_year <- subset(calvings, select = c(KAELVEDATO))
calvings_year <- stack(table(calvings_year))[2:1]
# renaming columns
calvings_year <- calvings_year %>%
  rename(
    year = ind,
    calving = values)

# calving outcome:

rm(calvings)
#rm(kaelvninger); gc()
