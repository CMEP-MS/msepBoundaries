library(sf)
library(mapview)
library(dplyr)

fl <- here::here("data-raw",
                 "DEQ_Basins",
                 "commondata",
                 "enterprise_geodatabase_data.gdb")


basins <- st_read(fl, layer = "Basins")
subbasins <- st_read(fl, layer = "Subwatershed")


mapview(basins) +
    mapview(outline_full,
            col.regions = NA)

fl2 <- here::here("data-raw",
                  "msep_hucs.gpkg")

msep_huc10 <- st_read(fl2,
                      layer = "huc10")
msep_huc10 <- st_transform(msep_huc10, crs = st_crs(basins))

msep_huc8 <- st_read(fl2,
                     layer = "huc8") |>
    st_transform(crs = st_crs(basins))

msep_huc12 <- st_read(fl2,
                      layer = "huc12") |>
    st_transform(crs = st_crs(basins))


mapview(basins) +
    mapview(msep_huc8,
            col.regions = "red")

mapview(msep_huc8,
        col.regions = "red") +
    mapview(basins)

subbasins |>
    dplyr::filter(stringr::str_starts(HUC12, "0317|0318")) |>
    mapview(zcol = "HUC_8_NAME")

mapview(basins, zcol = "BASIN_NAME")


huc10s <- subbasins |>
    select(HUC_10, HUC_10_NAME, HUC_8, HUC_8_NAME, SHAPE) |>
    group_by(HUC_10, HUC_10_NAME) |>
    mutate(SHAPE = st_union(SHAPE)) |>
    ungroup() |>
    distinct()


huc8s <- subbasins |>
    select(HUC_8, HUC_8_NAME, SHAPE) |>
    group_by(HUC_8, HUC_8_NAME) |>
    summarize(SHAPE = st_union(SHAPE)) |>
    ungroup() |>
    distinct()

huc8sb <- huc8s |>
    filter(stringr::str_starts(HUC_8, "0317|0318"))

huc8sb|>
    mapview(zcol = "HUC_8_NAME")

mapview(huc8sb) +
    mapview(msep_huc8,
            col.regions = "red",
            alpha.regions = 0.1)

coastal10 <- msep_huc10 |>
    filter(stringr::str_starts(huc10, "03170009"))
coastal12 <- msep_huc12 |>
    filter(stringr::str_starts(huc12, "03170009"))
deq_coastal8 <- huc8sb |>
    filter(HUC_8_NAME %in% c("Mississippi Coastal", "Gulf of Mexico"))
deq_coastal10 <- huc10s |>
    filter(stringr::str_starts(HUC_10, "0317|0318"),
           HUC_8_NAME %in% c("Mississippi Coastal", "Gulf of Mexico"))
deq_coastal12 <- subbasins |>
    filter(HUC_8_NAME %in% c("Mississippi Coastal", "Gulf of Mexico"))

mapview(coastal12,
        col.regions = "red",
        alpha.regions = 0.1) +
    mapview(deq_coastal10)

mapview(deq_coastal12,
        zcol = "HUC_10_NAME")

mapview(coastal12,
        col.regions = "red",
        alpha.regions = 0.1) +
mapview(deq_coastal12,
        zcol = "HUC_10_NAME")

deq_gom <- dplyr::filter(deq_coastal8, HUC_8 == "03170999")
mapview(coastal12,
        color = "blue") +
    mapview(deq_gom,
            col.regions = "red",
            color = "red",
            alpha.regions = 0.1)

# new basins ----
new_basins <- msep_huc8 |>
    mutate(huc4 = stringr::str_sub(huc8, 1, 4),
           basin = case_when(huc8 == "03170009" ~ "Coastal Streams",
                             huc4 == "0317" ~ "Pascagoula River",
                             huc4 == "0318" ~ "Pearl River")) |>
    select(basin, geom) |>
    group_by(basin) |>
    summarize(geom = st_union(geom)) |>
    ungroup()

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
mapview(gulf_offshore)


# split out Gulf of Mexico from Coastal Streams ----
coastal_streams <- new_basins |>
    filter(basin == "Coastal Streams")
pearl.pasc <- new_basins |>
    filter(basin != "Coastal Streams")
coastal_trimmed <- st_difference(coastal_streams, gulf_offshore) |>
    select(-basin.1)

combined <- bind_rows(pearl.pasc,
                      coastal_trimmed,
                      gulf_offshore)
combined$notes <- c(
    "HUC 0317, minus the HUC8 03170009; the latter forms DEQ's Coastal Streams Basin and Gulf of Mexico unit. The Mississippi portion of this polygon is MDEQ's Pascagoula River Basin.",  # Pascagoula
    "HUC 0318 (complete). The Mississippi portion of this polygon is MDEQ's Pearl River Basin.",  # Pearl
    "HUC 03170009, minus the HUC12s that comprise the Gulf of Mexico unit (see note for Gulf of Mexico). The Mississippi portion of this polygon is MDEQ's Coastal Streams Basin.",  # Coastal Streams
    "union of HUC12s 031700091500 and 031700090203. The Mississippi portion of this polygon is MDEQ's Gulf of Mexico basin."  # Gulf of Mexico
    )

# new basins are as defined above

# new subbasins ----
# split Pearl and Pascagoula into HUC8s;
# us the split out Gulf of Mexico from Coastal Streams versions
new_subbasins <- msep_huc8 |>
    filter(huc8 != "03170009") |>
    mutate(huc4 = stringr::str_sub(huc8, 1, 4),
           basin = case_when(huc4 == "0317" ~ "Pascagoula River",
                             huc4 == "0318" ~ "Pearl River")) |>
    select(basin, name, geom) |>
    st_as_sf()

new_subbasins <- bind_rows(new_subbasins, coastal_trimmed, gulf_offshore)


