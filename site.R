library(community)
page_head(
  title = "National Capital Region",
  description = "A data site to explore data within the U.S. national capital region.",
  icon = "https://raw.githubusercontent.com/uva-bi-sdad/community/main/logo.svg"
)
page_navbar(
  title = "National Capital Region",
  logo = "https://raw.githubusercontent.com/uva-bi-sdad/community/main/logo.svg",
  input_button("Reset", "reset_selection", "reset.selection", class = "btn-link"),
  list(
    name = "Settings",
    backdrop = "false",
    items = list(
      input_switch("Dark Theme", id = "settings.theme_dark"),
      input_select("Color Palette", options = "palettes", id = "settings.palette", floating_label = FALSE),
      input_switch(
        "Color by Order", id = "settings.color_by_order",
        title = paste(
          "Switch from coloring by value to coloring by sorted index.",
          "This may help differentiate regions with similar values."
        )
      ),
      input_switch("Hide URL Settings", id = "settings.hide_url_parameters"),
      input_number("Digits", "settings.digits", min = 0, max = 6, floating_label = FALSE),
      input_select(
        "Summary Level", options = c("dataset", "all"), default = "dataset",
        display = c("All Regions", "Selected Region"), id = "settings.summary_selection",
        floating_label = FALSE,
        title = paste(
          "Determins which regions are included in summaries for box-plots and color scaling;",
          "All-Regions are state-wide, and Selected Region are filtered by region selection."
        )
      ),
      input_number("Variable Min", "variable_min", step = 1, floating_label = FALSE),
      input_number("Variable Max", "variable_max", step = 1, floating_label = FALSE),
      '<p class="section-heading">Map Options</p>',
      input_switch("Show Background Shapes", id = "settings.background_shapes"),
      '<p class="section-heading">Plot Options</p>',
      input_select("Plot Type", c("scatter", "bar"), "scatter", id = "plot_type", floating_label = FALSE),
      input_switch("Box Plots", default_on = TRUE, id = "settings.boxplots"),
      input_switch(
        "Use IQR Whiskers", default_on = TRUE, id = "settings.iqr_box",
        title = "Define the outer fences of the box plots by the first and third quantiles -/+ 1.5 * interquartile range (true) or min and max (false)"
      ),
      input_button("Clear Settings", "reset_storage", "clear_storage", class = "btn-danger footer")
    )
  ),
  list(
    name = "About",
    items = list(
      page_text(c(
        paste0(
          "This site was made by the [Social and Decision Analytics Division]",
          "(https://biocomplexity.virginia.edu/institute/divisions/social-and-decision-analytics)",
          " of the [Biocomplexity Institute](https://biocomplexity.virginia.edu)."
        ),
        "View its source on [GitHub](https://github.com/uva-bi-sdad/capital_region).",
        "Credits",
        paste(
          "Built in [R](https://www.r-project.org) with the",
          "[community](https://uva-bi-sdad.github.io/community) package, using these resources:"
        )
      ), class = c("", "", "h5")),
      output_credits()
    )
  )
)
page_menu(
  page_section(
    type = "col",
    wraps = "row form-row",
    input_select(
      "Counties", options = "ids", dataset = "county", dataview = "primary_view",
      id = "selected_county", reset_button = TRUE
    ),
    page_section(
      type = "row form-row",
      wraps = "col",
      sizes = c(4, 8),
      input_checkbox(
        "Shapes", c("tract", "civic_association"), 0, c("Census", "Civic"),
        id = "shape_type", multi = FALSE
      ),
      input_select(
        "Census Tracts", options = "ids", dataset = "tract", dataview = "primary_view",
        id = "selected_tract", reset_button = TRUE
      )
    ),
    conditions = c("", "selected_county")
  ),
  page_section(
    type = "col",
    wraps = "row form-row",
    {
      vars <- jsonlite::read_json('../capital_region/docs/data/measures_info.json')
      varcats <- Filter(nchar, unique(vapply(vars, function(v) if(is.null(v$category)) "" else v$category, "")))
      input_select("Variable Category", options = varcats, default = "Broadband", id = "variable_type")
    },
    input_select(
      "Variable", options = "variables",
      default = "speed_measurements:avg_down_using_devices", depends = "shapes",
      id = "selected_variable", filters = list(category = "variable_type")
    )
  ),
  page_section(
    type = "col",
    page_section(
      type = "row",
      wraps = "col",
      input_number("First Year", "min_year", default = "min", max = "max_year", dataview = "primary_view"),
      input_number("Selected Year", min = "min_year", max = "max_year", default = "max", id = "selected_year"),
      input_number("Last Year", "max_year", default = "max", min = "min_year", dataview = "primary_view"),
      breakpoints = "md",
      sizes = c(3, NA, 3)
    )
  ),
  position = "top",
  default_open = TRUE,
  sizes = c(NA, NA, 4)
)
input_variable("shapes", list(
  "selected_county && !selected_tract" = "shape_type",
  "selected_tract && shape_type == tract" = "block_group"
), "county")
input_variable("region_select", list(
  "shapes == county" = "selected_county"
), "selected_tract")

