# Subbasins (HUC8s) of the full Mississippi Sound Watershed

The Mississippi Sound Watershed is made up of HUC4s 0317 (Pascagoula
River basin) and 0318 (Pearl River basin). This is the combination of
all HUC8 units within them.

## Usage

``` r
subbasins_full
```

## Format

A Simple feature collection with 14 features (rows) and 2 fields.

- `huc8`:

  character, HUC8 ID.

- `name`:

  character, name of the subbasin.

- `geometry`:

  POLYGON of each subbasin.

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
