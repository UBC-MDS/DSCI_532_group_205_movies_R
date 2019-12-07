library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

# Load assets
app <- Dash$new(assets_folder = "assets")

app$layout(
  htmlDiv(list(
    htmlDiv(list(
      htmlDiv(list(
        htmlDiv(list(
          htmlP("Genres", className="app-main--container-title")
        ), className = "app-main--genre-container app-main--filter-panel"),
        htmlDiv(list(
          htmlP('test')
        ), className = "app-main--rating-container app-main--filter-panel"),
        htmlDiv(list(
          htmlP('test')
        ), className = "app-main--year-container app-main--filter-panel")
      ), className = "app-main--panel-left"),
      htmlDiv(list(
        htmlP('test')
      ), className = "app-main--panel-right")
    ), className = "app-main--container")
  ), className = "wrapper")
)

app$run_server()
