library(community)

init_site("../capital_region", "capital_region")

data_reformat_sdad(
  "../capital_region/docs/data/original",
  formatter = list(region_name = function(x) sub(",.*$", "", x)),
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
        variables = "measures_info.json"
      )
    }),
    list(list(
      ids = list(variable = "ID", map = "data/entity_info.json"),
      time = "time",
      variables = "measures_info.json"
    ))
  ),
  dir = "../capital_region/docs/data",
  refresh = TRUE
)

meta <- jsonlite::read_json("../capital_region/docs/data/measures_info.json")
site_build("../capital_region", variables = names(meta))
