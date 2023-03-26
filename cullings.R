

# Cullings

# FIX add yktr, as we only look at animals in production


# movements, cullings: "oms", "oms?tningskode", #slagtedata"

# oms:
glimpse(oms)
dplyr::n_distinct(oms$DYR_ID)  # 6.612.455 unique animals
dplyr::n_distinct(oms$BES_ID)  # 23.084 unique herds

# slagtedata:
dplyr::n_distinct(slagtedata$DYR_ID)  # 3.876.655 unique animals
dplyr::n_distinct(slagtedata$BES_ID)

# culling data per year
slagtedata$DATO = format(as.Date(slagtedata$DATO, format='%Y-%m-%d'),'%Y') # years only
culling_year <- subset(slagtedata, select = c(DATO))
culling_year <- stack(table(culling_year))[2:1]
culling_year <- culling_year %>%
  rename(
    year = ind,
    culling = values)