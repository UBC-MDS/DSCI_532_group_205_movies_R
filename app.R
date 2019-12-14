library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

setwd("/app")
source("src/chart_1.R")
source("src/chart_2.R")
source("src/main.R")

app$run_server(host = "0.0.0.0", port = Sys.getenv('PORT', 8050))
