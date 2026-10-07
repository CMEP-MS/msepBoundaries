#' Estuary Boundaries for Mississippi Sound and Lake Borgne
#'
#' Polygon boundaries for subsets of the Mississippi Sound (including West Mississippi Sound and East Mississippi Sound) and Lake Borgne, extracted from the EPA EMAP-NCA US50 and Puerto Rico estuary boundaries dataset. These boundaries delineate bays and tributaries separately from the main, larger estuaries.
#'
#' @format A Simple feature collection with 39 features and 26 fields. Spatial geometries are in the USA Contiguous Albers Equal Area Conic projection (ESRI: 102039, NAD83, meters). See the [online documentation](https://www.arcgis.com/home/item.html?id=1c64d9f81b904abcaf8ab2cf5767b71f&sublayer=0#overview) for more details; only key fields are described below.
#' \describe{
#'   \item{`WATERBODY`}{character, name of the waterbody within the estuarine system.}
#'   \item{`SYSTEM_NM`}{character, name of the estuarine system (e.g., "Mississippi Sound", "Lake Borgne").}
#'   \item{`geometry`}{MULTIPOLYGON of the estuary boundary features.}
#' }
#' @source Environmental Protection Agency (EPA) Environmental Monitoring and Assessment Program - National Coastal Assessment (EMAP-NCA), as downloaded from ArcGIS Online at <https://www.arcgis.com/apps/mapviewer/index.html?layers=1c64d9f81b904abcaf8ab2cf5767b71f>.
#'
#' @details
#' The raw zipped shapefile `US50_PR_Estuaries.zip` was stored in `data-raw/EMAP-NCA_EstuaryBoundaries/` and filtered for entries where `SYSTEM_NM` contains "Mississippi Sound" or "Lake Borgne".
#' The data-raw processing scripts are available in the package repository at:
#' <https://github.com/CMEP-MS/msepBoundaries>.
#'

"estuaryBoundaries_NCA"
