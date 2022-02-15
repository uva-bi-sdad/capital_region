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
  cids <- trimws(format(d$geoid, scientific = FALSE))
  su <- which(!cids %in% ids & d$region_type != "neighborhood")
  if (length(su)) {
    rewrite <- TRUE
    su <- su[grepl("0{6}$", cids[su])]
    cids[su] <- paste0(
      substr(cids[su], 1, 5),
      substr(paste0(gsub(
        "^.*\\s(?=\\d{2})|\\D", "", d[su, "region_name"], perl = TRUE
      ), "00"), 1, 6),
      gsub("^Block Group |,.*$", "", d[su, "region_name"])
    )
    d$geoid <- as.numeric(cids)
  }
  nd <- d[cids %in% ids | d$region_type == "neighborhood", colnames(d) != 'X']
  if (length(su) || !identical(d, nd)) write.csv(nd, f, row.names = FALSE)
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
    neighborhood = "neighborhood.csv"
  ),
  c(
    rep(list(list(
      ids = list(
        variable = "ID",
        map = "data/entity_info.json"
      ),
      time = "time",
      variables = "measure_info.json"
    )), 3),
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