input_variable("selected_region", list(
  "selected_tract" = "selected_tract"
), "selected_county")
input_dataview(
  "primary_view",
  y = "selected_variable",
  x = "selected_year",
  dataset = "shapes",
  ids = "selected_region",
  variables = list(
    list(variable = "selected_variable", type = "<=", value = "variable_min"),
    list(variable = "selected_variable", type = ">=", value = "variable_max")
  ),
  time = "time",
  time_agg = "selected_year",
  time_filters = list(
    list(
      variable = "time",
      type = ">=",
      value = "min_year"
    ),
    list(
      variable = "time",
      type = "<=",
      value = "max_year"
    )
  )
)
page_section(
  type = "col",
  output_text(c(
    "(National Capital Region)[r selected_county]",
    "? > {selected_county}[r selected_tract]",
    "? > {selected_tract}"
  )),
  output_text(list(
    "default" = "National Capital Region",
    "selected_county && shapes == tract" = "{selected_county} Tracts",
    "selected_county && shapes == civic_association" = "{selected_county} Civic Associations",
    "selected_tract" = "{selected_tract} Block Groups"
  ), tag = "h1", class = "text-center"),
  page_section(
    type = "row",
    wraps = "col",
    sizes = c(NA, 4),
    output_map(
      c(
        lapply(list(c("county", "counties"), c("tract", "tracts"), c("block_group", "blockgroups")), function(s) list(
          name = s[1],
          url = paste0("https://uva-bi-sdad.github.io/community/dist/shapes/capital_region/", s[2], ".geojson")
        )),
        list(list(name = "civic_association", url = "../capital_region/docs/data/civic_associations.geojson"))
      ),
      dataview = "primary_view",
      click = "region_select",
      id = "main_map",
      subto = "main_plot",
      options = list(
        attributionControl = FALSE,
        scrollWheelZoom = FALSE,
        center = c(38.9936, -77.3135),
        zoom = 8,
        height = "430px"
      ),
      background_shapes = "tract",
      tiles = list(
        light = list(url = "https://stamen-tiles-{s}.a.ssl.fastly.net/toner-lite/{z}/{x}/{y}{r}.png"),
        dark = list(url = "https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png")
      ),
      attribution = list(
        list(
          name = "Stamen toner-light",
          url = "https://stamen.com",
          description = "Light-theme map tiles by Stamen Design"
        ),
        list(
          name = "CARTO Dark Matter",
          url = "https://carto.com/attributions",
          description = "Dark-theme map tiles by CARTO"
        ),
        list(
          name = "OpenStreetMap",
          url = "https://www.openstreetmap.org/copyright"
        )
      )
    ),
    page_section(
      type = "d-flex flex-column col align-items-end compact",
      output_info(
        title = "variables.short_name",
        body = c(Year = "data.time", "variables.source"),
        dataview = "primary_view",
        id = "variable_info_pane",
      ),
      page_section(
        wraps = "row",
        output_info(
          title = "features.name",
          default = c(title = "National Capital Region", body = "Hover over or select a region for more information."),
          dataview = "primary_view",
          subto = c("main_map", "main_plot")
        ),
        output_info(
          body = c(
            "variables.long_name" = "selected_variable",
            "variables.statement"
          ),
          row_style = c("table", "stack"),
          dataview = "primary_view",
          subto = c("main_map", "main_plot"),
          variable_info = FALSE
        )
      ),
      output_legend("settings.palette", "Below", "Region Median", "Above"),
      wraps = c("row", "row mb-auto", "row")
    )
  ),
  page_section(
    type = "row",
    wraps = "col",
    sizes = c(7, 5),
    page_tabgroup(
      list(
        name = "Plot",
        output_plot(
          x = "time", y = "selected_variable", dataview = "primary_view",
          click = "region_select", subto = "main_map", id = "main_plot",
          options = list(
            layout = list(
              showlegend = FALSE,
              xaxis = list(title = FALSE, fixedrange = TRUE),
              yaxis = list(fixedrange = TRUE, zeroline = FALSE)
            ),
            data = data.frame(
              type = c("plot_type", "box"), fillcolor = c(NA, "transparent"),
              hoverinfo = c("text", NA), mode = "lines+markers", showlegend = FALSE,
              name = c(NA, "Summary"), marker.line.color = "#767676", marker.line.width = 1
            ),
            config = list(modeBarButtonsToRemove = c("select2d", "lasso2d", "sendDataToCloud"))
          )
        )
      ),
      list(
        name = "Data",
        output_table(
          dataview = "primary_view", wide = FALSE, filters = list(category = "variable_type"),
          features = c(ID = "id", Name = "name"),
          options = list(
            scrollY = 400,
            rowGroup = list(dataSrc = "features.name"),
            columnDefs = list(list(targets = "features.name", visible = FALSE)),
            buttons = c('copy', 'csv', 'excel', 'print'),
            dom = "<'row't><'row'<'col-sm'B><'col'f>>"
          )
        )
      )
    ),
    output_table("selected_variable", dataview = "primary_view", options = list(
      info = FALSE,
      searching = FALSE
    ))
  )
)

vars <- jsonlite::read_json('../capital_region/docs/data/measures_info.json')
site_build('../capital_region', variables = names(vars))
