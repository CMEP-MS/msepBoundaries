# data file in "EMAP-NCA_EstuaryBoundaries" was downloaded from
# https://www.arcgis.com/apps/mapviewer/index.html?layers=1c64d9f81b904abcaf8ab2cf5767b71f
# on 9/7/2026. This file trims it to only contain the MS Sound and Lake Borgne,
# and turns that into an sf object saved in msepBoundaries.

library(sf)
library(tidyverse)
library(here)

# 1. Define path to the zipped shapefile in 'data-raw'
zip_path <- here("data-raw", "EMAP-NCA_EstuaryBoundaries", "US50_PR_Estuaries.zip")

# 2. Read directly from zip file
estuaries <- st_read(paste0("/vsizip/", zip_path))

# 3. Filter dataset
estuaryBoundaries_NCA <- estuaries %>%
    filter(str_detect(SYSTEM_NM, "Mississippi Sound|Lake Borgne"))

# take a quick look
mapview::mapview(estuaryBoundaries_NCA)

# 4. Save as .rda file in the 'data' directory
usethis::use_data(estuaryBoundaries_NCA, overwrite = TRUE)
