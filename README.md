
<!-- README.md is generated from README.Rmd. Please edit that file -->

# msepBoundaries

<!-- badges: start -->
<!-- badges: end -->

The `msepBoundaries` package is a collection of several spatial data
frames delineating Mississippi Sound Estuary Program (MSEP) boundaries
in different ways.

## Installation

You can install the development version of msepBoundaries from
[GitHub](https://github.com/) with:

``` r
# install.packages("pak")
pak::pak("CMEP-MS/msepBoundaries")
```

## Examples

Here are a couple of examples. First load the libraries and use
`{tigris}` to get state outlines (`{tigris}` uses boundary data from the
US Census Bureau):

``` r
library(msepBoundaries)
library(dplyr)
library(tigris)
options(tigris_use_cache = TRUE)
library(ggplot2)

# get the outlines of MS, AL, and LA
lamsal <- states(cb = TRUE) |> 
    filter(NAME %in% c("Mississippi", "Alabama", "Louisiana"))
```

### Full Outline

The outline of the entire watershed.

``` r
ggplot() +
    geom_sf(data = outline_full,
            fill = "blue",
            alpha = 0.6) +
    geom_sf(data = lamsal,
            fill = NA) +
    theme_void() +
    ggtitle("Full watershed")
```

![](man/figures/README-unnamed-chunk-2-1.png)<!-- -->

### Subbasins

Subbasins (HUC8) for the entire watershed.

``` r
ggplot() +
    geom_sf(data = subbasins_full,
            aes(fill = name),
            alpha = 0.7) +
    geom_sf(data = lamsal,
            fill = NA) +
    scale_fill_viridis_d() +
    theme_void() +
    labs(title = "Full watershed",
         fill = "Subbasin")
```

![](man/figures/README-unnamed-chunk-3-1.png)<!-- -->

### Land-only subbasins, and only Mississippi

In case we want to ignore the large area of water that is the
Mississippi Sound, and restrict the area to the state of Mississippi.

``` r
ggplot() +
    geom_sf(data = subbasins_ms_land,
            aes(fill = name),
            alpha = 0.7) +
    geom_sf(data = lamsal,
            fill = NA) +
    theme_void() +
    scale_fill_viridis_d() +
    labs(title = "MS-only, cartographic boundaries",
         fill = "Subbasin")
```

![](man/figures/README-unnamed-chunk-4-1.png)<!-- -->
