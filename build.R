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
  d <- read.csv(gzfile(f))
  d <- d[
    !is.na(d$geoid) & !is.na(d$value) & !is.na(d$region_name) &
      d$region_type %in% c("block group", "tract", "county", "neighborhood"),
  ]
  cids <- trimws(format(d$geoid, scientific = FALSE))
  su <- which(grepl("^\\d+$", cids) & !cids %in% ids & d$region_type != "neighborhood")
  if (length(su)) {
    su <- su[grepl("0{6}$", cids[su])]
    cids[su] <- paste0(
      substr(cids[su], 1, 5),
      substr(paste0(gsub(
        "^.*\\s(?=\\d{2})|\\D", "", d[su, "region_name"], perl = TRUE
      ), "00"), 1, 6),
      gsub("^Block Group |,.*$", "", d[su, "region_name"])
    )
  }
  nd <- d[cids %in% ids | d$region_type == "neighborhood", colnames(d) != "X"]
  uncompressed <- grepl("\\.csv$", f)
  if (!nrow(nd)) {
    unlink(f)
  } else if (uncompressed || length(su) || !identical(d, nd)) {
    if (uncompressed) unlink(f)
    write.csv(nd, xzfile(sub("\\.csv$", ".csv.xz", f)), row.names = FALSE)
  }
}

data_reformat_sdad(
  "../capital_region/docs/data/original",
  formatters = list(region_name = function(x) sub(",.*$", "", x)),
  out = "../capital_region/docs/data"
)

data_add(
  c(
    county = "county.csv.xz",
    tract = "tract.csv.xz",
    block_group = "block_group.csv.xz",
    neighborhood = "neighborhood.csv.xz"
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

vars <- jsonlite::read_json("../capital_region/docs/data/measure_info.json")
site_build("../capital_region", variables = names(vars))
