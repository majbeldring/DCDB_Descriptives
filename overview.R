
# @majbeldring


# FIX / NOTICE : Only look at animals in yktr (cullings, calvings etc)

# Settings -----------------------------------------------

library(tidyverse)
options(stringsAsFactors = FALSE) # prevent factorizing caracters



# overview of DCDB files ---------------------------------

# animal info
dyrinfo       <- read_csv("M:/data/dyrinfo.csv")      # 0.5 GB, breed, birthday, gender, parents ID
racekode      <- read_csv("M:/data/racekode.csv")     # breeds
oms           <- read_csv("M:/data/oms.csv")          # 1.8 GB; movement of animals. Issues with NAT_ID
omsaetkode    <- read_csv('M:/data/omsaetkode.csv')   # code for movement/culling/birth/export/import
aarsagskode   <- read_csv("M:/data/aarsagskode.csv")  # reason for movement
koenkode      <- read_csv("M:/data/koenkode.csv")     # gender code

# calvings and dryoff
kaelvninger   <- read_csv("M:/data/kaelvninger.csv")  # calvings, dates and outcome
goldninger    <- read_csv("M:/data/goldninger.csv")   # dryoff animals and dates

# insemination & reproduction (breeding values in seperate files)
ins          <- read_csv('M:/data/ins.csv')           # 0.8 GB, Insemination info
repro        <- read_csv("M:/data/repro.csv")         # 2.0 GB, reproduction information

# treatments
sundhed                 <- read_csv("M:/data/sundhed.csv")              # 2.0 GB, disease records for individual animals
lksygdomskode           <- read_csv("M:/data/lksygdomskode_fixed.csv")  # debugged prior loading
behandler               <- read_csv("M:/data/behandlerNY.csv")          # practitioners in sunklinreg
sunklinreg              <- read_csv("M:/data/sunklinreg.csv")           # 2.6 GB, clinical registrations
sunklinparameter        <- read_csv("M:/data/sunklinparameter.csv")     # codes for sunklinreg
sunmedenhedskode        <- read_csv("M:/data/sunmedenhedskode.csv")     # units in vetstat (only codes)

# vet
vetrespcr          <- read_csv("M:/data/vetrespcrNY.csv")          # pcr recordings for individual animals
vetresdyr          <- read_csv("M:/data/vetresdyrNY.csv")          # 0.7 GB, problems with virus data
vetresejd          <- read_csv("M:/data/vetresejd.csv")            # Vetres result on herd level (doubtful data...)
vetreskor          <- read_csv("M:/data/vetreskor.csv")            # correction for four different vet tests
vetpcrkode         <- read_csv("M:/data/vetpcrkode_fixed.csv")     # code for Pathogen names
vetproveart        <- read_csv("M:/data/vetproveart.csv")          # type of test (blood/milk test/... )
vetprovekode       <- read_csv("M:/data/vetprovekode.csv")         # code for result of test (including if and why a test was useless)
vetprovetype       <- read_csv("M:/data/vetprovetype.csv")         # code for 12 different antibodies
vetprovemateriale  <- read_csv("M:/data/vetprovemateriale.csv")    # code for type: 3 types: blood, milk, bacteriology

# medicin
medicindyr                  <- read_csv("M:/data/medicindyr.csv")             # 1.6 GB, Treatments NOTICE: ONLY FARMS WITH ADVISORY AGREEMENT. ISSUES with maengde variable
medicin                     <- read_csv("M:/data/medicin.csv")                # codes for drugs - Assigning AB drugs 
medicinanvendelseskode      <- read_csv("M:/data/medicin.csv")                # codes for drug usage, waste & ordinated included 
ordinationsgruppekode       <- read_csv("M:/data/ordinationsgruppekode.csv")  # codes for drug ordination (9 main groups)
# alternate medicindyr loading
library(data.table)
medicindyr                  <- fread("M:/data/medicindyr.csv")    # possible to load with fread

# herd info
brugsart      <- read_csv("M:/data/brugsart.csv")       # herd type
brugsartkode  <- read_csv("M:/data/brugsartkode.csv")   # code for hert type
dyrtilbes     <- read_csv("M:/data/dyrtilbes.csv")      # link between animal and herds
beskart       <- read_csv("M:/data/beskart.csv")        # location of herd
besstr        <- read_csv("M:/data/besstr.csv")         # herd size of various time
besyktr       <- read_csv("M:/data/besyktr.csv")        # Herds registered in yktr - and for which period

# production/ milk controls
yktr          <- read_csv("M:/data/yktr.csv")           # 3.2 GB, production, cattles with 11 controls per year

# milk
malksys           <- read_csv("M:/data/malksys.csv")             # milking systems on herd level - robot type
mlklevcellekim    <- read_csv("M:/data/mlklevcellekim.csv")      # cellekim on herd level (with CHRNR as ID)
mlklevindv        <- read_csv("M:/data/mlklevindv.csv")          # milk on herd level, week no (no dates), with CHRNR as ID

# cullings
slagtedata        <- read_csv('M:/data/slagtedata.csv')          # Slaughter weight, value and classification. Issues with weight variable
slagtefund        <- read_csv('M:/data/slagtefund.csv')          # findinds at cullings
slagtefundkode    <- read_csv('M:/data/slagtefundkode.csv')      # code for findinds at cullings
slagtefarvekode   <- read_csv('M:/data/slagtefarvekode.csv')     # code for colour at cullings
slagtefedmekode   <- read_csv('M:/data/slagtefedmekode.csv')     # code for tallow layer


# Misc
nationskode         <- read_csv('M:/data/nationskode.csv')        # country ID
tbfenhedkoedkode    <- read_csv('M:/data/tbfenhedkoedkode.csv')   # code for hours / meat. For ??
tbfenhedmaelkkode   <- read_csv('M:/data/tbfenhedmaelkkode.csv')  # code for hours / milk. For ??
kirtelkode          <- read_csv('M:/data/kirtelkode.csv')         # code for kirtel location, 1-6
ptbtilmeld          <- read_csv("M:/data/ptbtilmeld.csv")         # when a herd enter the ptb surveillance (by CHRNR)

