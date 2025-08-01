library(sf)

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
