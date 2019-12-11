library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(tidyverse)
library(plotly)

source("src/chart_1.R")
source("src/chart_2.R")
source("src/main.R")

app$run_server()
