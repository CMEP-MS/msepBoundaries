## code to prepare `outline_full` dataset goes here
# see data-raw/subset_NHD.R for the processing of NHD data to 'msep_hucs'

# load libraries and set up all the reference data frames
source(here::here("data-raw",
                  "source_for_outlining.R"))



# huc4 outline ----
outline <- st_read(fl, layer = "huc4")

# full
outline_full <- st_union(outline) |>
    st_as_sf() |>
    rename(geometry = x)
usethis::use_data(outline_full, overwrite = TRUE, compress = "xz")
# trimmed to land
outline_land <- st_intersection(outline_full, unioned_lamsal_cb)
usethis::use_data(outline_land, overwrite = TRUE, compress = "xz")
# trimmed to MS but full
outline_ms_full <- st_intersection(outline_full, ms_full)
usethis::use_data(outline_ms_full, overwrite = TRUE, compress = "xz")
# trimmed to MS, land
outline_ms_land <- st_intersection(outline_full, ms_cb)
usethis::use_data(outline_ms_land, overwrite = TRUE, compress = "xz")


# subbasins
subbasins <- st_read(fl, layer = "huc8")

subbasins_full <- subbasins |>
    select(huc8, name, geometry = geom) |>
    st_as_sf()
usethis::use_data(subbasins_full, overwrite = TRUE, compress = "xz")
# trimmed to land
subbasins_land <- st_intersection(subbasins_full, unioned_lamsal_cb)
usethis::use_data(subbasins_land, overwrite = TRUE, compress = "xz")
# trimmed to MS but full
subbasins_ms_full <- st_intersection(subbasins_full, ms_full)
usethis::use_data(subbasins_ms_full, overwrite = TRUE, compress = "xz")
# trimmed to MS, land
subbasins_ms_land <- st_intersection(subbasins_full, ms_cb)
usethis::use_data(subbasins_ms_land, overwrite = TRUE, compress = "xz")
