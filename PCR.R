
# PCR

# Maybe just include last possible pcr data, where threshold is listed?

# FIX add coding from PCR paper
# FIX create table with how many positive over the years for the 16 pcr test
# FIX include threshold 32 and 37



# vetrespcr, vetresdyr, vetpcrkode, create:vetpcr

str(vetrespcr); str(vetresdyr); str(vetpcrkode) # udtagdato format: Date

# PCR tests per year:
vetpcr_year <- subset(vetpcr, select = c(DATO))
vetpcr_year$DATO = format(as.Date(vetpcr_year$DATO, format='%Y-%m-%d'),'%Y')
vetpcr_year <- stack(table(vetpcr_year))[2:1]
# renaming columns
vetpcr_year <- vetpcr_year %>%
  rename(
    year = ind,
    PCR_tests = values)

# vetpcr now replace vetresdyr, vetrespcr and vetpcrkode
rm(vetresdyr, vetrespcr, vetpcrkode); gc()

# 2x2 table
# data df_pcr from ???
table_treated <- table(df_pcr$RESULT, df_pcr$TREATED) # A = rows, B = columns
table_treated