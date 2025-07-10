## code to prepare `source_for_outlining` dataset goes here
library(sf)
library(tigris)
library(tidyverse)
options(tigris_use_cache = TRUE)


fl <- here::here("data-raw",
                 "msep_hucs.gpkg")

# read in a huc dataset and get state coords into that CRS
huc <- st_read(fl, layer = "huc4")

# states, full
states_full <- states(cb = FALSE) |>
    select(NAME, geometry) |>
    st_transform(st_crs(huc))
lamsal_full <- states_full |>
    filter(NAME %in% c("Louisiana", "Mississippi", "Alabama"))
unioned_lamsal_full <- st_union(lamsal_full)
ms_full <- states_full |>
    filter(NAME == "Mississippi") |>
    select(-NAME)


# states, cartographic boundaries
states_cb <- states(cb = TRUE) |>
    select(NAME, geometry) |>
    st_transform(st_crs(huc))
lamsal_cb <- states_cb |>
    filter(NAME %in% c("Louisiana", "Mississippi", "Alabama"))
unioned_lamsal_cb <- st_union(lamsal_cb)
ms_cb <- states_cb |>
    filter(NAME == "Mississippi") |>
    select(-NAME)

