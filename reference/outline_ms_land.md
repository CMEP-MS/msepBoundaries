# Outline of the MS-only portion of the Mississippi Sound watershed, excluding the Mississippi Sound itself

The Mississippi Sound Watershed is made up of HUC4s 0317 (Pascagoula
River basin) and 0318 (Pearl River basin). This is the outline of their
union, clipped to the state of Mississippi's cartographic boundaries
(i.e. following the contours of land and islands). The watershed extends
into both Louisiana and Alabama, but this boundary is clipped to the
state of Mississippi only (as MSEP's current funding only allows work
within the state).

## Usage

``` r
outline_ms_land
```

## Format

A Simple feature collection with 1 feature and 0 fields.

- `geometry`:

  MULTIPOLYGON of the MSEP watershed outline after clipping to
  cartographic boundaries of only Mississippi.

## Source

National Hydrography Dataset, as downloaded from USGS on 6/4/2025 from
<https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/NHD/State/GPKG/NHD_H_Mississippi_State_GPKG.zip>.

## Details

The raw data were subsetted to the geopackage file `msep_hucs.gpkg`
using the script `subset_NHD.R`. The subset was further processed into
this final form, using the `tigris` package for state and cartographic
boundary delineations, in `make_boundaries.R`. Both scripts and the
subsetted geopackage file are available in the `data-raw` directory of
the package repository at: <https://github.com/CMEP-MS/msepBoundaries>.
