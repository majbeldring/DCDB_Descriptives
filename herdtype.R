

# fix - make sure only to look at dairy farms 
# Check


# Brugsart - conventionel vs eco -------------------------------------------

brugsart      <- read_csv("M:/data/brugsart.csv")       # herd type
brugsartkode  <- read_csv("M:/data/brugsartkode.csv")   # code for hert type

str(brugsart); str(brugsartkode)

brugsart <- brugsart %>%
  rename(ID = BRUGSART_ID)

# create herd dataset by joining code and brugsart:
herd <- left_join(brugsart, brugsartkode , by = "ID") %>%
  dplyr::select(-ID) %>%
  drop_na()

herd_types <- subset(herd, select = c(BRUGSARTTEKST))
herd_types <- stack(table(herd_types))[2:1]

herd_types <- herd_types %>%
  rename(
    herd = ind,
    COUNTS = values
  ) 

rm(brugsart, brugsartkode); gc()
