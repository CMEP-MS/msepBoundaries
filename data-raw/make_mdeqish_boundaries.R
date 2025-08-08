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
    filter(stringr::str_starts(huc12, "03170009"))

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
# do all the trimming

# equivalent to DEQ's Gulf of Mexico, 03170999, but
# extending into AL. debated some about the 2nd huc12; it's in a
# different huc10 than the first, but it is Gulf-ward of Dauphin Island:
gulf_offshore <- coastal12 |>
    filter(huc12 %in% c("031700091500", "031700090203")) |>
    select(geom) |>
    st_union() |>
    st_as_sf() |>
    mutate(basin = "Gulf of Mexico") |>
    rename(geom = x)
# split out Gulf of Mexico from Coastal Streams
coastal_streams <- basins_mdeqExt |>
    filter(basin == "Coastal Streams")
coastal_trimmed <- st_difference(coastal_streams, gulf_offshore) |>
    select(-basin.1)

# work with the huc8s for Pearl and Pascagoula, then join
# the coastal and Gulf stuff
subbasins_mdeqExt <- msep_huc8 |>
    filter(huc8 != "03170009") |>
    mutate(huc4 = stringr::str_sub(huc8, 1, 4),
           basin = case_when(huc4 == "0317" ~ "Pascagoula",
                             huc4 == "0318" ~ "Pearl")) |>
    select(basin, name, geom) |>
    st_as_sf()

subbasins_mdeqExt <- bind_rows(subbasins_mdeqExt, coastal_trimmed, gulf_offshore)

usethis::use_data(subbasins_mdeqExt, overwrite = TRUE, compress = "xz")

