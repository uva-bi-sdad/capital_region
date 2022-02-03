# National Capital Region Data

This site was generated with these commands:
```R
# remotes::install_github("uva-bi-sdad/community")
library(community)

# create initial files and directory structure
# (running from the desired parent directory)
init_site("../capital_region", "capital_region")

# aggregate and reformat files placed in the `original` directory
data_reformat_sdad(
  "../capital_region/docs/data/original",
  formatters = list(region_name = function(x) sub(",.*$", "", x)),
  out = "../capital_region/docs/data"
)

# then run
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
  refresh = TRUE
)

# create the referred to `measures_info.json` with variable metadata,
# and read it in here just to get the documented subset of variables if needed
meta <- jsonlite::read_json("../capital_region/docs/data/measure_info.json")

# edit site.R, and add some styling to docs/style.css, then run
# (add `bundle_data = TRUE` or run `npm start` from a console to run locally)
site_build("../capital_region", variables = names(meta))
```