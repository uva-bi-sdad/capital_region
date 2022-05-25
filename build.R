library(community)

# remove any non-NCR entries

## get all NCR geoids
ids <- unlist(c(
  lapply(c("counties", "tracts", "blockgroups"), function(s) list(
    vapply(jsonlite::read_json(paste0(
      "https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/", s, ".geojson"
    ))$features, function(d) d$properties$GEOID, "")
  )),
  list(
    vapply(jsonlite::read_json("docs/data/neighborhoods.geojson")$features, function(d) d$properties$geoid, "")
  )
), use.names = FALSE)

## trim and save files
for (f in list.files("../capital_region/docs/data/original", full.names = TRUE)) {
  d <- read.csv(gzfile(f))
  nd <- d[
    !is.na(d$geoid) & !is.na(d$value) & !is.na(d$region_name) &
      d$region_type %in% c("block group", "tract", "county", "neighborhood"),
  ]
  cids <- trimws(format(nd$geoid, scientific = FALSE))
  su <- which(grepl("^\\d+$", cids) & !cids %in% ids)
  if (length(su)) {
    su <- su[grepl("0{6}$", cids[su])]
    cids[su] <- paste0(
      substr(cids[su], 1, 5),
      substr(paste0(gsub(
        "^.*\\s(?=\\d{2})|\\D", "", nd[su, "region_name"], perl = TRUE
      ), "00"), 1, 6),
      gsub("^Block Group |,.*$", "", nd[su, "region_name"])
    )
  }
  nd <- nd[cids %in% ids | nd$region_type == "neighborhood", colnames(nd) != "X"]
  if (nrow(nd)) {
    crv <- grep("fca$", unique(nd$measure), value = TRUE)
    if (length(crv)) {
      for (v in crv) {
        su <- nd$measure == v
        if (max(nd[su, "value"]) < .01) {
          nd[su, "value"] <- nd[su, "value"] * 1000
        }
      }
    }
  }
  uncompressed <- grepl("\\.csv$", f)
  if (!nrow(nd)) {
    unlink(f)
  } else if (uncompressed || length(su) || !identical(d, nd)) {
    unlink(f)
    write.csv(nd, xzfile(sub("\\.csv(?:\\.[gbx]z2?)?$", ".csv.xz", f)), row.names = FALSE)
  }
}

data_reformat_sdad(
  "../capital_region/docs/data/original",
  variables = names(jsonlite::read_json("../capital_region/docs/data/measure_info.json"))[-1],
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
  rep(list(list(
    ids = list(
      variable = "ID",
      map = "https://raw.githubusercontent.com/uva-bi-sdad/capital_region/main/docs/data/entity_info.json"
    ),
    time = "time",
    variables = "measure_info.json"
  )), 4),
  dir = "../capital_region/docs/data",
  clean = TRUE,
  refresh = TRUE
)

site_build(
  "../capital_region", serve = TRUE,
  endpoint = "https://ncr-data-commons.netlify.app/api"
)
