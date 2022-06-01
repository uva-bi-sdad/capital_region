library(community)

# remove any non-NCR entries

## get all NCR geoids
ids <- unlist(c(
  lapply(list(
    c("human services region", "human_services_regions"),
    c("planning district", "planning_districts"),
    c("supervisor district", "supervisor_districts"),
    c("zip code", "zip_codes"),
    c("neighborhood", "civic_associations"),
    c("block_group", "census_block_groups"),
    c("tract", "census_tracts"),
    c("county", "counties")
  ), function(s) {
    pref <- if (s[1] == "neighborhood")
      "va013_geo_arl_2021_" else if (s[1] %in% c(
        "human services region", "planning district", "supervisor district", "zip code"
      )) "va059_geo_ffxct_gis_2022_" else "ncr_geo_census_cb_2010_"
    vapply(jsonlite::read_json(paste0(
      "https://raw.githubusercontent.com/uva-bi-sdad/dc.geographies/main/data/",
      pref, s[2], "/distribution/", pref, s[2], ".geojson"
    ))$features, function(d) as.character(d$properties$geoid), "")
  })
), use.names = FALSE)


## trim and save files
for (f in list.files("../capital_region/docs/data/original", full.names = TRUE)) {
  d <- read.csv(gzfile(f))
  nd <- d[!is.na(d$geoid) & !is.na(d$value) & !is.na(d$region_name),]
  cids <- nd$geoid
  su <- !grepl("_", nd$geoid, fixed = TRUE)
  cids[su] <- trimws(format(as.numeric(cids[su]), scientific = FALSE))
  nd$geoid <- as.character(cids)
  su <- which(!cids %in% ids)
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
  nd <- nd[cids %in% ids, colnames(nd) != "X"]
  if (nrow(nd)) {
    nd$region_type <- gsub("\\s+", "_", nd$region_type)
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

entity_info = jsonlite::read_json("../capital_region/docs/data/entity_info.json")
entity_info$zip_code <- lapply(entity_info$zip_code, function(l) {l$county = "51059"; l})
jsonlite::write_json(entity_info, "../capital_region/docs/data/entity_info.json", auto_unbox = TRUE)

data_add(
  c(
    county = "county.csv.xz",
    tract = "tract.csv.xz",
    block_group = "block_group.csv.xz",
    neighborhood = "neighborhood.csv.xz",
    "human_services_region" = "human_services_region.csv.xz",
    "planning_district" = "planning_district.csv.xz",
    "supervisor_district" = "supervisor_district.csv.xz",
    "zip_code" = "zip_code.csv.xz"
  ),
  rep(list(list(
    ids = list(
      variable = "ID",
      map = "data/entity_info.json"
    ),
    time = "time",
    variables = "measure_info.json"
  )), 8),
  dir = "../capital_region/docs/data",
  clean = TRUE,
  refresh = TRUE
)

site_build(
  "../capital_region", version = "dev", serve = TRUE,
  endpoint = "https://ncr-data-commons.netlify.app/api"
)
