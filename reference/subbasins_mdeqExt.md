# The full Mississippi Sound Watershed, split into subbasins according to MDEQ's heuristics

The Mississippi Sound Watershed is made up of HUC4s 0317 (Pascagoula
River basin) and 0318 (Pearl River basin). The Mississippi Department of
Environmental Quality recognizes a portion of HUC 0317, specifically the
HUC8 03170009, as a separate basin, the Coastal Streams Basin. Because
waterways in that HUC8 do not in fact flow into the Pascagoula River, it
makes sense for the MSEP to recognize this delineation as well.

## Usage

``` r
subbasins_mdeqExt
```

## Format

A Simple feature collection with 15 features and 2 fields.

- `basin`:

  Basin, according to MDEQ designation.

- `name`:

  Subbasin name, if provided as a name in the HUC from the NHD.

- `geometry`:

  POLYGON of the basin.

## Source

National Hydrography Dataset, as downloaded from USGS on 6/4/2025 from
<https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/NHD/State/GPKG/NHD_H_Mississippi_State_GPKG.zip>.

## Details

Additionally, MDEQ recognizes the portion of the Coastal Streams Basin
on the south side of the Mississippi Barrier Islands as a subbasin named
"Gulf of Mexico", changed here to "Gulf of America"; and the waters of
the Mississippi Sound as "Coastal Offshore". Boundaries in this file
were generated using a combination of HUC levels and may not exactly
match MDEQ's at the subbasin level.

MDEQ only delineates these watersheds within the state of MS, however,
so MSEP has made the current delineation by subsetting HUCs from the
National Hydrography Dataset, and extending the Coastal Streams Basin
into Louisiana and Alabama based on the HUC8 of 03170009. The Gulf of
America subbasin is HUC10 0317000915.

The raw data were subsetted to the geopackage file `msep_hucs.gpkg`
using the script `subset_NHD.R`. The subset was further processed into
this final form in `make_mdeqish_boundaries.R`. Both scripts and the
subsetted geopackage file are available in the `data-raw` directory of
the package repository at: <https://github.com/CMEP-MS/msepBoundaries>.
