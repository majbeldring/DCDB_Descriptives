

# FIX maybe just look at mastitis treatment data from vetstat?
# combine mastitis treatments with treatment at dryoff
# But must be merged with yktr to get overview of DIM treatment date

# so retrieve: goldbehandling, mastitis (se vetstat script for this)


# treatments (only keeping dry_off treatments with date and animal ID)

str(sundhed); str(lksygdomskode) # sygdomsdato format: Date

treatments <- sundhed %>%
  filter(SYGDOMSDATO > as.Date("2009-12-31")) %>%
  dplyr::select(DYR_ID, SYGDOMSDATO, LKSK_ID) %>%
  drop_na() %>%
  rename(ID = LKSK_ID)

treatments <- left_join(treatments, lksygdomskode , by = "ID")

# treatments per year from 2010:
treatments$SYGDOMSDATO = format(as.Date(treatments$SYGDOMSDATO, format='%Y-%m-%d'),'%Y') # change date format to only years
treatments_year <- subset(treatments, select = c(SYGDOMSDATO))
treatments_year <- stack(table(treatments_year))[2:1]

# renaming columns
treatments_year <- treatments_year %>%
  rename(
    year = ind,
    treatments = values
  )

glimpse(treatments)


# treatment at dry-off

# DRYOFF treatments, with 1 for treatment:
dryoff_treat <- dplyr::filter(treatments, grepl('Goldningsbehandling', DISEASE))
dryoff_treat <- dryoff_treat %>% 
  mutate(DRY_TREAT = case_when(DISEASE == "Goldningsbehandling" ~ 1)) %>% 
  rename(DRYTREAT_DATE = TREATMENT_DATE) %>%
  dplyr::select(-DISEASE, -AB)






# MASTITIS only ---------------------------------------

mastitis <- sundhed %>%
  filter(SYGDOMSDATO > as.Date("2009-12-31")) %>%
  mutate(year = format(SYGDOMSDATO, "%Y")) %>%
  drop_na() %>%
  filter(LKSK_ID == 120011 | LKSK_ID == 120015 | LKSK_ID == 130011 |LKSK_ID == 140011) %>%
  dplyr::select(year)

mastitis_year <- stack(table(mastitis))[2:1]

# renaming columns
mastitis_year <- mastitis_year %>%
  rename(
    year = ind,
    mastitis = values
  )


# Mastitis: codes: 120011, 120014, 120015, 120094, 120095, 120179, 130011, 140011 ------ 
# add goldbehandling. Or make a seperate with treatment at dryoff

mastitis_all <- sundhed %>%
  filter(SYGDOMSDATO > as.Date("2009-12-31")) %>%
  mutate(year = format(SYGDOMSDATO, "%Y")) %>%
  drop_na() %>%
  filter(LKSK_ID == 120011 | LKSK_ID == 120015 | LKSK_ID == 130011 |LKSK_ID == 140011 |
           LKSK_ID == 120014 | LKSK_ID == 120094 | LKSK_ID == 120095 |LKSK_ID == 120179) %>%
  dplyr::select(year)

mastitis_all_year <- stack(table(mastitis_all))[2:1]

# renaming columns
mastitis_all_year <- mastitis_all_year %>%
  rename(
    year = ind,
    mastitis = values
  )











