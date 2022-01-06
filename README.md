# National Capital Region Data

This site was generated with these commands:
```R
# remotes::install_github("uva-bi-sdad/community")
library(community)

# create initial files and directory structure
# (running from the desired parent directory)
init_site("../capital_region", "capital_region")

# aggregate and reformat files placed in the `original` directory
data_reformat_sdad("../capital_region/docs/data/original", out = "../capital_region/docs/data")

# then run
data_add(
  c(
    county = "county.csv",
    tract = "tract.csv",
    block_group = "block_group.csv"
  ),
  lapply(c("counties", "tracts", "blockgroups"), function(s){
    list(
      ids = list(
        variable = "ID",
        map = unlist(lapply(
          jsonlite::read_json(paste0(
            "https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/", s, ".geojson"
          ))$features,
          function(f){
            res <- list(list(name = f$properties$NAME))
            names(res) <- f$properties$GEOID
            res
          }
        ), FALSE)
      ),
      time = "time",
      variables = "measures_info.json"
    )
  }),
  dir = "../capital_region/docs/data",
  refresh = TRUE
)

# create the referred to `measures_info.json` with variable metadata,
# and read it in here just to get the documented subset of variables if needed
meta <- jsonlite::read_json("../capital_region/docs/data/measures_info.json")

# edit site.R, and add some styling to docs/style.css, then run
# (add `bundle_data = TRUE` or run `npm start` from a console to run locally)
site_build("../capital_region", variables = names(meta))
```