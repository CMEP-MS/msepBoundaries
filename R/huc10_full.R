#' Outline of the Mississippi Sound Watershed HUC10s
#'
#' The Mississippi Sound Watershed is made up of HUC4s 0317 (Pascagoula River basin) and 0318 (Pearl River basin). This object contains the outlines of the HUC10s within both basins.
#'
#' @format A Simple feature collection with 113 features and 4 fields.
#' \describe{
#'   \item{`huc10`}{character, HUC ID.}
#'   \item{`name`}{character, name of the HUC unit.}
#'   \item{`hutype`}{character, type of the HUC unit.}
#'   \item{`hutype_description`}{character, description of the HUC unit type (i.e. Frontal, Island, Standard, Water).}
#'   \item{`geometry`}{POLYGON of the MSEP watershed HUC10s.}
#' }
#' @source National Hydrography Dataset, as downloaded from USGS on 6/4/2025 from <https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/NHD/State/GPKG/NHD_H_Mississippi_State_GPKG.zip>.
#'
#' @details
#' The raw data were subsetted to the geopackage file `msep_hucs.gpkg` using the script `subset_NHD.R`. The subset was further processed into this final form, using the `tigris` package for state and cartographic boundary delineations, in `make_boundaries.R`.
#' Both scripts and the subsetted geopackage file are available in the `data-raw` directory of the package repository at:
#' <https://github.com/CMEP-MS/msepBoundaries>.
#'

"huc10_full"
