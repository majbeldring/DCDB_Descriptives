

# vaccines mastitis

# or: save.image("K:/paper_vaccine/III_merge_vaccine.RData")  ?

sundhed                 <- read_csv("M:/data/sundhed.csv")              # 2.0 GB, disease records for individual animals
lksygdomskode           <- read_csv("M:/data/lksygdomskode_fixed.csv")  # debugged prior loading

str(sundhed); str(lksygdomskode) # sygdomsdato format: Date


treatments <- sundhed %>%
  filter(SYGDOMSDATO > as.Date("2009-12-31")) %>%
  dplyr::select(DYR_ID, SYGDOMSDATO, LKSK_ID) %>%
  drop_na() %>%
  rename(TREATMENT_DATE = SYGDOMSDATO, ID = LKSK_ID)

treatments <- left_join(treatments, lksygdomskode , by = "ID") %>%
  dplyr::select(DYR_ID, TREATMENT_DATE, LKSYGTEKST) %>%
  rename(DISEASE = LKSYGTEKST)

rm(sundhed, lksygdomskode, AB_treatments); gc()


# 206, 120340, 340, Mastitis Staf/E.coli, vaccination, 1299

# mastitis vaccine, with 1 for vaccine:
vaccination <- dplyr::filter(treatments, 
                             grepl('Mastitis Staf/E.coli, vaccination', DISEASE))
# Binary vaccination status
vaccination <- vaccination %>% 
  mutate(VACC = case_when(DISEASE == "Mastitis Staf/E.coli, vaccination" ~ 1)) %>% 
  rename(VACCINATION_DATE = TREATMENT_DATE) %>%
  dplyr::select(-DISEASE)



# When we have yktr data:

# We only look at those with 3 vaccines
# 60 days before calving, 
# 75 days after calving.
# count, group_by: DYR_ID
vaccination <- left_join(branch, vaccination, by = "DYR_ID", sort="TRUE",allow.cartesian=TRUE)
vaccination <- vaccination %>%
  group_by(DYR_ID, PARITY) %>%
  filter(VACCINATION_DATE + 60 > CALVING_DATE |is.na(VACCINATION_DATE)) %>%
  filter(VACCINATION_DATE - 75 < CALVING_DATE |is.na(VACCINATION_DATE)) %>%
  dplyr::select(DYR_ID, PARITY, VACC, VACCINATION_DATE)
vaccination <- vaccination %>%
  drop_na()


# Count Vaccination before in each lac_phase
vaccination <- rename(count(vaccination, DYR_ID, PARITY), VACC = n)
table(vaccination$VACC) 

# convert vaccinations to factors:
vaccination <- vaccination %>%
  mutate(VACC = factor(VACC))




# TEAT SEALANT, with 1 for teat treated
teat_treat <- dplyr::filter(treatments, grepl('pattelukning', DISEASE))
teat_treat <- teat_treat %>% 
  mutate(TEAT_TREAT = case_when(DISEASE == "Intern pattelukning" ~ 1)) %>% 
  rename(TEAT_DATE = TREATMENT_DATE) %>%
  dplyr::select(-DISEASE, -AB)
