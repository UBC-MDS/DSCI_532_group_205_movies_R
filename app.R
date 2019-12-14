library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(ggplot2)
library(readr)
library(purrr)
library(dplyr)
library(plotly)

#
# Needed for deployment to Heroku
# Comment this out to run locally
#
setwd("/app")

source("src/chart_1.R")
source("src/chart_2.R")
source("src/data.R")
source("src/layout.R")

# Load assets
app <- Dash$new(assets_folder = "assets")

app$layout(get_layout())

app$callback(
  output=list(id = "upper-graph", property="figure"),

  params=list(input(id = "cb-genres", property = "value"),
              input(id = "cb-ratings", property = "value"),
              input(id = "release-year-range", property = "value")),

  function(genres, ratings, year_range) {
    df <- filter_data(genres, ratings, year_range)
    create_chart_1(df)
  })

app$callback(
  output=list(id = "lower-graph", property="figure"),

  params=list(input(id = "cb-genres", property = "value"),
              input(id = "cb-ratings", property = "value"),
              input(id = "release-year-range", property = "value"),
              input(id = "upper-graph", property = "clickData")),

  function(genres, ratings, year_range, click_data) {
    # Ranking is reversed. The first data point is movie #10, 10th is movie #1
    y <- 10 - click_data$points[[1]]$pointIndex

    df <- filter_data(genres, ratings, year_range)
    create_chart_2(df, y)
  })


app$run_server(host = "0.0.0.0", port = Sys.getenv('PORT', 8050))
