
# Breed info
# FIX add yktr, as we only look at animals in milk produktion


dyrinfo       <- read_csv("M:/data/dyrinfo.csv")      # 0.5 GB, breed, birthday, gender, parents ID
racekode      <- read_csv("M:/data/racekode.csv")     # breeds


str(dyrinfo); str(racekode) # FOEDSELSDATO is date format

dyrinfo <- dyrinfo %>%
  dplyr::select(ID, RACE_ID, FOEDSELSDATO) %>%
  rename(BIRTH = FOEDSELSDATO, DYR_ID = ID)
racekode <- racekode %>%
  dplyr::select(ID, RACENAVN) %>%
  rename(RACE_ID = ID)

# join racekode and dyrinfo to create dyrinfo with breed names instead of codes:
breed <- left_join(dyrinfo, racekode , by = "RACE_ID") %>%
  dplyr::select(-RACE_ID) %>%
  drop_na()

breed <- breed %>% 
  mutate(RACE = if_else(str_detect(RACE, pattern = "Holstein"), "holstein", RACE)) %>%
  mutate(RACE = if_else(str_detect(RACE, pattern = "Jersey"), "jersey", RACE)) %>%
  mutate(RACE = if_else(str_detect(RACE, pattern = "broget"), "other", RACE)) %>%
  mutate(RACE = if_else(str_detect(RACE, pattern = "alkerace$"), "other", RACE)) %>%
  mutate(RACE = if_else(str_detect(RACE, pattern = "Krydsning"), "other", RACE))

breed <- dplyr::filter(breed, grepl('holstein|jersey|other', RACE)) #keep only 3

# number of breed types
breed_types <- subset(breed, select = c(RACENAVN))
breed_types <- stack(table(breed_types))[2:1]
breed_year <- breed_types %>%
  rename(
    BREED = ind,
    COUNTS = values
  )

#rm(dyrinfo, racekode); gc()