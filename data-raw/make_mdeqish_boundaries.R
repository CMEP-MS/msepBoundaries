# Make boundaries based on MDEQ basins and subbasins,
# but that also include Louisiana and Alabama
#
# This uses a slightly different outline, possibly from different NHD versions
# (only noticeable on the pointy lower edge of the boundary in the Gulf)

library(sf)
library(tidyverse)

fl <- here::here("data-raw",
                 "msep_hucs.gpkg")

# layers: need msep_huc8 and coastal12 ----
msep_huc8 <- st_read(fl,
                     layer = "huc8")
msep_huc12 <- st_read(fl,
                      layer = "huc12")
coastal12 <- msep_huc12 |>
    filter(stringr::str_starts(huc12, "03170009")) |>
    mutate(huc10 = stringr::str_sub(huc12, 1, 10))

# huc10 0317000915 is DEQ's 'Gulf' basin
# DEQ's Coastal Offshore is huc10s 914, 908, 907, 903, 902

# basins ----
# new basins ----
basins_mdeqExt <- msep_huc8 |>
    mutate(huc4 = stringr::str_sub(huc8, 1, 4),
           basin = case_when(huc8 == "03170009" ~ "Coastal Streams",
                             huc4 == "0317" ~ "Pascagoula",
                             huc4 == "0318" ~ "Pearl")) |>
    select(basin, geom) |>
    group_by(basin) |>
    summarize(geom = st_union(geom)) |>
    ungroup()

usethis::use_data(basins_mdeqExt, overwrite = TRUE, compress = "xz")


# subbasins ----

# huc10 0317000915 is DEQ's 'Gulf' basin
# DEQ's Coastal Offshore is huc10s 914, 908, 907, 903, 902

# this is not quite right - it's grabbing some onshore huc12s and still lumping them with offshore
# 031700090301|031700090701|031700090801|031700091401

subbasins_coastal <- coastal12 |>
    mutate(basin = case_when(huc12 %in% c("031700090301", "031700090701", "031700090801", "031700091401") ~ "Coastal Streams",
                             str_ends(huc10, "0915") ~ "Gulf of America",
                             str_ends(huc10, "914|908|907|903|902") ~ "Coastal Offshore",
                             str_starts(huc12, "03170009") ~ "Coastal Streams",
                             .default = name)) |>
    st_as_sf() |>
    group_by(basin) |>
    summarize(geom = st_union(geom))



# work with the huc8s for Pearl and Pascagoula, then join
# the coastal and Gulf stuff
subbasins_mdeqExt <- msep_huc8 |>
    filter(huc8 != "03170009") |>
    mutate(huc4 = stringr::str_sub(huc8, 1, 4),
           basin = case_when(huc4 == "0317" ~ "Pascagoula",
                             huc4 == "0318" ~ "Pearl")) |>
    select(basin, name, geom) |>
    st_as_sf()

subbasins_mdeqExt <- bind_rows(subbasins_mdeqExt, subbasins_coastal)

usethis::use_data(subbasins_mdeqExt, overwrite = TRUE, compress = "xz")

