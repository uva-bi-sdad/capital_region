library(community)

init_site("../capital_region", "capital_region")

# remove any non-NCR entries

## get all NCR geoids
ids <- unlist(lapply(c("counties", "tracts", "blockgroups"), function(s) list(
  vapply(jsonlite::read_json(paste0(
    "https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/", s, ".geojson"
  ))$features, function(d) d$properties$GEOID, "")
)), use.names = FALSE)

## trim and save files
for (f in list.files("../capital_region/docs/data/original", full.names = TRUE)) {
  d <- read.csv(f)
  nd <- d[d$geoid %in% ids | d$region_type == "civic association", colnames(d) != 'X']
  if (!identical(d, nd)) write.csv(nd, f, row.names = FALSE)
}

data_reformat_sdad(
  "../capital_region/docs/data/original",
  formatters = list(region_name = function(x) sub(",.*$", "", x)),
  out = "../capital_region/docs/data"
)

data_add(
  c(
    county = "county.csv",
    tract = "tract.csv",
    block_group = "block_group.csv",
    civic_association = "civic_association.csv"
  ),
  c(
    lapply(c("counties", "tracts", "blockgroups"), function(s){
      list(
        ids = list(
          variable = "ID",
          map = "data/entity_info.json"
        ),
        time = "time",
        variables = "measure_info.json"
      )
    }),
    list(list(
      ids = list(variable = "ID", map = "data/entity_info.json"),
      time = "time",
      variables = "measure_info.json"
    ))
  ),
  dir = "../capital_region/docs/data",
  clean = TRUE,
  refresh = TRUE
)

meta <- jsonlite::read_json("../capital_region/docs/data/measure_info.json")
site_build("../capital_region", variables = names(meta))
