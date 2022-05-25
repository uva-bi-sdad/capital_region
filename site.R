page_head(
  title = "National Capital Region",
  description = "A data site to explore data within the U.S. national capital region.",
  icon = "https://raw.githubusercontent.com/uva-bi-sdad/community/main/logo.svg"
)
page_navbar(
  title = "National Capital Region",
  logo = "https://raw.githubusercontent.com/uva-bi-sdad/community/main/logo.svg",
  input_button("Reset", "reset_selection", "reset.selection", class = "btn-link", note = "Reset the menu inputs to their defaults."),
  list(
    name = "Settings",
    backdrop = "false",
    class = "menu-compact",
    items = list(
      input_switch("Dark Theme", id = "settings.theme_dark"),
      input_switch(
        "Color by Rank", id = "settings.color_by_order",
        note = paste(
          "Switch from coloring by value to coloring by sorted index.",
          "This may help differentiate regions with similar values."
        )
      ),
      input_switch("Hide URL Settings", id = "settings.hide_url_parameters"),
      input_switch("Hide Tooltips", id = "settings.hide_tooltips"),
      input_number("Digits", "settings.digits", default = 2, min = 0, max = 6, floating_label = FALSE),
      input_select(
        "Color Scale Center", options = c("none", "median", "mean"), default = "none",
        display = c("None", "Median", "Mean"), id = "settings.color_scale_center",
        floating_label = FALSE,
        note = "Determines whether and on what the color scale should be centered."
      ),
      input_select(
        "Summary Level", options = c("dataset", "filtered", "all"), default = "dataset",
        display = c("All Regions", "Selected Region Types", "Selected Region"), id = "settings.summary_selection",
        floating_label = FALSE,
        note = paste(
          "Determines which regions are included in summaries for box-plots and color scaling;",
          "All-Regions are state-wide, Selected Region Types are filtered by the Region Types input, and",
          "Selected Region are filtered by region selection."
        )
      ),
      '<p class="section-heading">Map Options</p>',
      input_switch("Show Background Shapes", default_on = TRUE, id = "settings.background_shapes"),
      input_select(
        "Animations", c("fly", "zoom", "none"), "fly",
        note = "Fly animates the whole move to different regions; Zoom only animates changes in zoom level.",
        id = "settings.map_animations", floating_label = FALSE
      ),
      input_number(
        "Outline Weight", "settings.polygon_outline", default = 1.5, step = .5, floating_label = FALSE,
        note = "Thickness of the outline around region shapes."
      ),
      '<p class="section-heading">Plot Options</p>',
      input_select("Plot Type", c("scatter", "bar"), "scatter", id = "plot_type", floating_label = FALSE),
      input_switch("Box Plots", default_on = TRUE, id = "settings.boxplots"),
      input_switch(
        "Use IQR Whiskers", default_on = TRUE, id = "settings.iqr_box",
        note = "Define the extreme fences of the box plots by 1.5 * interquartile range (true) or min and max (false)."
      ),
      input_number(
        "Trace Limit", "settings.trace_limit", default = 20, floating_label = FALSE,
        note = "Limit the number of plot traces that can be drawn, split between extremes of the variable."
      ),
      '<p class="section-heading">Table Options</p>',
      input_switch("Autoscroll", default_on = TRUE, id = "settings.table_autoscroll"),
      input_select(
        "Scroll Behavior", c("instant", "smooth", "auto"), "auto",
        id = "settings.table_scroll_behavior", floating_label = FALSE
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
        input_button("Download All Data", "export", query = list(
          features = list(geoid = "id", name = "name")
        ), class = "btn-full"),
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
        "Shapes", c("tract", "neighborhood"), 0, c("Census", "Neighborhood"),
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
      vars <- jsonlite::read_json('../capital_region/docs/data/measure_info.json')
      varcats <- Filter(nchar, unique(vapply(vars, function(v) if (is.null(v$category)) "" else v$category, "")))
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
      input_number(
        "First Year", "min_year", default = "min", max = "max_year", dataview = "primary_view",
        note = paste(
          "First year to display in the plot and rank table, between the variable's first",
          "available year and the specified last year."
        )
      ),
      input_number(
        "Last Year", "max_year", default = "max", min = "min_year", dataview = "primary_view",
        note = paste(
          "Last year to display in the plot and rank table, between the specified first year",
          "and variable's last available year."
        )
      ),
      breakpoints = "md"
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
input_variable("set_palette", list(
  "settings.color_by_order" = "lajolla"
), "vik")
input_dataview(
  "primary_view",
  y = "selected_variable",
  x = "selected_year",
  dataset = "shapes",
  ids = "selected_region",
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
  ),
  palette = "set_palette"
)
page_section(
  type = "col",
  output_text(c(
    "(National Capital Region)[r selected_county]",
    "? > {selected_county}[r selected_tract]",
    "? > {selected_tract}"
  ), class = "compact"),
  output_text(list(
    "default" = "National Capital Region",
    "selected_county && shapes == tract" = "{selected_county} Tracts",
    "selected_county && shapes == neighborhood" = "{selected_county} Neighborhoods",
    "selected_tract" = "{selected_tract} Block Groups"
  ), tag = "h1", class = "text-center"),
  page_section(
    type = "container-xsm",
    input_number(
      "Selected Year", min = "min_year", max = "max_year", default = "max",
      id = "selected_year", buttons = TRUE, note = paste(
        "Year of the selected variable to color the map shapes and plot elements by, and to show on hover."
      )
    )
  ),
  page_section(
    type = "row",
    wraps = "col",
    sizes = c(NA, 5),
    output_map(
      rev(c(
        lapply(list(c("county", "counties"), c("tract", "census_tracts"), c("block_group", "census_block_groups")), function(s) list(
          name = s[1],
          url = paste0(
            "https://raw.githubusercontent.com/uva-bi-sdad/dc.geographies/main/data/ncr_geo_census_cb_2010_",
            s[2], "/distribution/ncr_geo_census_cb_2010_", s[2], ".geojson"
          )
        )),
        list(list(
          name = "neighborhood",
          url = "https://raw.githubusercontent.com/uva-bi-sdad/capital_region/main/docs/data/neighborhoods.geojson"
        ))
      )),
      dataview = "primary_view",
      click = "region_select",
      id = "main_map",
      subto = c("main_plot", "rank_table", "main_legend"),
      options = list(
        attributionControl = FALSE,
        scrollWheelZoom = FALSE,
        center = c(38.9936, -77.3135),
        zoom = 8,
        height = "430px",
        zoomAnimation = "settings.map_zoom_animation"
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
        dataview = "primary_view",
        id = "variable_info_pane",
      ),
      page_section(
        wraps = "col", sizes = c(8, NA),
        output_info(body = "variables.sources", dataview = "primary_view"),
        page_section(
          input_button(
            "Download", "export", dataview = "primary_view", query = list(
              include = "selected_variable",
              features = list(geoid = "id", name = "name")
            ), class = "btn-full"
          ),
          input_button(
            "Copy API link", "copy", dataview = "primary_view", query = list(
              include = "selected_variable", dataset = "shapes",
              features = list(geoid = "id", name = "name")
            ), class = "btn-full"
          )
        )
      ),
      page_section(
        wraps = "row",
        output_info(
          title = "features.name",
          default = c(title = "National Capital Region", body = "Hover over or select a region for more information."),
          dataview = "primary_view",
          subto = c("main_map", "main_plot", "rank_table", "main_legend")
        ),
        output_info(
          body = c(
            "variables.long_name" = "selected_variable",
            "variables.statement"
          ),
          row_style = c("stack", "table"),
          dataview = "primary_view",
          subto = c("main_map", "main_plot", "rank_table", "main_legend"),
          variable_info = FALSE
        )
      ),
      wraps = "row"
    )
  ),
  page_section(
    type = "row",
    wraps = "col",
    sizes = c(5, 7),
    page_section(
      output_legend(
        "settings.palette", dataview = "primary_view", click = "region_select",
        subto = c("main_map", "main_plot", "rank_table"), id = "main_legend"
      ),
      output_table("selected_variable", dataview = "primary_view", options = list(
        info = FALSE,
        searching = FALSE,
        scrollY = 300,
        dom = "<'row't>"
      ), id = "rank_table", click = "region_select", subto = c("main_map", "main_plot", "main_legend"))
    ),
    output_plot(
      x = "time", y = "selected_variable", dataview = "primary_view",
      click = "region_select", subto = c("main_map", "rank_table", "main_legend"), id = "main_plot",
      options = list(
        layout = list(
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
  )
)
