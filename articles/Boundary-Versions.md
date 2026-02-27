# Boundary Versions

This package contains various combinations of boundaries for:

- *All 3 states vs. MS-only.* MSEP only works within MS, but the
  watershed extends into the neighboring states of AL and LA. It could
  be useful to see boundaries and subbasins either way.  
- *Full vs. land-only.* Mostly, we probably want the entire outline of
  the watershed; but if we’re calculating areas of land-based metrics,
  we may not want the waters of the Mississippi Sound itself (and some
  of the bigger bays) included in the area. The land-only versions of
  these boundaries are for the latter case.

## Outlines

### Full watershed (all 3 states)

#### full: `outline_full`

#### land only: `outline_land`

### MS only

#### full: `outline_ms_full`

#### land only: `outline_ms_land`

## MDEQ divisions

The Mississippi Department of Environmental Quality (MDEQ) defines three
major basins in their regulatory activities. The Coastal Streams Basin,
which in the National Hydrography Dataset is contained within the
Pascagoula Basin, is separated out at a higher level. This makes a lot
of sense, as many of the waters near the coast drain into bays that
drain into the Sound, and not into the Pascagoula River.

The boundaries in this section are meant to treat the Coastal Streams
Basin separately. As MDEQ only operates in the state of MS, the
boundaries based on MDEQ’s HUC-10 divisions were extended into AL and
LA.

#### Basins: `basins_mdeqExt`

#### Subbasins: `subbasins_mdeqExt`

## Subbasin delineations

### Full watershed (all 3 states)

#### full: `subbasins_full`

#### land only: `subbasins_land`

### MS only

#### full: `subbasins_ms_full`

#### land only: `subbasins_ms_land`
