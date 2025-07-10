## code to prepare `subset_NHD` dataset goes here

# The zipped Mississippi geopackage from the National Hydrographic Dataset
# is almost 1.5 GB, so I do not want to check it into git. added to gitignore with code below:
# use_git_ignore("data-raw/NHD_H_Mississippi_State_GPKG/")

# This file processes a previously downloaded NHD file (see links below) to
# pull out only relevant layers, and filter them to only the HUC4s that comprise
# the MSEP watershed (0317 and 0318). Those layers will be included as a geopackage
# in the data-raw folder of the msepBoundaries package.

# using National Hydrographic Dataset; Mississippi Geopackage downloaded from USGS on 4 June 2025
# State geopackages are here: https://prd-tnm.s3.amazonaws.com/index.html?prefix=StagedProducts/Hydrography/NHD/State/GPKG/
# MS geopackage specifically: https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/NHD/State/GPKG/NHD_H_Mississippi_State_GPKG.zip
library(sf)
library(dplyr)
library(stringr)

fl <- here::here("data-raw",
                 "NHD_H_Mississippi_State_GPKG",
                 "NHD_H_Mississippi_State_GPKG.gpkg")
lyrs <- st_layers(fl)

to_read <- c("WBDHU10",
             "WBDHU12",
             # "WBDHU14",   # not present in our HUC4s
             # "WBDHU16",
             "WBDHU4",
             # "WBDHU6",    # for our HUCs, not different from the HUC4 level
             "WBDHU8")

huc4 <- st_read(fl, layer = "WBDHU4") |>
    filter(huc4 %in% c("0317", "0318")) |>
    st_as_sf()

huc8 <- st_read(fl, layer = "WBDHU8") |>
    filter(str_starts(huc8, "0317|0318")) |>
    st_as_sf()

huc10 <- st_read(fl, layer = "WBDHU10") |>
    filter(str_starts(huc10, "0317|0318")) |>
    st_as_sf()

huc12 <- st_read(fl, layer = "WBDHU12") |>
    filter(str_starts(huc12, "0317|0318")) |>
    st_as_sf()

fl_out <- here::here("data-raw",
                     "msep_hucs.gpkg")

st_write(huc4,
         fl_out,
         layer = "huc4",
         append = FALSE,
         delete_layer = TRUE)

st_write(huc8,
         fl_out,
         layer = "huc8",
         append = FALSE,
         delete_layer = TRUE)

st_write(huc10,
         fl_out,
         layer = "huc10",
         append = FALSE,
         delete_layer = TRUE)

st_write(huc12,
         fl_out,
         layer = "huc12",
         append = FALSE,
         delete_layer = TRUE)
