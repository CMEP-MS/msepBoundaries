#' Outline of the Mississippi Sound watershed, excluding the Mississippi Sound itself
#'
#' The MSEP is made up of HUC4s 0317 (Pearl River watershed) and 0318 (Pascagoula River watershed). This is the outline of their union, clipped to cartographic boundaries (i.e. following the contours of land and islands).
#'
#' @format A Simple feature collection with 1 feature and 0 fields.
#' \describe{
#'   \item{geometry}{MULTIPOLYGON of the MSEP watershed outline after clipping to cartographic boundaries.}
#' }
#' @source National Hydrography Dataset, as downloaded from USGS on 6/4/2025 from \url{https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/NHD/State/GPKG/NHD_H_Mississippi_State_GPKG.zip}.
#'
#' @details
#' The raw data were subsetted to the geopackage file \code{msep_hucs.gpkg} using the script \code{subset_NHD.R}. The subset was further processed into this final form, using the \code{tigris} package for state and cartographic boundary delineations, in \code{make_boundaries.R}.
#' Both scripts and the subsetted geopackage file are available in the \code{data-raw} directory of the package repository at:
#' \url{https://github.com/CMEP-MS/msepBoundaries}.
#'

"outline_land"
