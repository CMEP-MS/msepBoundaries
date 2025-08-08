#' The full Mississippi Sound Watershed, split into subbasins according to MDEQ's heuristics
#'
#' The Mississippi Sound Watershed is made up of HUC4s 0317 (Pascagoula River basin) and 0318 (Pearl River basin). The Mississippi Department of Environmental Quality recognizes a portion of HUC 0317, specifically the HUC8 03170009, as a separate basin, the Coastal Streams Basin. Because waterways in that HUC8 do not in fact flow into the Pascagoula River, it makes sense for the MSEP to recognize this delineation as well.
#'
#' Additionally, MDEQ recognizes the portion of the Coastal Streams Basin on the south side of the Mississippi Barrier Islands as a subbasin named "Gulf of Mexico".
#'
#' MDEQ only delineates these watersheds within the state of MS, however, so MSEP has made the current delineation by subsetting HUCs from the National Hydrography Dataset, and extending the Coastal Streams Basin into Louisiana and Alabama based on the HUC8 of 03170009. The Gulf of Mexico subbasin is the union of HUC12s 031700091500 (the MS portion of this HUC is MDEQ's HUC 03170999) and 031700090203 (offshore of Dauphin Island, AL).
#'
#' @format A Simple feature collection with 15 features and 2 fields.
#' \describe{
#'   \item{basin}{Basin, according to MDEQ designation.}
#'   \item{name}{Subbasin name, if provided as a name in the HUC from the NHD.}
#'   \item{geometry}{POLYGON of the basin.}
#' }
#' @source National Hydrography Dataset, as downloaded from USGS on 6/4/2025 from \url{https://prd-tnm.s3.amazonaws.com/StagedProducts/Hydrography/NHD/State/GPKG/NHD_H_Mississippi_State_GPKG.zip}.
#'
#' @details
#' The raw data were subsetted to the geopackage file \code{msep_hucs.gpkg} using the script \code{subset_NHD.R}. The subset was further processed into this final form in \code{make_mdeqish_boundaries.R}.
#' Both scripts and the subsetted geopackage file are available in the \code{data-raw} directory of the package repository at:
#' \url{https://github.com/CMEP-MS/msepBoundaries}.
#'

"subbasins_mdeqExt"
