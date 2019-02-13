.libPaths(c('libs', .libPaths()))
library(teal)

ASL <- generate_sample_data('ASL')
ARS <- generate_sample_data('ARS')
ATE <- generate_sample_data('ATE')

x <- teal::init(
  data =  list(ASL = ASL, ARS = ARS, ATE = ATE),
  modules = root_modules(
    module(
      "data source",
      server = function(input, output, session, datasets) {},
      ui = function(id) div(p("information about data source")),
      filters = NULL
    ),
    tm_data_table(),
    tm_variable_browser(),
    modules(
      label = "analysis items",
      tm_table(
        label = "demographic table",
        dataname = "ASL",
        xvar = "SEX",
        yvar = "RACE",
        yvar_choices = c("RACE", "AGEGR", "REGION")
      ),
      tm_scatterplot(
        label = "scatterplot",
        dataname = "ASL",
        xvar = "AGE",
        yvar = "BBMI",
        color_by = "_none_",
        color_by_choices = c("_none_", "STUDYID")
      ),
      module(
        label = "survival curves",
        server = function(input, output, session, datasets) {},
        ui = function(id) div(p("Kaplan Meier Curve")),
        filters = "ATE"
      )
    )
  ),
  header = tags$h1("Sample App"),
  footer = tags$p("Copyright 2017")
)

shinyApp(x$ui, x$server)